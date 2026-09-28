;; -*- lexical-binding: t; -*-

(require 'cl-lib)
(require 'subr-x)
(require 'org)
;; `org-clocking', `org-clock-in' and `org-clock-out' live in org-clock,
;; which `org' does not pull in. The timer reads the clock table on every
;; tick, so require it up front rather than lazily.
(require 'org-clock)

  (defgroup my-pomodoro nil
    "A strict pomodoro timer that drives org clocking."
    :group 'tools
    :prefix "my-pomodoro-")

  (defcustom my-pomodoro-focus-length 25
    "Length of a focus session, in minutes."
    :type 'natnum)

  (defcustom my-pomodoro-short-break-length 5
    "Length of a short break, in minutes."
    :type 'natnum)

  (defcustom my-pomodoro-long-break-length 15
    "Length of a long break, in minutes."
    :type 'natnum)

  (defcustom my-pomodoro-rounds-before-long-break 4
    "Number of completed focus sessions before a long break."
    :type 'natnum)

  (defcustom my-pomodoro-clock-org t
    "Clock an org task for the duration of each focus session.
     When nil, sessions run without touching org clocking."
    :type 'boolean)

  (defcustom my-pomodoro-notify t
    "Send a macOS notification when a session or break ends."
    :type 'boolean)

  (defcustom my-pomodoro-task-files nil
    "Org files scanned for the tasks that can be clocked in.
When nil, fall back to `org-agenda-files' at call time, so the picker
offers the same set of tasks the agenda does.  Set this to a list of
files to restrict the picker to something narrower."
    :type '(choice (const :tag "Agenda files" nil)
                   (repeat :tag "Files" file)
                   (directory :tag "Directory")))

(defconst my-pomodoro--phases
    '((focus       . "Focus")
      (short-break . "Short break")
      (long-break  . "Long break"))
    "The pomodoro phases, with their human readable names.")

  (defun my-pomodoro--phase-name (phase)
    "Return the display name of PHASE."
    (or (cdr (assq phase my-pomodoro--phases))
        (format "%s" phase)))

  (defun my-pomodoro--phase-length (phase)
    "Return the length of PHASE in seconds."
    (pcase phase
      ('focus       (* 60 my-pomodoro-focus-length))
      ('short-break (* 60 my-pomodoro-short-break-length))
      ('long-break  (* 60 my-pomodoro-long-break-length))
      (_ (error "Unknown pomodoro phase: %S" phase))))

  (defun my-pomodoro--phase-icon (phase)
    "Return a display icon for PHASE."
    (pcase phase
      ('focus       "🍅")
      ('short-break "☕")
      ('long-break  "🌴")
      (_ "•")))

  (cl-defstruct (my-pomodoro--session
                 (:constructor my-pomodoro--session-make)
                 (:copier nil))
    phase
    end-time
    remaining
    paused
    clocked-headline
    clocked-file)

  (defvar my-pomodoro--current nil
    "The active session, or nil.")

  (defvar my-pomodoro--pending nil
    "Phase that has become due and is waiting to be started.")

  (defvar my-pomodoro--tick-timer nil
    "Timer driving the one second tick.")

  (defvar my-pomodoro--rounds 0
    "Number of focus sessions completed today.")

  (defvar my-pomodoro--rounds-date nil
    "Calendar day (%F form) on which `my-pomodoro--rounds' was last counted.
A string rather than a `current-time' value, since those carry sub-second
precision and would never compare equal on a later call.")

  (defvar my-pomodoro--task-history nil
    "Minibuffer history of task selection.")

  (defun my-pomodoro-running-p ()
    "Return non-nil when a session is running."
    (and my-pomodoro--current t))

  (defun my-pomodoro--remaining ()
    "Return the seconds left in the active session."
    (when-let* ((session my-pomodoro--current))
      (if (my-pomodoro--session-paused session)
          (my-pomodoro--session-remaining session)
        ;; `round' rather than `truncate', so a session that has just
        ;; started still reads as a full 25:00 rather than 24:59.
        (max 0 (round
                (float-time (time-subtract
                             (my-pomodoro--session-end-time session) nil)))))))

  (defun my-pomodoro--today-rounds ()
    "Return today's focus session count, resetting it on a new day."
    (let ((today (format-time-string "%F")))
      (unless (equal my-pomodoro--rounds-date today)
        (setq my-pomodoro--rounds 0
              my-pomodoro--rounds-date today))
      my-pomodoro--rounds))

  (defun my-pomodoro--round-display ()
    "Return the number of the next focus session within the current set.
Goes through `my-pomodoro--today-rounds' so a session left running
across midnight shows the new day's count rather than yesterday's."
    (1+ (mod (my-pomodoro--today-rounds)
             my-pomodoro-rounds-before-long-break)))

(declare-function ns-do-applescript "osx-lib" (script &optional nosec))
  (declare-function org-clocking-p "org-clock")
  (declare-function org-clock-in "org-clock")
  (declare-function org-clock-out "org-clock" (&optional arg fail-quietly at-time))
  (declare-function org-entry-get "org")
  (declare-function org-get-heading "org")
  (declare-function org-map-entries "org")
  (declare-function file-name-nondirectory "files")
  (declare-function run-at-time "timer")
  (declare-function cancel-timer "timer")

  (defun my-pomodoro--start-ticking ()
    "Start the one second tick unless it is already running."
    (unless (timerp my-pomodoro--tick-timer)
      (setq my-pomodoro--tick-timer (run-at-time t 1 #'my-pomodoro--tick))))

  (defun my-pomodoro--stop-ticking ()
    "Stop the one second tick."
    (when (timerp my-pomodoro--tick-timer)
      (cancel-timer my-pomodoro--tick-timer)
      (setq my-pomodoro--tick-timer nil)))

  (defun my-pomodoro--tick ()
    "Repaint the countdown and detect the end of a session."
    (when (my-pomodoro-running-p)
      (if (and (not (my-pomodoro--session-paused my-pomodoro--current))
               (<= (my-pomodoro--remaining) 0))
          (my-pomodoro--complete)
        (my-pomodoro--refresh-mode-line))))

  (defun my-pomodoro--next-phase (phase round)
    "Return the phase that follows PHASE.

ROUND is the number of focus sessions completed *including* the one
just finished, which is what `my-pomodoro--complete' passes, so a
long break is due exactly when that total divides evenly."
    (pcase phase
      ('focus (if (zerop (mod round my-pomodoro-rounds-before-long-break))
                  'long-break
                'short-break))
      (_ 'focus)))

  (defun my-pomodoro--complete ()
    "Finish the active session and mark the next phase as due."
    (let* ((session my-pomodoro--current)
           (phase (my-pomodoro--session-phase session)))
      (my-pomodoro--today-rounds)
      (when (eq phase 'focus)
        (cl-incf my-pomodoro--rounds))
      (let ((next (my-pomodoro--next-phase phase my-pomodoro--rounds)))
        (my-pomodoro--stop-ticking)
        (my-pomodoro--clock-out session)
        (setq my-pomodoro--current nil
              my-pomodoro--pending next)
        (my-pomodoro--notify
         (format "%s complete" (my-pomodoro--phase-name phase))
         (if (eq next 'focus)
             (format "Focus %d/%d ready."
                     (my-pomodoro--round-display)
                     my-pomodoro-rounds-before-long-break)
           (format "%s ready." (my-pomodoro--phase-name next))))
        (my-pomodoro--refresh-mode-line))))

(defun my-pomodoro--clocked-entry ()
    "Return a plist describing the currently clocked org entry, or nil.
Org provides no `org-clocking' function, so read `org-clocking-p',
`org-clock-marker' and `org-clock-heading' directly. The plist has
:file, :headline and :marker keys."
    (when (org-clocking-p)
      (let ((buffer (marker-buffer org-clock-marker)))
        (list :file (and buffer (buffer-file-name buffer))
              :headline org-clock-heading
              :marker org-clock-marker))))

  (defun my-pomodoro--todo-p ()
    "Return non-nil when point is on an open, actionable org entry.
`org-todo-keywords-1' is a flat list of keyword strings, so exclude
`org-done-keywords' rather than taking the car of each element.
Read the keyword from `org-entry-get' rather than the org element, so
that this does not force a parse of every heading in the file."
    (let ((state (org-entry-get nil "TODO")))
      (and (stringp state)
           (member state org-todo-keywords-1)
           (not (member state org-done-keywords)))))

  (defun my-pomodoro--task-scope ()
    "Return the org files to scan for clockable tasks, or nil for none.
`my-pomodoro-task-files' when set, otherwise `org-agenda-files' so the
picker and the agenda agree.  Resolved on every call rather than at
load time, because the org config runs before this one.  A lone string
is read as a single file, or as a directory to expand."
    (let ((files (or my-pomodoro-task-files
                   (bound-and-true-p org-agenda-files))))
      (cond ((null files) nil)
            ((not (stringp files)) files)
            ((file-directory-p files)
             (directory-files files nil "\\.org\\'" t))
            (t (list files)))))

  (defun my-pomodoro--task-candidates ()
    "Return a list of (LABEL . MARKER) pairs for open org entries.
LABEL names the file and headline so the candidates can be told apart
in the picker; MARKER points at the entry itself.
The headline is stripped of its fontification text properties, both to
keep the labels small and because completion matches on the string
itself.
`org-map-entries' takes the files to scan as its third argument, after
the match expression.  Passing them second is read as a tag match and
silently searches the current buffer instead.  The body must return the
pair itself rather than a list wrapping it, and the nil from headings
that are not open TODO entries has to be dropped afterwards."
    (let ((scope (my-pomodoro--task-scope)))
      (when scope
        (delq nil
              (org-map-entries
               (lambda ()
                 (when (my-pomodoro--todo-p)
                   (let* ((marker (point-marker))
                          (file (file-name-nondirectory (or (buffer-file-name) "")))
                          (headline (substring-no-properties
                                     (or (org-get-heading nil t) "")))
                          (label (format "%s  %s" file headline)))
                     (cons label marker))))
               nil
               scope)))))

  (defun my-pomodoro--select-task ()
    "Prompt for an open org entry and return a marker at it, or nil."
    (let* ((candidates (my-pomodoro--task-candidates))
           ;; CANDIDATES is already a (LABEL . MARKER) alist, and
           ;; `completing-read' completes over the CARs, so the label
           ;; doubles as the completion string and the marker rides along
           ;; in the cdr.  That also keeps the minibuffer history free of
           ;; markers, which die along with their buffer.
           ;; Prompting with an empty collection accepts any string at
           ;; all, so no candidates has to short-circuit before we ask.
           (label (and candidates
                       (completing-read
                        "Focus on: " candidates nil nil nil #'identity
                        'my-pomodoro--task-history)))
           ;; `assoc-string' hands back the whole matched pair, so the
           ;; marker is its cdr.  It matches on string value, unlike
           ;; `assoc': the labels are built with `format' and so are never
           ;; `eq' to a literal a caller might compare against.
           (entry (and label (assoc-string label candidates))))
      ;; The marker is the cdr of the selected (LABEL . MARKER) pair.
      (cdr entry)))

  (defun my-pomodoro--clock-in (marker)
    "Clock in at MARKER and return the headline that was clocked.
Return nil if the entry could not be clocked, so the caller can
avoid recording a headline that is not actually active."
    (with-current-buffer (marker-buffer marker)
      (goto-char marker)
      (org-clock-in))
    ;; Read the headline back from the clock table rather than from the
    ;; buffer, so it is exactly what `my-pomodoro--clock-out' will
    ;; compare against later.
    (plist-get (my-pomodoro--clocked-entry) :headline))

  (defun my-pomodoro--ensure-clocked (session)
    "Ensure an org task is clocked for SESSION, prompting if needed."
    (unless (my-pomodoro--clocked-entry)
      (let* ((marker (my-pomodoro--select-task))
             (buffer (and marker (marker-buffer marker))))
        (unless buffer
          (user-error "No task selected"))
        (let ((file (buffer-file-name buffer))
              (headline (my-pomodoro--clock-in marker)))
          (unless headline
            (user-error "Could not clock in to the selected task"))
          (setf (my-pomodoro--session-clocked-headline session) headline
                (my-pomodoro--session-clocked-file session) file)))))

  (defun my-pomodoro--clock-out (session)
    "Clock out of the task SESSION started, if it is still the active one.
Return t when this call did the clock out, nil when it deliberately
declined, which happens when nothing is clocked or when the running
clock is a different task than the one SESSION owns."
    (let ((headline (my-pomodoro--session-clocked-headline session)))
      (when headline
        (let ((entry (my-pomodoro--clocked-entry)))
          (when (and entry
                     (equal (plist-get entry :headline) headline)
                     (equal (plist-get entry :file)
                            (my-pomodoro--session-clocked-file session)))
            ;; FAIL-QUIETLY: the session owning the clock is authoritative,
            ;; so never raise if org considers the clock already stopped.
            (org-clock-out nil t)
            t)))))

(defun my-pomodoro--applescript-escape (string)
    "Escape STRING for use inside an AppleScript string literal.
Both double quotes and backslashes are prefixed with a backslash."
    ;; NB: a FUNCTION replacement would be re-expanded by `replace-match',
    ;; which would then choke on the backslashes we are trying to insert,
    ;; so use a replacement string instead.  The replacement is the four
    ;; characters backslash backslash backslash ampersand: `\\' inserts a
    ;; literal backslash and `\&' re-inserts the whole match, which covers
    ;; both the quote and the backslash case.
    (replace-regexp-in-string "[\"\\\\]" "\\\\\\&" (or string "")))

  (defun my-pomodoro--notify (title body)
    "Send a macOS notification with TITLE and BODY."
    (message "%s: %s" title body)
    (when (and my-pomodoro-notify
               (fboundp 'ns-do-applescript))
      (ns-do-applescript
       (format "display notification \"%s\" with title \"%s\""
               (my-pomodoro--applescript-escape body)
               (my-pomodoro--applescript-escape title)))))

(defun my-pomodoro--start (phase)
    "Start a session in PHASE."
    (when (my-pomodoro-running-p)
      (user-error "A pomodoro session is already running"))
    (let ((session (my-pomodoro--session-make
                    :phase phase
                    :end-time (time-add (current-time)
                                        (my-pomodoro--phase-length phase)))))
      (when (and (eq phase 'focus) my-pomodoro-clock-org)
        (my-pomodoro--ensure-clocked session))
      (setq my-pomodoro--current session
            my-pomodoro--pending nil)
      (my-pomodoro--today-rounds)
      (my-pomodoro--start-ticking)
      (my-pomodoro--refresh-mode-line)
      (message "Pomodoro %s started, %d minutes."
               (downcase (my-pomodoro--phase-name phase))
               (/ (my-pomodoro--phase-length phase) 60))))

  (defun my-pomodoro-start ()
    "Start the pending phase, or a focus session if none is due."
    (interactive)
    (my-pomodoro--start (or my-pomodoro--pending 'focus)))

  (defun my-pomodoro-start-focus ()
    "Start a focus session."
    (interactive)
    (my-pomodoro--start 'focus))

  (defun my-pomodoro--long-break-due-p ()
    "Return non-nil when the number of completed focus sessions is due a long break.
A long break is due once every `my-pomodoro-rounds-before-long-break'
focus sessions, so the count has to be a *positive* multiple: with none
completed there is nothing to have earned one yet."
    (let ((rounds (my-pomodoro--today-rounds)))
      (and (plusp rounds)
           (zerop (mod rounds my-pomodoro-rounds-before-long-break)))))

  (defun my-pomodoro-start-break ()
    "Start a short break, or a long one when one is due."
  (interactive)
  ;; A break follows a focus session, so it earns a long one exactly when
  ;; the completed count is a positive multiple of the round length.  The
  ;; pending phase is checked first so an earned long break is honoured
  ;; even if the counter was reset in between.
  (my-pomodoro--start
   (if (or (eq my-pomodoro--pending 'long-break)
           (my-pomodoro--long-break-due-p))
       'long-break
     'short-break)))

  (defun my-pomodoro-stop ()
    "Stop the active session, asking whether it was completed."
    (interactive)
    (unless (my-pomodoro-running-p)
      (user-error "No pomodoro session is running"))
    (let* ((session my-pomodoro--current)
           (phase (my-pomodoro--session-phase session))
           (completed (and (eq phase 'focus)
                           (y-or-n-p "Did you complete this focus session? "))))
      (my-pomodoro--stop-ticking)
      (my-pomodoro--today-rounds)
      (when completed
        (cl-incf my-pomodoro--rounds))
      (my-pomodoro--clock-out session)
      ;; A focus session stopped as completed ends the same way one that
      ;; ran to the end of its clock does, so it still owes a break.  An
      ;; abandoned session owes nothing.
      (setq my-pomodoro--current nil
            my-pomodoro--pending
            (and completed
                 (my-pomodoro--next-phase 'focus my-pomodoro--rounds)))
      (my-pomodoro--notify
       (format "%s stopped" (my-pomodoro--phase-name phase))
       (if completed "Counted as complete." "Not counted."))
      (my-pomodoro--refresh-mode-line)))

  (defun my-pomodoro-pause ()
    "Pause the active session."
    (interactive)
    (let ((session my-pomodoro--current))
      (unless session
        (user-error "No pomodoro session is running"))
      (when (my-pomodoro--session-paused session)
        (user-error "Session is already paused"))
      (setf (my-pomodoro--session-remaining session) (my-pomodoro--remaining)
            (my-pomodoro--session-paused session) t)
      (my-pomodoro--stop-ticking)
      (my-pomodoro--refresh-mode-line)
      (message "Pomodoro paused at %s."
               (my-pomodoro--format-seconds
                (my-pomodoro--session-remaining session)))))

  (defun my-pomodoro-resume ()
    "Resume the paused session."
    (interactive)
    (let ((session my-pomodoro--current))
      (unless (and session (my-pomodoro--session-paused session))
        (user-error "No paused pomodoro session"))
      (setf (my-pomodoro--session-paused session) nil
            (my-pomodoro--session-end-time session)
            (time-add (current-time)
                      (my-pomodoro--session-remaining session)))
      (my-pomodoro--start-ticking)
      (my-pomodoro--refresh-mode-line)
      (message "Pomodoro resumed.")))

  (defun my-pomodoro-toggle-pause ()
    "Pause the running session, or resume a paused one."
    (interactive)
    (if (and my-pomodoro--current
             (my-pomodoro--session-paused my-pomodoro--current))
        (my-pomodoro-resume)
      (my-pomodoro-pause)))

  (defun my-pomodoro-reset ()
    "Reset today's focus session counter and clear any due phase."
    (interactive)
    (setq my-pomodoro--rounds 0
          my-pomodoro--rounds-date (format-time-string "%F")
          my-pomodoro--pending nil)
    (my-pomodoro--refresh-mode-line)
    (message "Pomodoro counter reset."))

(defface my-pomodoro-focus-face
  '((t :inherit mode-line :foreground "red" :weight bold))
  "Face for a running pomodoro focus session.")

(defface my-pomodoro-break-face
  '((t :inherit mode-line :foreground "green"))
  "Face for a running pomodoro break.")

(defface my-pomodoro-urgent-face
  '((t :inherit error))
  "Face for a pomodoro session with under 30 seconds remaining.")

(defface my-pomodoro-paused-face
  '((t :inherit mode-line :foreground "gray"))
  "Face for a paused pomodoro session.")

(defface my-pomodoro-pending-face
  '((t :inherit mode-line :foreground "cyan" :weight bold))
  "Face for a pomodoro phase that is ready to start.")

(defvar my-pomodoro--mode-line-string ""
  "Mode line string for the pomodoro timer.")
(put 'my-pomodoro--mode-line-string 'risky-local-variable t)

(defun my-pomodoro--format-seconds (seconds)
  "Format SECONDS as MM:SS."
  (format "%02d:%02d" (/ seconds 60) (% seconds 60)))

(defun my-pomodoro--format ()
  "Return the mode line string for the current state."
  (cond
   ((not (my-pomodoro-running-p))
    (if my-pomodoro--pending
        (propertize
         (format " %s ready " (my-pomodoro--phase-name my-pomodoro--pending))
         'face 'my-pomodoro-pending-face)
      ""))
   (t
    (let* ((session my-pomodoro--current)
           (phase (my-pomodoro--session-phase session))
           (paused (my-pomodoro--session-paused session))
           (remaining (my-pomodoro--remaining))
           (face (cond (paused 'my-pomodoro-paused-face)
                       ((<= remaining 30) 'my-pomodoro-urgent-face)
                       ((eq phase 'focus) 'my-pomodoro-focus-face)
                       (t 'my-pomodoro-break-face)))
           (text (format " %s %s%s "
                         (my-pomodoro--phase-icon phase)
                         (if paused
                             (format "(%s)" (my-pomodoro--format-seconds remaining))
                           (my-pomodoro--format-seconds remaining))
                         (if (eq phase 'focus)
                             (format " %d/%d"
                                     (my-pomodoro--round-display)
                                     my-pomodoro-rounds-before-long-break)
                           ""))))
      (propertize text 'face face)))))

;; Declared here because `--refresh-mode-line' refers to it, and the
;; minor mode that defines it comes after that function.
(defvar my-pomodoro-mode-line-mode nil
  "Non-nil when the pomodoro timer is shown in the mode line.")

(defun my-pomodoro--refresh-mode-line ()
  "Repaint the mode line string, if the mode line mode is on."
  (when my-pomodoro-mode-line-mode
    (setq my-pomodoro--mode-line-string (my-pomodoro--format))
    (force-mode-line-update t)))

;; Must be an :eval form, never the bare symbol.  `add-to-list' prepends, so
;; a bare symbol lands in the *car* of `global-mode-string', and
;; `format-mode-line' then reads that whole list as one format spec instead
;; of a list of elements, silently dropping the timer.  Verified live: with
;; the bare symbol the rendered mode line is empty; with the :eval form it
;; shows.  This also bites the stock mode line, which renders
;; `global-mode-string' directly.
(defvar my-pomodoro--mode-line-construct '(:eval my-pomodoro--mode-line-string)
  "Mode line construct that renders the pomodoro timer.")

;; `global-mode-string' alone is enough even under doom-modeline: doom
;; replaces the mode line, but its `misc-info' segment carries an entry that
;; renders `global-mode-string', which is what that segment's docstring
;; promises.  Registering in `mode-line-misc-info' as well was tried and
;; rendered the timer twice.
(define-minor-mode my-pomodoro-mode-line-mode
  "Show the pomodoro timer in the mode line."
  :global t
  :group 'my-pomodoro
  (if my-pomodoro-mode-line-mode
      (progn
        (unless global-mode-string
          (setq global-mode-string '("")))
        (add-to-list 'global-mode-string my-pomodoro--mode-line-construct)
        (my-pomodoro--refresh-mode-line))
    (setq global-mode-string
          (delq my-pomodoro--mode-line-construct global-mode-string)
          my-pomodoro--mode-line-string "")))

;; transient arrives with magit, which this config already requires, so
;; a plain require is enough and avoids a straight registration.  The
;; eval-and-compile is required because `transient-define-prefix' is a
;; macro, and macros are not autoloaded.
(eval-and-compile (require 'transient))

(defun my-pomodoro-toggle-mode-line ()
  "Toggle the pomodoro timer in the global mode line."
  (interactive)
  ;; Pass 'toggle rather than (not ...): for a global minor mode, a nil
  ;; argument from Lisp enables the mode, it does not disable it.
  (my-pomodoro-mode-line-mode 'toggle)
  (message "Pomodoro mode line %s."
           (if my-pomodoro-mode-line-mode "on" "off")))

;; NB: every suffix is written as ("KEY" "Description" COMMAND), three
;; elements, never ("Description" COMMAND).  A leading string is
;; consumed as the suffix's :key, so the two element form parses
;; cleanly but leaves :description nil and every row of the prefix
;; renders as "(BUG: no description)".
(transient-define-prefix my-pomodoro ()
  "Transient prefix for the pomodoro timer."
  [["Not running" :if-not my-pomodoro-running-p
                   ("d" "Due phase" my-pomodoro-start)
                   ("f" "Focus" my-pomodoro-start-focus)
                   ("b" "Break" my-pomodoro-start-break)]
   ["Running" :if my-pomodoro-running-p
               ("p" "Pause/Resume" my-pomodoro-toggle-pause)
               ("s" "Stop" my-pomodoro-stop)]
   ["Always" ("r" "Reset counter" my-pomodoro-reset)
              ("m" "Mode line" my-pomodoro-toggle-mode-line)]])

(global-set-key (kbd "C-c p") #'my-pomodoro)

;; Same as `tmr-mode-line-mode' in my-timers.el, which registers through
;; `global-mode-string' and is likewise left switchable from the prefix.
(my-pomodoro-mode-line-mode 1)

(provide 'my-pomodoro)
