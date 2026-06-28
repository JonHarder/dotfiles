;; -*- lexical-binding: t; -*-
(defun find-config ()
  "Open the user's config file."
  (interactive)
  (find-file (concat user-emacs-directory "config.org")))


(defun my/run-nota (msg)
  "Run the Mac OS 'nota' shortcut with the given MSG."
  (process-lines
   "shortcuts"
   "run"
   "nota"
   "-i"
   msg))

(defun my/notify-at (&optional start-time msg)
  "Notify the user at START-TIME with message MSG.

Uses `run-at-time' and `my/run-nota' under the hood."
  (interactive)
  (let* ((start-time (if start-time
						 start-time
					   (read-string "Time: ")))
		 (msg (if msg
				  msg
				(read-string "Msg: "))))
	(run-at-time start-time nil #'my/run-nota msg)))


(defun gh-get-pr-title (url)
  "Retrieve pull request title from the URL."
  (interactive)
  (let* ((command (format "gh pr view %s --json title" url))
		 (json (json-parse-string
				(shell-command-to-string command))))
	(gethash "title" json)))

(defun masteringemacs ()
  "Open the masteringemacs epub manual."
  (interactive)
  ;; ensure the nov package is installed
  (require 'nov)
  (find-file "~/Library/CloudStorage/Dropbox/Emacs/mastering-emacs-v4.epub"))

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
