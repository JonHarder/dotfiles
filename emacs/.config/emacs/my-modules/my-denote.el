(straight-use-package 'denote)

(denote-rename-buffer-mode 1)
(setq denote-known-keywords '("emacs" "work" "article" "notes" "blog"))

(setq denote-directory (expand-file-name "~/Dropbox/notes"))
(setq denote-dired-directories
      (list (expand-file-name denote-directory)))
(setq denote-prompts '(title subdirectory keywords))

(evil-define-key 'normal 'global
  (kbd "<leader> n b") #'denote-backlinks
  (kbd "<leader> n s") #'denote-signature
  (kbd "<leader> n f") #'denote-open-or-create
  (kbd "<leader> n j") #'denote-journal-extras-new-or-existing-entry
  (kbd "<leader> n l") #'denote-link
  (kbd "<leader> n n") #'denote
  (kbd "<leader> n r") #'denote-rename-file
  (kbd "<leader> n J") #'denote-journal-extras-new-entry)

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
