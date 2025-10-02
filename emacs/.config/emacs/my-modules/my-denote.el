(straight-use-package 'denote)

(denote-rename-buffer-mode 1)
(setq denote-known-keywords '("emacs" "work" "article" "notes" "blog"))

(setq denote-directory (expand-file-name "~/Dropbox/zettelkasten"))

(setq denote-dired-directories-include-subdirectories t
      denote-dired-directories (list denote-directory gtd-projects-directory))
(setq denote-prompts '(title subdirectory keywords))

;;; Code:
(require 'evil)

(defun denote-recently-modified (&optional last-days)
  "View a `dired' buffer containing notes modified in the last LAST-DAYS days.

This uses the first element of `denote-directories' to determine where notes are stored."
  (interactive (list
                (read-number "Last days: " 7)))
  (let* ((default-directory (car (denote-directories)))
         ;; find files recently modified and sort by modification time
         (find-command (format "find . -type f -mtime -%d ! -name .DS_Store | xargs ls -t | cut -c3-"
                               last-days))
         (files (split-string
                 (shell-command-to-string find-command))))
    (dired (cons default-directory files))))

;; NOTE: trying out a simple journal file generated out of an org capture with datetree.
(defun find-journal ()
  (interactive)
  (find-file "~/Dropbox/journal.org"))

(evil-define-key 'normal 'global
  (kbd "<leader> n /") #'denote-grep
  (kbd "<leader> n J") #'denote-journal-new-entry
  (kbd "<leader> n b") #'denote-backlinks
  (kbd "<leader> n d") #'denote-dired
  (kbd "<leader> n f") #'denote-open-or-create
  (kbd "<leader> n j") #'denote-journal-new-or-existing-entry
  (kbd "<leader> n l") #'denote-link
  (kbd "<leader> n n") #'consult-notes
  ;; (kbd "<leader> n n") #'denote
  (kbd "<leader> n m") #'denote-recently-modified
  (kbd "<leader> n i") #'denote-rename-file ;; for "importing" the file (converting it to denote's naming scheme)
  (kbd "<leader> n r") #'denote-rename-file-using-front-matter
  (kbd "<leader> n s") #'denote-signature
  (kbd "<leader> n t") #'denote-template)

(evil-define-key '(visual insert) text-mode-map
  (kbd "C-l") #'denote-link-or-create)

(evil-define-key 'normal denote-backlinks-mode-map
  (kbd "j") #'denote-backlinks-next
  (kbd "k") #'denote-backlinks-prev)

(straight-use-package 'denote-journal)
(setq denote-journal-directory (concat denote-directory "/journal"))
(add-to-list 'denote-dired-directories denote-journal-directory)
;; calendar integration
(add-hook 'calendar-mode-hook #'denote-journal-calendar-mode)
(evil-define-key '(motion normal) calendar-mode-map
  (kbd "d") #'denote-journal-calendar-new-or-existing)

(straight-use-package 'denote-silo)
(setq denote-silo-directories '())
(let ((my-silo-dirs (mapcar (lambda (file)
                              (expand-file-name file))
                            '("~/Dropbox/gtd/projects"))))
  (dolist (dir my-silo-dirs)
    (add-to-list 'denote-silo-directories dir)
    (add-to-list 'denote-dired-directories dir)))

(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

(straight-use-package 'denote-org)

(straight-use-package 'denote-sequence)

(straight-use-package 'denote-explore)

(straight-use-package 'consult-denote)
(consult-denote-mode 1)

(setq denote-templates
      `((onboarding . ,(concat "* Onboarding Tasks\n"
                               "  - [ ] Welcome, office tour\n"
                               "  - [ ] Get laptop (Ada)\n"
                               "  - [ ] Kipsu Platform Architecture\n"
                               "    - https://kipsudev.atlassian.net/wiki/spaces/EN/pages/3145105581/-+Architecture\n"
                               "  - [ ] Set up local environment\n"
                               "  - [ ] Get peripherals\n"
                               "  - [ ] PagerDuty Access\n"
                               "  - [ ] Account access\n"
                               "    - AUDIT ticket\n"
                               "    - github\n"
                               "    - aws\n"
                               "    - jira\n"
                               "    - confluence"))
        (journal . ,(concat "* Daily habits\n"
                            "  - [[denote:20250423T155338][Be Still and Wonder]]\n"
                            "  - [[https://github.com/pulls/review-requested][review pull requests]]\n\n"
                            "* Notes\n\n"
                            "* Meetings\n"))
        (person . ,(concat "* Relationships\n\n"
                           "* Prayer requests\n\n"
                           "* Meetings\n"))))

(provide 'my-denote)
