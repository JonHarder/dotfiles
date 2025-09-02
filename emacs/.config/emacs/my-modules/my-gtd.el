(defvar gtd-directory (expand-file-name "~/Dropbox/gtd")
  "The directory my 'Getting Things Done' system is stored in")

(defvar gtd-projects-directory (concat gtd-directory "/projects")
  "The directory holding gtd project files.

By default it is based off of the location of `gtd-directory'")

(defun gtd-find-oneoff ()
  (interactive)
  (find-file (concat gtd-directory "/oneoff.org")))

(defun gtd-find-schedule ()
  (interactive)
  (find-file (concat gtd-directory "/schedule.org")))

(defun gtd-find-inbox ()
  (interactive)
  (find-file (concat gtd-directory "/inbox.org")))

(defun gtd-capture ()
  "Capture a thought and store in my gtd inbox."
  (interactive)
  (org-capture nil "i"))

(provide 'my-gtd)
