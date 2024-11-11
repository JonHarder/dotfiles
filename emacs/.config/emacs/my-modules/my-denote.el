(straight-use-package 'denote)

(denote-rename-buffer-mode 1)
(setq denote-known-keywords '("emacs" "work" "article" "notes" "blog"))

(setq denote-directory my-notes-directory)

(setq denote-dired-directories
  (list (expand-file-name denote-directory)))
(setq denote-prompts '(title subdirectory keywords))

(defun denote-search-content ()
  (interactive)
  (consult-ripgrep denote-directory))

(defun denote-dired ()
  (interactive)
  (dired denote-directory))

(defvar my-denote-colleagues '("austin-reese" "jordan-carr" "peter-bajurny" "othman-smihi" "brian-merz" "molly-schroeder")
  "List of names I collaborate with.
There is at least one file in the variable `denote-directory' that has
the name of this person.")

(defvar my-denote-colleagues-prompt-history nil
  "Minibuffer history for `my-denote-colleagues-new-meeting'.")

(defun my-denote-colleagues-prompt ()
  "Prompt with completion for a name among `my-denote-colleagues'"
  (let ((default-value (car my-denote-colleagues-prompt-history)))
(completing-read
 (format-prompt "New meeting with COLLEAGUE" default-value)
 my-denote-colleagues
 nil :require-match nil
 'my-denote-colleagues-prompt-history
 default-value)))

(defun my-denote-colleagues-get-file (name)
  "Find file in variable `denote-directory' for NAME colleague.
If there is more than one file, prompt with completion for one among
them.

NAME is one among `my-denote-colleagues'."
  (if-let ((files (denote-directory-files name))
	   (length-of-files (length files)))
  (cond
   ((= length-of-files 1)
	(car files))
   ((> length-of-files 1)
	(completing-read "Select a file: " files nil :require-match)))
(user-error "No files for colleague with name `%s'" name)))

(defun my-denote-colleauges-new-meeting ()
  "Prompt for the name of a colleague and insert a timestamped heading therin.
The name of a colleague corresponds to at least one file in the variable `denote-directory'.
In case there are multiple files, prompt to choose one among them and operate therin.

Names are defined in `my-denote-colleagues'."
  (declare (interactive-only t))
  (interactive)
  (let* ((name (my-denote-colleagues-prompt))
	 (file (my-denote-colleagues-get-file name))
	 (time (format-time-string "%F %a %R")))
(with-current-buffer (find-file file)
  (goto-char (point-max))
  (insert (format "* [%s]\n\n" time)))))

(evil-define-key 'normal 'global
  (kbd "<leader> n /") #'denote-search-content
  (kbd "<leader> n J") #'denote-journal-extras-new-entry
  (kbd "<leader> n b") #'denote-backlinks
  (kbd "<leader> n d") #'denote-dired
  (kbd "<leader> n f") #'denote-open-or-create
  (kbd "<leader> n j") #'denote-journal-extras-new-or-existing-entry
  (kbd "<leader> n l") #'denote-link
  (kbd "<leader> n n") #'denote
  (kbd "<leader> n r") #'denote-rename-file
  (kbd "<leader> n s") #'denote-signature)

(evil-define-key 'normal denote-backlinks-mode-map
  (kbd "j") #'denote-backlinks-next
  (kbd "k") #'denote-backlinks-prev)

(require 'denote-journal-extras)
(setq denote-journal-extras-directory (concat denote-directory "/journal"))
(add-to-list 'denote-dired-directories denote-journal-extras-directory)

(require 'denote-silo-extras)
(let ((my-silo-dirs (list
		 (expand-file-name
		  "~/Dropbox/Personal")
		 (expand-file-name
		  "~/Dropbox/RBC/Internship/notes"))))
  (dolist (dir my-silo-dirs)
(add-to-list 'denote-silo-extras-directories dir)
(add-to-list 'denote-dired-directories dir)))

(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

(provide 'my-denote)
