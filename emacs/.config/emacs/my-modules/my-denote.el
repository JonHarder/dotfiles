(straight-use-package 'denote)

(denote-rename-buffer-mode 1)
(setq denote-known-keywords '("emacs" "work" "article" "notes" "blog"))

(setq denote-directory (expand-file-name "~/Library/CloudStorage/Dropbox/org/zettelkasten"))

(setq denote-dired-directories-include-subdirectories t
      denote-dired-directories (list denote-directory))
(setq denote-prompts '(title subdirectory keywords))

;;; Code:
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

(straight-use-package 'denote-journal)
(setq denote-journal-directory (concat denote-directory "/journal"))
(add-to-list 'denote-dired-directories denote-journal-directory)
;; calendar integration
(require 'denote-journal)
(add-hook 'calendar-mode-hook #'denote-journal-calendar-mode)

(straight-use-package 'denote-silo)
;; (setq denote-silo-directories '())
;; (let ((my-silo-dirs (mapcar (lambda (file)
;;                               (expand-file-name file))
;;                             '("~/Dropbox/org/gtd/projects"))))
;;   (dolist (dir my-silo-dirs)
;;     (add-to-list 'denote-silo-directories dir)
;;     (add-to-list 'denote-dired-directories dir)))

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
                            "  - [[https://github.com/issues/SSC_kgDOABqApA?q=is%3Apr%20org%3AKipsu%20state%3Aopen%20archived%3Afalse%20sort%3Aupdated-desc%20-is%3Adraft%20review-requested%3A%40me][review pull requests]]\n\n"
                            "* Notes\n"))
        (person . ,(concat "* Relationships\n\n"
                           "* Prayer requests\n\n"
                           "* Meetings\n"))))

(provide 'my-denote)
