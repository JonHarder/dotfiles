;; -*- lexical-binding: t; -*-
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

(defun add-to-path (value &optional prepend)
  "Add VALUE to the PATH environment variable.

This handles reading the current value of PATH and appends the given
value to the end of it, or to the beginning if PREPEND is non nil.

VALUE should be the raw string to add, `add-to-path' will handle
ensuring the final value contains the necessary ':'."
  (interactive "DPath: ")
  (let ((path (getenv "PATH")))
	(setenv "PATH"
			(concat path value ":"))))

(provide 'my-util)
