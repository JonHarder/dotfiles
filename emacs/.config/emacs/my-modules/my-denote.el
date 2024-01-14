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
		      "~/Dropbox/Personal"))))
  (dolist (dir my-silo-dirs)
    (add-to-list 'denote-silo-extras-directories dir)
    (add-to-list 'denote-dired-directories dir)))

(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

(provide 'my-denote)
