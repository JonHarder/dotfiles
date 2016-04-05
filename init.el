(package-initialize)

(require 'ob-tangle)
(let ((config-file "~/.emacs.d/emacs.org"))
  (setq org-src-fontify-natively t)
  (org-babel-load-file config-file))
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(spacemacs-theme evil-visual-mark-mode yasnippet smex rust-mode rainbow-delimiters popup-imenu org-bullets multi-term moe-theme magit jabber ido-vertical-mode ido-ubiquitous hydra haskell-mode guide-key git-gutter flycheck evil-surround evil-paredit evil-numbers evil-leader engine-mode elfeed birds-of-paradise-plus-theme base16-theme auto-complete ag ace-window)))
 '(safe-local-variable-values
   (quote
	((haskell-process-use-ghci . t)
	 (haskell-indent-spaces . 4)
	 (encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
