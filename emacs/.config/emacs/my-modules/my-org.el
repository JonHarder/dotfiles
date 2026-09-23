;; -*- lexical-binding: t; -*-

(straight-use-package '(org :type built-in))
(require 'org)

(with-eval-after-load 'org
  (require 'ol-man)
  (add-to-list 'org-modules 'ol-man t)
  (add-to-list 'org-modules 'org-habit t))

(use-package org-tempo
  :after org
  :config
  (keymap-set org-mode-map "C-c q" #'tempo-template-org-quote))

(setq org-directory "~/Library/CLoudStorage/Dropbox/org/gtd/")
(setq org-default-notes-file "~/Library/CloudStorage/Dropbox/org/gtd/gtd.org")

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

(use-package ox-typst
  :straight t
  :after org
  :config
  (require 'ox-typst)
  (defun my/org-typst-superscript-verse-numbers (text)
	"Superscript verse-number markers (digits glued to the next word)."
	(replace-regexp-in-string
	 "[0-9]+[[:alpha:]]"
	 (lambda (s)
	   (let* ((n (1- (length s)))
			  (num (substring s 0 n))
			  (letter (substring s n)))
		 (format "#super(typographic: false, baseline: -0.4em, size: 0.75em)[#text(weight: \"regular\")[%s]]%s"
				 num
				 letter
				 text)))
	 text
	 t))
  
  (defun my/org-typst-special-block (special-block contents info)
	(let* ((type (org-element-property :type special-block))
           (attrs (org-export-read-attribute :attr_typst special-block))
           (ref (plist-get attrs :ref)))
      (pcase type
		("scripture"
		 (format "#block(inset: (left: 1.5em, top: 0.6em, bottom: 0.6em))[#text(weight: \"bold\")[%s]%s]"
				 (my/org-typst-superscript-verse-numbers (org-trim contents))
				 (if ref (format " (%s)" ref) "")))
		(_ contents))))
  (advice-add 'org-typst-special-block :override #'my/org-typst-special-block))

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
		(org-agenda-files . (:regexp . "Tasks"))
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

(mapc (lambda (file)
		(add-to-list 'org-agenda-files
					 (expand-file-name file org-directory)))
	  '("gtd.org"
		"events.org"
		"calendar.org"
		"pull_requests.org"))

;; (straight-use-package 'org-super-agenda)
;; (setq org-super-agenda-groups
;; '(
;; 	(:name "Today"
;; 	       :time-grid t
;; 	       :todo '("TODO" "WORKING"))))

(global-set-key (kbd "C-c o c") #'org-capture)
(global-set-key (kbd "C-c o a") #'org-agenda)

(use-package org-timegrid
  :straight (:type git :host github :repo "Gleek/org-timegrid")
  :commands (org-timegrid-week)
  :bind ("C-c o g" . org-timegrid-week)
  :init
  (setq org-timegrid-org-files 'agenda
		org-timegrid-org-capture-file
		(expand-file-name "calendar.org" org-directory)
		org-timegrid-org-auto-save t
		org-timegrid-org-show-repeaters t

		org-timegrid-org-tag-color-alist
		'(("@Work" . blue)
          ("@Home" . green)
		  ("@Church" . yellow)))

(use-package org-timegrid-agenda
  :after org-timegrid
  :init
  (setq org-timegrid-agenda-separator t
		org-timegrid-agenda-minutes-before 180
		org-timegrid-agenda-minutes-after 180)
  :config
  (org-timegrid-agenda-mode 1))

(setq org-tag-alist '((:startgroup)
					  ("@Work" . ?w)
					  ("@Church" . ?c)
					  ("@Home" . ?h)
					  ("@Errands" . ?e)
					  (:endgroup)
					  ("security" . ?s)
					  ("pastoral" . ?p)))

(defun my/org-capture-schedule ()
  "Prompt for [t]oday or [d]ate pciker; return a SCHEDULED line."
  (let* ((ch (read-char-choice "Schedule: [t]oday  [d]ate " '(?t ?d)))
		 (time (pcase ch
				 (?t (current-time))
				 (?d (org-time-string-to-time
					  (org-read-date nil nil nil "Date: "))))))
	(concat "SCHEDULED: " (format-time-string "<%Y-%m-%d %a>" time))))


(setq org-capture-templates
	  `(("i" "Inbox   - things that may need attention later" entry (file "~/Library/CloudStorage/Dropbox/org/gtd/inbox.org")
         "* %?\n/Entered on/ %U")
		("r" "Pull request review" entry
		 (file+headline "~/Library/CloudStorage/Dropbox/org/gtd/pull_requests.org" "Pull requests")
		 "* NEXT [[%c][%(gh-get-pr-title (current-kill 0))]]"
		 :immediate-finish t)
		("p" "Project - new project" entry
		 (file+headline org-default-notes-file "Projects")
		 "* %^{project title} %(org-set-tags \"proj\")\n** Notes\n\n** Tasks\n*** TODO %?")
		("t" "Task" entry
		 (file+headline org-default-notes-file "Tasks")
		 "* TODO %^{Task} %^g\n%(my/org-capture-schedule)\n%?"
		 :empty-lines-before 1
		 :kill-buffer t)))

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

(use-package org-modern
  :straight t
  :after org
  :init
  (setq org-modern-fold-stars
	'(("▶" . "▼")
          ("▷" . "▽")
	  ;; this symbol is not present in many fonts, including mine
	  ;; the author proposes that the fonts should include the symbol
	  ;; here is my workaround
	  ;; courtesy of https://github.com/minad/org-modern/issues/232
          ;; ("⯈" . "⯆")
          ("▷" . "▽")
          ("▹" . "▿")
          ("▸" . "▾")))
  :config
  (global-org-modern-mode 1))

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

(use-package citar
  :straight t
  :custom
  (citar-bibliography '("~/Library/CloudStorage/Dropbox/org/wiki/bibliography.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  :bind
  (:map org-mode-map :package org ("C-c b" . #'org-cite-insert)))

(provide 'my-org)
