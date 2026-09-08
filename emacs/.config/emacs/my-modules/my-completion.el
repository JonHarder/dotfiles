(recentf-mode +1)

(global-set-key [remap dabbrev-expand] 'hippie-expand)

(which-key-mode 1)

(setopt imenu-auto-rescan t)

(setq enable-recursive-minibuffers t)

(straight-use-package 'savehist)
(savehist-mode)

(setq minibuffer-prompt-properties
	  '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; (straight-use-package 'capf-autosuggest)
;; (add-hook 'eshell-mode-hook #'capf-autosuggest-mode)
;; (with-eval-after-load 'capf-autosuggest
;;   (add-to-list 'capf-autosuggest-capf-functions #'capf-autosuggest-orig-capf))

(use-package completion-preview
  :demand t
  :if (eq completion-framework 'completion-preview)
  :bind
  (:map completion-preview-active-mode-map
		("M-i" . completion-preview-insert-word)
		("M-n" . completion-preview-next-candidate)
		("M-p" . completion-preview-prev-candidate)
		("M-<return>" . completion-preview-insert)
		("<tab>" . completion-preview-complete))
  :config
  (setq completion-preview-minimum-symbol-length 2)
  (global-completion-preview-mode t))

(use-package minibuffer
  :demand t
  :if (eq completion-framework 'completion-preview)
  :bind
  (:map completion-in-region-mode-map
		("M-i" . minibuffer-choose-completion)
		("M-n" . minibuffer-next-completion)
		("M-p" . minibuffer-previous-completion))
  (:map minibuffer-mode-map
		("M-n" . minibuffer-next-completion)
		("M-p" . minibuffer-previous-completion)
		("M-i" . minibuffer-choose-completion))
  :config
  (setq completion-show-help nil)
  (setq completion-show-inline-help nil)
  (setq completions-detailed t)
  (setq completions-format 'one-column)
  (setq completions-max-height 20)
  (setq completion-auto-help t)
  (setq completions-sort 'historical)
  (setq completion-auto-select nil)
  (setq minibuffer-visible-completions t)
  (setq completion-eager-display t)
  (setq completion-eager-update t))

(use-package vertico
  :straight t
  :if (eq completion-framework 'vertico)
  :init
  (vertico-mode 1)
  :bind
  (:map vertico-map
		("<escape>" . keyboard-escape-quit)))

(use-package vertico-directory
  :after vertico
  :bind (:map vertico-map
			  ("DEL" . vertico-directory-delete-char)
			  ("RET" . vertico-directory-enter))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package corfu
  :straight t
  :if (eq completion-framework 'vertico)
  :init
  (setq corfu-auto nil
		corfu-separator ?\s
		tab-always-indent 'complete)
  :config
  (corfu-popupinfo-mode 1)
  (global-corfu-mode 1))

(use-package cape
  :straight t
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-keyword))

(use-package marginalia
  :straight t
  :config
  (marginalia-mode 1))

(straight-use-package 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles partial-completion))))

(use-package consult
  :straight t
  :config
  (setq xref-show-xrefs-function #'consult-xref)
  (with-eval-after-load 'org
	(keymap-set org-mode-map "M-g i" #'consult-imenu))
  :bind
  (("C-x b" . consult-buffer)
   ("M-g i" . consult-imenu)
   ;;; this breaks loading for some reason.
   ;;; emacs complains that `org-mode-map' does not exist.
   ;; :map org-mode-map
   ;; ("M-g i" . consult-imenu)))
   ))

(use-package consult-dir
  :straight t
  :disabled t
  :config
  (eval-after-load 'vertico
    (define-key vertico-map (kbd "M-c") #'consult-dir)))

(use-package embark
  :straight t
  :config
  (with-eval-after-load 'vertico
	(require 'vertico-multiform)
	(add-to-list 'vertico-multiform-categories '(embark-keybinding grid))
	(vertico-multiform-mode))

  ;; bind embark-dwim to C-mouse-1
  (defun my-embark-dwim-click (event)
	"Run `embark-dwim' at the location clicked by the mouse EVENT."
	(interactive "e")
	(mouse-set-point event)
	(embark-dwim))
  :init
  (setq embark-indicators ; default is embark-mixed-indicator
		'(embark-minimal-indicator
		  embark-highlight-indicator
		  embark-isearch-highlight-indicator))
  (setq prefix-help-command #'embark-prefix-help-command)
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  :bind
  (("C-." . embark-act)
   ("M-." . embark-dwim)
   ("s-<mouse-1>" . my-embark-dwim-click)
   :map org-mode-map
   ("C-." . embark-act)
   ("M-." . embark-dwim)))

(use-package embark-consult
  :straight t
  :after (embark consult))

(provide 'my-completion)
