(defvar gtd-directory (expand-file-name "~/Dropbox/org/gtd")
  "The directory my 'Getting Things Done' system is stored in")

(defun gtd-find-oneoff ()
  "Open GTD one off file."
  (interactive)
  (find-file (concat gtd-directory "/oneoff.org")))

(defun gtd-find-schedule ()
  "Open GTD schedule file."
  (interactive)
  (find-file (concat gtd-directory "/schedule.org")))

(defun gtd-find-inbox ()
  "Open GTD inbox file."
  (interactive)
  (find-file (concat gtd-directory "/inbox.org")))

(defun gtd-review ()
  "Review inbox and all tasks for clarification and pruning."
  (interactive)
  (delete-other-windows)
  (gtd-find-inbox)
  (split-window-right)
  (org-agenda nil "g"))

(defun gtd-engage ()
  "Actually get some work done.

Opens the \"daily\" custom org agenda command."
  (interactive)
  (org-agenda nil "d"))

(defun gtd-capture ()
  "Capture a thought and store in my gtd inbox."
  (interactive)
  (org-capture nil "i"))

(provide 'my-gtd)
