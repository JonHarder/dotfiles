(defvar my-theme '(ef-themes . ef-autumn)
  "Cons of the symbols representing the theme package, and theme name.")
(defvar my-font '(:name "JetBrains Mono" :size 170)
  "Font (:name string :size integer).")

(straight-use-package (car my-theme))
(load-theme (cdr my-theme) t)

(set-face-attribute 'bold nil :weight 'ultra-bold)
(when t
  (custom-set-faces
   '(org-level-1 ((t (:height 1.3 :inherit outline-1))))
   '(org-level-2 ((t (:height 1.2 :inherit outline-2))))
   '(org-level-3 ((t (:height 1.2 :inherit outline-3))))
   '(org-level-4 ((t (:height 1.2 :inherit outline-4))))
   '(org-level-5 ((t (:height 1.1 :inherit outline-5))))
   '(org-document-title ((t (:height 2.5 :underline t))))))

(when (eq 'modus-themes (car my-theme)) ;; Modus configuration
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
		'((1 . (1.3))
          (2 . (1.2))
		  (3 . (1.2))
		  (4 . (1.2))
          (agenda-date . (1.3))
          (agenda-structure . (variable-pitch light 1.8))
          (t . (1.1)))))

(when (eq 'doom-themes (car my-theme))
  (setq doom-rouge-brighter-comments t
		doom-themes-enable-bold t
		doom-themes-enable-italic t))

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
            (let ((size (plist-get my-font :size))
				  (font (plist-get my-font :name))
				  (theme (cdr my-theme)))
			  (set-face-attribute 'default nil
								  :font font
								  :height size)
              (set-frame-font font nil t)
              (add-to-list 'default-frame-alist
                           `(font . ,font))
              (load-theme theme t))))

(setq tab-bar-show 1)

(straight-use-package 'spacious-padding)

(provide 'my-appearance)
