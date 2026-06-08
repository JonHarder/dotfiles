(straight-use-package 'meow)
(require 'meow)

(defun meow-setup-core ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty))

(setq meow-use-clipboard t)

;; ;; Move meow's j/k motion bindings to SPC so notmuch (and other modes that use them can have them back
;; (meow-motion-remap-prefix "SPC")

(meow-motion-define-key
 '("j" . meow-next)
 '("k" . meow-prev)
 '("=" . ace-window)
 '("<escape>" . ignore))

(defun gtd-find-file ()
  (interactive)
  (find-file (concat gtd-directory "/gtd.org")))

(defun delete-this-file ()
  "Delete the current buffer's file, if visiting one."
  (interactive)
  (when-let* ((buffer (current-buffer))
			  (file (buffer-file-name)))
	(when (y-or-n-p (format "Delete file '%s'?" file))
	  (delete-file file)
	  (kill-buffer buffer))))

(meow-leader-define-key
 '("SPC" . ace-window)
 '("RET" . embark-act)
 '(";" . comment-line)
 '("." . execute-extended-command)
 ;; file commands
 '("ff" . find-file)
 '("fg" . gtd-find-file)
 '("fi" . gtd-find-inbox)
 '("fc" . find-config)
 '("fd" . delete-this-file)
 '("fe" . ediff-current-file)
 ;; buffer commands
 '("bs" . save-buffer)
 '("bb" . consult-buffer)
 '("bi" . ibuffer)
 '("bk" . kill-current-buffer)
 '("i" . consult-imenu)
 ;; (re)compilation (prefir, "p")
 '("pp" . project-compile)
 '("pr" . recompile)
 '("pf" . project-find-file)
 ;; currently just maps to `eglot-mode-map'
 ;; terminals/vc
 '("sv" . vterm)
 '("se" . eshell)
 '("ss" . shell)
 ;; code things
 '("eD" . eldoc)
 '("ee" . eglot)
 '("ef" . eglot-format-buffer)
 '("ed" . eldoc-box-help-at-point)
 '("ea" . eglot-code-actions)
 '("er" . eglot-rename)
 
 '("a" . avy-goto-char-timer)
 '("l" . recenter-top-bottom)
 ;; apps (org agenda, etc)
 '("oa" . org-agenda)
 '("oc" . org-capture)
 '("oo" . occur)
 '("j" . majutsu)
 ;; denote bindings
 '("nb" . denote-backlinks)
 '("nn" . denote-open-or-create)
 '("nj" . denote-journal-new-or-existing-entry)
 '("nl" . denote-link)
 '("nf" . denote-find-link)
 '("ng" . consult-denote-grep)
 '("nr" . denote-rename-file-using-front-matter)
 '("ns" . nil)
 '("nsf" . denote-sequence-find)
 '("nss" . denote-sequence)
 ;; tab bindings
 '("tt" . tab-switch)
 '("tr" . tab-rename)
 '("tn" . tab-new)
 '("tj" . tab-next)
 '("tk" . tab-previous)
 '("td" . tab-close)
 '("ww" . eww)
 ;; window management
 '("w/" . split-window-horizontally)
 '("w." . split-window-vertically)
 '("wv" . split-window-horizontally)
 '("ws" . split-window-vertically)
 '("wo" . toggle-delete-other-windows)
 '("wk" . delete-window)
 '("z" . jinx-correct)
 ;; Use SPC (0-9) for digit arguments.
 '("1" . meow-digit-argument)
 '("2" . meow-digit-argument)
 '("3" . meow-digit-argument)
 '("4" . meow-digit-argument)
 '("5" . meow-digit-argument)
 '("6" . meow-digit-argument)
 '("7" . meow-digit-argument)
 '("8" . meow-digit-argument)
 '("9" . meow-digit-argument)
 '("0" . meow-digit-argument)
 '("/" . meow-keypad-describe-key)
 '("?" . meow-cheatsheet))

(setq meow-org-motion-keymap (make-keymap))
(meow-define-state org-motion
  "Org-mode structural motion"
  :lighter "[O]"
  :keymap meow-org-motion-keymap)

(meow-define-keys 'org-motion
  '("<escape>" . meow-normal-mode)
  '("i" . meow-insert-mode)
  '("g" . meow-normal-mode)
  '("u" . meow-undo)
  ;; Moving between headlines
  '("k" . org-previous-visible-heading)
  '("j" . org-next-visible-heading)
  ;; moving between headings at the same level
  '("p" . org-backward-heading-same-level)
  '("n" . org-forward-heading-same-level)
  ;; Moving subtrees themselves
  '("K" . org-move-subtree-up)
  '("J" . org-move-subtree-down)
  ;; subtree de/promotion
  '("L" . org-demote-subtree)
  '("H" . org-promote-subtree)
  '(">" . org-demote-subtree)
  '("<" . org-promote-subtree)
  ;; Completion-style search of headings
  '("v" . consult-outline)
  ;; setting subtree metadata
  '("l" . org-set-property)
  '("t" . org-todo)
  '("d" . org-deadline)
  '("s" . org-schedule)
  '("e" . org-set-effort)
  ;; Block navigation
  '("b" . org-previous-block)
  '("f" . org-next-block)
  ;; destructive actions
  '("a" . org-archive-subtree)
  '("d" . org-cut-subtree)
  ;; Narrowing/widening
  '("N" . org-narrow-to-subtree)
  '("W" . widen))

(defvar meow-layout-qwerty
  '(
	("=" . ace-window)
	("," . meow-inner-of-thing)
	("." . meow-bounds-of-thing)
	("[" . meow-beginning-of-thing)
	("]" . meow-end-of-thing)
	(">" . meow-indent)
	("a" . meow-append)
	("A" . meow-open-below)
	("b" . meow-back-word)
	("B" . meow-back-symbol)
	("c" . meow-change)
	("d" . meow-delete)
	("D" . meow-backward-delete)
	("e" . meow-next-word)
	("E" . meow-next-symbol)
	("f" . meow-find)
	("g" . meow-cancel-selection)
	("G" . meow-grab)
	("h" . meow-left)

	("H" . meow-left-expand)
	("i" . meow-insert)
	("I" . meow-open-above)
	("j" . meow-next)
	("J" . meow-next-expand)
	("k" . meow-prev)
	("K" . meow-prev-expand)
	("l" . meow-right)
	("L" . meow-right-expand)
	("m" . meow-join)
	("n" . meow-search)
	("o" . meow-block)
	("O" . meow-org-motion-mode)
	("p" . meow-yank)
	("q" . meow-quit)
	("Q" . meow-goto-line)
	("r" . meow-replace)
	("R" . meow-swap-grab)
	("s" . meow-kill)
	("t" . meow-till)
	("u" . meow-undo)
	("U" . meow-undo-in-selection)
	("v" . meow-visit)
	("w" . meow-mark-word)
	("W" . meow-mark-symbol)
	("x" . meow-line)
	("X" . meow-goto-line)
	("y" . meow-save)
	("Y" . meow-sync-grab)
	("z" . meow-pop-selection)
	("'" . repeat)
	("/" . consult-line)
	(":" . execute-extended-command)
	("<escape>" . ignore)))

(defvar meow-layout-hd-gold
  '(;; right hand
	;;   ;./'=
	;;   ,aeih
	;;   _uoyk
	("," . negative-argument)
	("a" . meow-back-word)
	("A" . meow-back-symbol)
	("e" . meow-left)
	("E" . meow-left-expand)
	("i" . meow-right)
	("I" . meow-right-expand)
	("h" . meow-next-word)
	("H" . meow-next-symbol)
	("." . meow-beginning-of-thing)
	("/" . meow-prev)
	("\\" . meow-prev-expand)
	("=" . meow-next)
	("+" . meow-next-expand)
	("'" . meow-end-of-thing)

	("u" . meow-line)
	("U" . meow-undo)
	("o" . meow-inner-of-thing)
	("y" . meow-bounds-of-thing)
	("-" . meow-mark-word)
	("_" . meow-mark-symbol)
	("k" . meow-block)
	("K" . meow-join)
	
	;; left hand
	;;   jgmpv
	;;   rsndb
	;;   xflcw
	;;      t
	("z" . meow-pop-selection)
	("q" . meow-quit)
	("j" . avy-goto-char-timer)
	("g" . xref-find-definitions)
	("G" . meow-grab)
	("m" . meow-find)
	("M" . meow-till)
	("p" . meow-yank)
	("v" . consult-line)
	("r" . meow-replace)
	("s" . meow-kill)
	("n" . meow-search)
	("d" . meow-delete)
	("D" . meow-backward-delete)
	("b" . consult-buffer)
	("x" . meow-cancel-selection)
	("f" . meow-insert)
	("F" . meow-open-above)
	("l" . meow-append)
	("L" . meow-open-below)
	("c" . meow-change)
	("w" . ace-window)

	("t" . meow-save)
	("T" . meow-sync-grab)))

(defvar meow-layout meow-layout-qwerty
  "List of bindings for meow normal mode.

Each element is a cons cell with the car being a string (keybind)
and the cdr being a command.

There are already premade layouts for qwerty and hands down - gold
found in `meow-layout-qwerty' and `meow-layout-hd-gold' respectively.")

(apply 'meow-normal-define-key meow-layout)

(meow-normal-define-key
 ;; general keys (irrespective of keymap)
 '("0" . meow-expand-0)
 '("9" . meow-expand-9)
 '("8" . meow-expand-8)
 '("7" . meow-expand-7)
 '("6" . meow-expand-6)
 '("5" . meow-expand-5)
 '("4" . meow-expand-4)
 '("3" . meow-expand-3)
 '("2" . meow-expand-2)
 '("1" . meow-expand-1)
 
 '("-" . negative-argument)
 '(";" . meow-reverse))

(defun meow-switch-layout (layout)
  (interactive (list
				(completing-read "Layout: "
								 '("qwerty" "HD Gold"))))
  (cond
   ((string= "qwerty" layout)
	(setq meow-layout meow-layout-qwerty))
   ((string= "HD Gold" layout)
	(setq meow-layout meow-layout-hd-gold)))
  (apply 'meow-normal-define-key meow-layout))

(mapc (lambda (mode)
		(add-to-list 'meow-mode-state-list `(,mode . insert)))
	  '(vterm-mode eshell-mode org-capture-mode))

(meow-global-mode 1)

(keymap-global-set "C-<return>" #'embark-act)
(keymap-global-set "s-<return>" #'embark-dwim)

;; adding a specific keybinding for org mode since it already binds this binding
(with-eval-after-load 'org
  (keymap-set org-mode-map "C-<return>" #'embark-act))

(provide 'my-meow)
