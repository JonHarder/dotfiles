(straight-use-package '(org :type built-in))
(require 'org)

(with-eval-after-load 'org
  (require 'ol-man)
  (add-to-list 'org-modules 'ol-man t)
  (add-to-list 'org-modules 'org-habit t))

(with-eval-after-load 'org
  (require 'org-tempo))

(setq org-directory "~/Dropbox/org/gtd/")
(setq org-default-notes-file "~/Dropbox/org/gtd/gtd.org")

(setq org-todo-keywords
      '((sequence
         "TODO(t)"
         "NEXT(n)"
         "WAIT(w)"
         "STRT(s)"
         "BLOCKED(b)"
         "REVIEW(r)"
         "|"
         "DONE(d)"
		 "CANCELED(c)")))

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
		 ((tags "+proj+LEVEL=2"
				((org-agenda-overriding-header "Active Projects")))
		  (todo "STRT"
				((org-agenda-overriding-header "In Progress")))
		  (todo "WAIT|REVIEW|BLOCKED"
				((org-agenda-overriding-header "Waiting...")))
		  (todo "NEXT"
				((org-agenda-overriding-header "Next Actions")))
		  (tags "+DEADLINE=\"\"+SCHEDULED=\"\"+TODO=\"TODO\""
				((org-agenda-overriding-header "Inactive tasks")))))

		("d" "GTD Daily View"
		 ((agenda ""
				  ((org-agenda-overriding-header "Today")
				   (org-agenda-span 1)))
		  (todo "STRT"
				((org-agenda-overriding-header "In Progress")))
		  (todo "WAIT|REVIEW|BLOCKED"
				((org-agenda-overriding-header "Waiting...")))
		  (todo "NEXT"
				((org-agenda-overriding-header "Next Actions")))))))

(setq org-agenda-time-grid
	  '((daily today require-timed remove-match)
		(800 1000 1200 1400 1600 1800 2000)
		" ┄┄┄┄┄ "
		"┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))

(setq org-stuck-projects
		'("+proj-archive+LEVEL=1/-DONE" ("NEXT" "STRT") nil ""))

(advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)

(setq org-refile-targets
	  '((org-agenda-files . (:regexp . "One Off"))
		(org-agenda-files . (:regexp . "Events"))
		(org-agenda-files . (:regexp . "Someday"))
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

;; (straight-use-package 'org-super-agenda)
;; (setq org-super-agenda-groups
;; '(
;; 	(:name "Today"
;; 	       :time-grid t
;; 	       :todo '("TODO" "WORKING"))))

(setq org-capture-templates
	  `(("i" "Inbox   - things that may need attention later" entry (file "~/Dropbox/org/gtd/inbox.org")
         "* %?\n/Entered on/ %U")
		("p" "Project - new project" entry
		 (file+headline org-default-notes-file "Projects")
		 "* %^{project title} %(org-set-tags \"proj\")\n** Notes\n\n** Tasks\n*** TODO %?")))

(setq org-structure-template-alist
      '(("s" . "src")
        ("e" . "src emacs-lisp")
        ("b" . "src bash")
		("q" . "quote")
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
