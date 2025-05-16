(straight-use-package 'denote)

(denote-rename-buffer-mode 1)
(setq denote-known-keywords '("emacs" "work" "article" "notes" "blog"))

(setq denote-directory (expand-file-name "~/Dropbox/zettelkasten"))

(setq denote-dired-directories-include-subdirectories t
	  denote-dired-directories (list denote-directory gtd-projects-directory))
(setq denote-prompts '(title subdirectory keywords))

(defun denote-meeting (person)
  (interactive (let ((people-files (denote-directory-files "_person" nil t)))
				 (list (completing-read
						"Person:"
						(mapcar (lambda (f)
								  (denote-retrieve-title-or-filename f 'org))
								people-files)))))
  (denote person '("meeting") 'org))

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
  (kbd "<leader> n m") #'denote-meeting
  (kbd "<leader> n r") #'denote-rename-file
  (kbd "<leader> n s") #'denote-signature
  (kbd "<leader> n t") #'denote-template)

(evil-define-key 'normal denote-backlinks-mode-map
  (kbd "j") #'denote-backlinks-next
  (kbd "k") #'denote-backlinks-prev)

(require 'denote-journal-extras)
(setq denote-journal-extras-directory (concat denote-directory "/journal"))
(add-to-list 'denote-dired-directories denote-journal-extras-directory)

;; (require 'denote-silo-extras)
;; (let ((my-silo-dirs (mapcar (lambda (file)
;; 							  (expand-file-name file))
;; 							'("~/Dropbox/Personal"))))
;;   (dolist (dir my-silo-dirs)
;; 	(add-to-list 'denote-silo-extras-directories dir)
;; 	(add-to-list 'denote-dired-directories dir)))

(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

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
							"  - [[denote:20250423T155338][Be Still and Wonder]]\n\n"
							"  - [[https://github.com/pulls/review-requested][review pull requests]]\n\n"
							"* Notes\n\n"
							"* Meetings\n"))
		(person . ,(concat "* Relationships\n\n"
						   "* Prayer requests\n\n"
						   "* Meetings\n"))))

(provide 'my-denote)
