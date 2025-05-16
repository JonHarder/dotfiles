(defvar gtd-directory (expand-file-name "~/Dropbox/gtd")
  "The directory my 'Getting Things Done' system is stored in")

(defvar gtd-projects-directory (concat gtd-directory "/projects")
  "The directory holding gtd project files.

By default it is based off of the location of `gtd-directory'")

(provide 'my-gtd)
