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

(use-package vertico
  :straight t
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

(straight-use-package 'embark)
(straight-use-package 'embark-consult)

;; This sets embark as the help command when I'm looking for which
;; keybindings are available to complete a given prefix.  The
;; advantage of this is
;;
;; 1.) I only have to see the popup when I want to 
;;
;; 2.) the selection is filterable using the names of the functions
(setq prefix-help-command #'embark-prefix-help-command)
(add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)

(setq embark-indicators
      '(embark-minimal-indicator  ; default is embark-mixed-indicator
        embark-highlight-indicator
        embark-isearch-highlight-indicator))

;; This configures vertico to display these embark action tips in a
;; grid-like manner, similar to which-key.

;; (setq vertico-multiform-categories nil)
(with-eval-after-load 'vertico
  (require 'vertico-multiform)
  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid))
  (vertico-multiform-mode))

;;; bindings
(global-set-key (kbd "C-.") #'embark-act)
(global-set-key (kbd "M-.") #'embark-dwim)
;; this is not a valid key definition for some reason, even though it is
;; for `global-set-key'
(with-eval-after-load 'org
  (keymap-set org-mode-map "C-." #'embark-act)
  (keymap-set org-mode-map "M-." #'embark-dwim))

(provide 'my-completion)
