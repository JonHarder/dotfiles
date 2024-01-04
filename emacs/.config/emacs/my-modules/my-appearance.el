(straight-use-package my-theme-package)

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
  (setq modus-themes-headings
	'((1 . (variable-pitch 1.5))
	  (2 . (1.3))
	  (agenda-date . (1.3))
	  (agenda-structure . (variable-pitch light 1.8))
	  (t . (1.1)))))

(straight-use-package 'ef-themes)
(setq ef-themes-headings
      '((1 . (variable-pitch 1.5))
	(2 . (1.3))
	(agenda-date . (1.3))
	(agenda-structure . (variable pitch light 1.8))
	(t . (1.1))))

(straight-use-package 'doom-themes)
(setq doom-rouge-brighter-comments t
      doom-themes-enable-bold t
      doom-themes-enable-italic t)

(load-theme my-theme t)

(menu-bar-mode 1)

(scroll-bar-mode -1)

(tool-bar-mode -1)

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      inhibit-splash-screen t
      inhibit-startup-screen t)

(setq ring-bell-function 'ignore)

(setq display-time-24hr-format t)

(display-time-mode -1)
; (display-time)

(let ((size 165))
  (set-face-attribute 'default nil :font my-font :height size)
  (set-frame-font my-font nil t)
  (add-to-list 'default-frame-alist
	       `(font . ,my-font)))

(setq tab-bar-show 1)

(straight-use-package 'spacious-padding)

(provide 'my-appearance)
