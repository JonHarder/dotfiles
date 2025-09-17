(straight-use-package '(org :type built-in))
(require 'org)

(with-eval-after-load 'org
  (require 'ol-man)
  (add-to-list 'org-modules 'ol-man t)
  (add-to-list 'org-modules 'org-habit t))

(evil-define-key 'normal org-mode-map
  (kbd "<tab>") 'org-cycle
  (kbd "s-j") 'org-metadown
  (kbd "s-k") 'org-metaup
  (kbd "> >") 'org-shiftmetaright
  (kbd "< <") 'org-shiftmetaleft)

(evil-define-key 'normal org-mode-map
  (kbd "<leader> m a") #'org-archive-subtree
  (kbd "<leader> m e") #'org-export-dispatch
  (kbd "<leader> m p") #'org-publish-project
  (kbd "<leader> m r") #'org-refile
  (kbd "<leader> m l") #'org-insert-link
  (kbd "<leader> m f") #'org-footnote-action
  (kbd "<leader> m i") #'org-toggle-inline-images
  (kbd "<leader> m t") #'org-babel-tangle
  (kbd "<leader> m n") #'org-narrow-to-subtree
  (kbd "<leader> m d") #'org-babel-demarcate-block
  (kbd "<leader> m s s") #'org-schedule
  (kbd "<leader> m s d") #'org-deadline
  (kbd "<leader> m ,") #'org-priority
  (kbd "<leader> m c i") #'org-clock-in
  (kbd "<leader> m c o") #'org-clock-out)

(evil-define-key 'normal org-agenda-mode-map
  (kbd "<leader> m c") #'org-agenda-columns
  (kbd "j") #'org-agenda-next-line
  (kbd "k") #'org-agenda-previous-line
  (kbd "RET") #'org-agenda-switch-to
  (kbd "q") #'org-agenda-quit
  (kbd ".") #'org-agenda-goto-today
  (kbd ",") #'org-agenda-priority
  (kbd "l") #'org-agenda-later
  (kbd "h") #'org-agenda-earlier
  (kbd "m") #'org-agenda-bulk-mark
  (kbd "p") #'org-agenda-set-property
  (kbd "u") #'org-agenda-bulk-unmark
  (kbd "B") #'org-agenda-bulk-action
  (kbd "g w") #'org-agenda-week-view
  (kbd "g d") #'org-agenda-day-view
  (kbd "t") #'org-agenda-todo
  (kbd "r") #'org-agenda-redo
  (kbd "s") #'org-agenda-schedule
  (kbd "d") #'org-agenda-deadline
  (kbd "/") #'org-agenda-filter
  (kbd "<") #'org-agenda-filter-by-category)

(with-eval-after-load 'org
  (require 'org-tempo))

(setq org-directory "~/Dropbox/gtd/")
(setq org-default-notes-file "~/Dropbox/gtd/inbox.org")

(setq org-todo-keywords
      '((sequence
         "TODO(t)"
         "NEXT(n)"
         "WAIT(w)"
         "IN-PROGRESS(i)"
         "BLOCKED(b)"
         "REVIEW(r)"
         "|"
         "DONE(d)")))

(setq org-image-actual-width nil)

(setq org-src-preserve-indentation nil)
(setq org-startup-indented t)
(straight-use-package
 '(org-modern-indent
   :type git
   :host github
   :repo "jdtsmith/org-modern-indent"))
(require 'org-modern-indent)
(add-hook 'org-mode-hook #'org-modern-indent-mode 90)

(setq org-hide-emphasis-markers t)

(setq org-priority-highest ?A
  org-priority-lowest ?D)

;; for handling CSL citation languages in org exporting to latex
(straight-use-package 'citeproc)

;; use latexmk for generating pdfs from tex files
(setq org-latex-pdf-process '("LC_ALL=en_US.UTF-8 latexmk -f -pdf -%latex -shell-escape -interaction=nonstopmode -output-directory=%o %f"))

(with-eval-after-load 'org
  (straight-use-package 'ox-typst)
  (require 'ox-typst))

(setq org-agenda-custom-commands
	  '(("g" "GTD Review"
		 ((agenda ""
				  ((org-agenda-overriding-header "Planned and upcoming")
				   (org-agenda-span 'week)))
		  (tags "-archive+LEVEL=1"
				((org-agenda-overriding-header "Active Projects")
				 (org-agenda-files '("~/Dropbox/gtd/projects.org"))))
		  (tags "-delegate+LEVEL>1+TODO=\"IN-PROGRESS\""
				((org-agenda-overriding-header "In Progress")))
		  (tags "+delegate+LEVEL>1-TODO=\"DONE\""
				((org-agenda-overriding-header "Delegated")))
		  (todo "WAIT|REVIEW|BLOCKED"
				((org-agenda-overriding-header "Waiting...")))
		  (tags "-archive+LEVEL>1/NEXT"
				((org-agenda-overriding-header "Next Actions")))))

		("d" "GTD Daily View"
		 ((agenda ""
				  ((org-agenda-overriding-header "Today")
				   (org-agenda-span 1)))
		  (tags "TODO=\"IN-PROGRESS\""
				((org-agenda-overriding-header "In Progress")))
		  (todo "WAIT|REVIEW|BLOCKED"
				((org-agenda-overriding-header "Waiting...")))
		  (tags "-archive+TODO=\"NEXT\""
				((org-agenda-overriding-header "Next Actions")))))))

(setq org-agenda-time-grid
	  '((daily today require-timed remove-match)
		(800 1000 1200 1400 1600 1800 2000)
		" ┄┄┄┄┄ "
		"┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))

(setq org-stuck-projects
		'("+proj-archive+LEVEL=1/-DONE" ("NEXT" "IN-PROGRESS") nil ""))

(advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)

(setq org-refile-targets
		'((("~/Dropbox/gtd/oneoff.org") . (:level . 1))
		  (("~/Dropbox/gtd/someday.org") . (:level . 1))
		  (org-agenda-files . (:tag . "proj"))))

(setq org-tag-alist
      '((:startgroup)
        ("proj" . ?p)
        ("area" . ?a)
        (:endgroup)

        ;; mental/emotional level
        (:startgroup)
        ("@lowenergy" . ?l)
        ("@highenergy" . ?h)
        (:endgroup)

        ;; locations
        (:startgroup)
        ("@Church" . ?C)
        ("@Work" . ?W)
        ("@Transit" . ?T)
        ("@Home" . ?H)
        ("@Anywhere" . ?A)
        ("@Outsize" . ?O)
        (:endgroup)

        ;; devices
        (:startgroup)
        ("@Laptop" . ?L)
        ("@Phone" . ?P)
        (:endgroup)))

(setq org-agenda-include-diary t)
(setq org-agenda-restore-windows-after-quit t)
(setq org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t)
(setq org-agenda-category-icon-alist nil)
(setq org-columns-default-format "%TODO %3PRIORITY %45ITEM %16SCHEDULED %TAGS")
(add-to-list 'org-agenda-category-icon-alist
             '(".*" '(space . (:width (18)))))

(add-to-list 'org-agenda-files org-directory)
;; (add-to-list 'org-agenda-files gtd-projects-directory)
(add-to-list 'org-agenda-files (concat gtd-directory "/projects.org"))

;; (straight-use-package 'org-super-agenda)
;; (setq org-super-agenda-groups
;; '(
;; 	(:name "Today"
;; 	       :time-grid t
;; 	       :todo '("TODO" "WORKING"))))

(add-hook 'org-capture-mode-hook 'evil-insert-state)
(setq org-capture-templates
      `(("i" "Inbox" entry (file org-default-notes-file)
         ,(concat "* TODO %?\n"
                  "/Entered on/ %U"))))

(setq org-structure-template-alist
      '(("s" . "src")
        ("e" . "src emacs-lisp")
        ("b" . "src bash")
        ("t" . "src emacs-lisp :tangle FILENAME :mkdirp yes")))

(require 'ox-publish)

(setq org-publish-use-timestamps-flag nil)

;; Don't show validation link
(setq org-html-validation-link nil)
;; Use our own scripts
(setq org-html-head-include-scripts nil)
;; Use our own styles
(setq org-html-head-include-default-style nil)

;; this allows us to get syntax highlighting in source blocks exported to html
(straight-use-package 'htmlize)

(setq org-publish-project-alist
  (list (list "blog"
          :components (list "blog-org" "blog-static"))
    (list "blog-org"
          :base-directory "~/blog/org"
          :publishing-directory "~/blog/public"
          :auto-sitemap nil
          :recursive t
          :with-broken-links t
                  :with-creator t
          :section-numbers nil
          :exclude "README"
          :export-exclude-tags (list "draft")
          :with-author "Jon Harder"
          :with-toc nil
          :html-htmlize-output-type 'inline-css
          :html-doctype "html5"
          :html-html5-fancy t
          :html-preamble nil
          :html-postamble nil)
    (list "blog-static"
          :base-directory "~/blog/org/"
          :base-extension "css\\|ico\\|png\\|jpg\\|jpeg\\|gif"
          :publishing-directory "~/blog/public/"
          :recursive t
          :publishing-function #'org-publish-attachment)))

(setq org-hide-emphasis-markers t)

(straight-use-package 'org-modern)
(with-eval-after-load 'org (global-org-modern-mode))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (calc . t)
   (shell . t)))

(straight-use-package 'toc-org)
(add-hook 'org-mode-hook 'toc-org-mode)

(straight-use-package 'literate-calc-mode)
(add-hook 'org-mode-hook #'literate-calc-minor-mode)

(provide 'my-org)
