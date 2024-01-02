(defun find-config ()
  "Open the user's config file."
  (interactive)
  (find-file (concat user-emacs-directory "config.org")))

(defun masteringemacs ()
  "Open the masteringemacs epub manual."
  (interactive)
  ;; ensure the nov package is installed
  (require 'nov)
  (find-file "~/Dropbox/Emacs/mastering-emacs-v4.epub"))

(provide 'my-util)
