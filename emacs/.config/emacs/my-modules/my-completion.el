(setq enable-recursive-minibuffers t)

(straight-use-package 'savehist)
(savehist-mode)

(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

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
(define-Key vertico-map
	    (kbd "M-c") #'consult-dir)
(evil-define-key 'norma cdl
  global-map
  (kbd "<leader> c d") #'consult-dir)

(straight-use-package 'embark)
(straight-use-package 'embark-consult)
(setq prefix-help-command #'embark-prefix-help-command)
(add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
(evil-define-key '(normal motion visual insert emacs) 'global
  (kbd "s-<return>") #'embark-dwim
  (kbd "C-<return>") #'embark-act)
(define-key minibuffer-local-map
  (kbd "C-<return>") #'embark-act)

(provide 'my-completion)
