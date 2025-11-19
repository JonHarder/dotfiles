(recentf-mode +1)

(straight-use-package 'eldoc-box)
(require 'eldoc-box)

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

(straight-use-package 'vertico)
(vertico-mode 1)
(define-key vertico-map (kbd "<escape>") #'keyboard-escape-quit)

(require 'vertico-directory)
(define-key vertico-map (kbd "DEL") #'vertico-directory-delete-char)
(define-key vertico-map (kbd "RET") #'vertico-directory-enter)

(add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

(straight-use-package 'corfu)
(setq corfu-auto t
      corfu-separator ?\s
      tab-always-indent 'complete)
(global-corfu-mode 1)

(straight-use-package 'marginalia)
(marginalia-mode 1)

(straight-use-package 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles partial-completion))))

(straight-use-package 'consult)

(straight-use-package 'consult-dir)
(define-key vertico-map
            (kbd "M-c") #'consult-dir)
(when nil
    (evil-define-key 'normal
		     global-map
		     (kbd "<leader> c d") #'consult-dir))

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
