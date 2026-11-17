;; -*- lexical-binding: t; -*-
(require 'local-config)

;;; Code:
;; turn off blinking cursor mode
(blink-cursor-mode -1)

;; (set-face-attribute 'bold nil :weight 'ultra-bold)
(when t
  (custom-set-faces
   '(org-level-1 ((t (:height 1.5 :inherit outline-1))))
   '(org-level-2 ((t (:height 1.4 :inherit outline-2))))
   '(org-level-3 ((t (:height 1.3 :inherit outline-3))))
   '(org-level-4 ((t (:height 1.2 :inherit outline-4))))
   '(org-level-5 ((t (:height 1.1 :inherit outline-5))))
   '(org-document-title ((t (:height 2.5 :underline t))))))


(defvar my/theme-packages
  '(modus
	doom
	ef)
  "Theme packages which contain the themes I often switch between.")

;;; Commenting this out in favor of the custom "kusanagi-theme" configured above.
(defun my/configure-theme (package theme)
  "Configure the PACKAGE containing the desired theme THEME and then load it."
  (interactive (let* ((package (completing-read "Package: " my/theme-packages nil t))
					  (theme (completing-read "Theme: " custom-known-themes nil t (format "%s-" package))))
				 (list package theme)))
  (pcase (intern package)
	('modus
	 (use-package modus-themes
	   :straight t
	   :config
	   (setq modus-themes-completions
			 '((matches . (extrabold underline))
			   (selection . (semibold italic)))
			 modus-themes-prompts '(bold)
			 modus-themes-bold-constructs t
			 ;; modus-themes-common-palette-overrides modus-themes-preset-overrides-intense
			 modus-themes-common-palette-overrides `((bg-tab-bar bg-main)
													 (bg-tab-current bg-cyan-intense)
													 (bg-tab-other bg-inactive)
													 ,@modus-themes-preset-overrides-intense)
			 modus-themes-variable-pitch-ui nil
			 modus-themes-italic-constructs t
			 modus-themes-org-blocks 'gray-background
			 modus-themes-headings
			 '((1 . (1.3))
			   (2 . (1.2))
			   (3 . (1.1))
			   (4 . (1.1))
			   (agenda-date . (1.3))
			   (agenda-structure . (variable-pitch light 1.8))
			   (t . (1.1))))))
	('catppuccin
	 (use-package catppuccin-theme
	   :straight t
	   :init
	   (setq catppuccin-flavor 'mocha)))
	('doom
	 (use-package doom-themes
	   :straight t
	   :init
	   (setq doom-rouge-brighter-comments t
			 doom-themes-enable-bold t
			 doom-themes-enable-italic t)
	   (setq doom-monokai-classic-brighter-comments t
			 doom-monokai-classic-comment-bg t
			 
			 doom-gruvbox-dark-variant "hard"
			 doom-gruvbox-brighter-comments t
			 doom-gruvbox-padded-modeline t

			 doom-dracula-comment-bg t
			 doom-dracula-colorful-headers t
			 doom-dracula-brighter-comments t

			 doom-ayu-dark-comment-bg t
			 doom-ayu-dark-brighter-comments t
			 doom-ayu-dark-brighter-modeline nil

			 doom-horizon-comment-bg t
			 doom-horizon-brighter-comments t
			 doom-horizon-brighter-modeline nil)
	   :config
	   ;; Since Emacs 31 (bug#79672) defining a face so that it inherits
	   ;; from itself is an error instead of a latent display bug.
	   ;; doom-themes has `gnus-group-news-low-empty' inherit from
	   ;; `gnus-group-news-low', but gnus.el now defines
	   ;; `gnus-group-news-low' as inheriting from
	   ;; `gnus-group-news-low-empty' -- a cycle, which makes every new
	   ;; frame fail with "Face inheritance results in inheritance cycle:
	   ;; gnus-group-news-low".  Inherit from the dim mail face instead,
	   ;; which is what the cycle was working around anyway.
	   (when-let ((face (assq 'gnus-group-news-low-empty doom-themes-base-faces)))
		 (setcdr face '(:inherit 'gnus-group-mail-1-empty :weight 'normal)))
	   (doom-themes-org-config))))
  (dolist (theme custom-enabled-themes)
	(disable-theme theme))
  (load-theme (intern theme) t))

(global-set-key (kbd "C-c t t") #'my/configure-theme)

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

(set-frame-font
 (format "%s-%d" (plist-get my-font :name) (plist-get my-font :size))
 t t t)

(add-hook 'after-make-frame-functions
		  (lambda (frame)
			(let ((family (plist-get my-font :name))
				  (height (plist-get my-font :size))
				  (theme (cdr my-theme)))
			  (with-selected-frame frame
				(set-frame-font
				 (format "%s-%d" family height))
				(load-theme theme t)))))

(setq tab-bar-show 1)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'yaml-ts-mode-hook #'display-line-numbers-mode)
(add-hook 'yaml-mode-hook #'display-line-numbers-mode)

(use-package lin
  :straight t
  :config
  (lin-global-mode t))

(use-package spacious-padding
  :straight t
  :bind
  (("C-c t s" . #'spacious-padding-mode))
  :hook (after-init . #'spacious-padding-mode))

(provide 'my-appearance)

(straight-use-package 'ultra-scroll)
(setq scroll-conservatively 3
	  scroll-margin 0)
(ultra-scroll-mode 1)
