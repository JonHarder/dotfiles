(setq my-theme '(modus-themes . modus-vivendi))
(straight-use-package (car my-theme))
(add-hook 'after-init-hook
	  (lambda ()
	(load-theme (cdr my-theme) t)))

(set-face-attribute 'bold nil :weight 'ultra-bold)
(when t
  (custom-set-faces
   '(org-level-1 ((t (:height 1.6 :inherit outline-1))))
   '(org-level-2 ((t (:height 1.5 :inherit outline-2))))
   '(org-level-3 ((t (:height 1.2 :inherit outline-3))))
   '(org-level-4 ((t (:height 1.1 :inherit outline-4))))
   '(org-level-5 ((t (:height 1.0 :inherit outline-5))))
   '(org-document-title ((t (:height 2.0 :underline t))))))

(progn ;; Modus configuration
  (require-theme 'modus-themes)
  (setq modus-themes-completions
		'((matches . (extrabold underline))
		  (selection . (semibold italic))))
  (setq modus-themes-prompts '(bold))
  (setq modus-themes-bold-constructs t)
  (setq modus-themes-common-palette-overrides
		modus-themes-preset-overrides-intense)
  (setq modus-themes-variable-pitch-ui nil)
  (setq modus-themes-italic-constructs t)
  (setq modus-themes-org-blocks 'gray-background)
  ;; TODO set this to nil if a non-modus theme is active?
  (setq modus-themes-headings
		'((1 . (variable-pitch 1.5))
		  (2 . (1.3))
		  (agenda-date . (1.3))
		  (agenda-structure . (variable-pitch light 1.8))
		  (t . (1.1)))))

(straight-use-package 'ef-themes)
;; (setq ef-themes-headings ; read the manual's entry or the doc string
;;       '((0 variable-pitch bold 1.9)
;; 	(1 variable-pitch bold 1.8)
;; 	(2 variable-pitch regular 1.7)
;; 	(3 variable-pitch regular 1.6)
;; 	(4 variable-pitch light 1.5)
;; 	(5 variable-pitch light 1.4) ; absence of weight means `bold'
;; 	(6 variable-pitch light 1.3)
;; 	(7 variable-pitch light 1.2)
;; 	(t variable-pitch light 1.1)
;; 	(agenda-date . (1.3))
;; 	(agenda-structure . (variable pitch light 1.8))))

(straight-use-package 'doom-themes)
(setq doom-rouge-brighter-comments t
  doom-themes-enable-bold t
  doom-themes-enable-italic t)

(menu-bar-mode 1)

(scroll-bar-mode -1)

(tool-bar-mode -1)

(setq frame-resize-pixelwise t
  frame-inhibit-implied-resize t
  inhibit-splash-screen t
  inhibit-startup-screen t)

(setq ring-bell-function 'ignore)

(setq display-time-24hr-format t)

(display-time)

(add-hook 'after-init-hook
		  (lambda ()
			(let ((size 175))
			  (set-face-attribute 'default nil :font my-font :height size)
			  (set-frame-font my-font nil t)
			  (add-to-list 'default-frame-alist
						   `(font . ,my-font))
			  (load-theme (cdr my-theme) t))))

(setq tab-bar-show 1)

(straight-use-package 'spacious-padding)

(provide 'my-appearance)
