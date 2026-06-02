(use-package kirigami
  :straight t
  :commands (kirigami-open-fold
			 kirigami-open-fold-rec
			 kirigami-close-fold
			 kirigami-toggle-fold
			 kirigami-open-folds
			 kirigami-close-folds-except-current
			 kirigami-close-folds)
  :config
  (meow-normal-define-key
   '("Fo" . kirigami-open-fold)
   '("FO" . kirigami-open-fold-rec)
   '("Fr" . kirigami-open-folds)
   '("Fc" . kirigami-close-fold)
   '("Fm" . kirigami-close-folds)
   '("Fa" . kirigami-toggle-fold))
  ;; configure folding backends
  (add-hook 'emacs-lisp-mode-hook #'outline-minor-mode)
  (add-hook 'lisp-interaction-mode-hook #'hs-minor-mode)
  (add-hook 'c-mode-hook #'hs-minor-mode)
  (add-hook 'rust-mode-hook #'hs-minor-mode)
  (add-hook 'go-mode-hook #'hs-minor-mode)
  (add-hook 'php-mode-hook #'hs-minor-mode))

(use-package outline-indent
  :straight t
  :custom
  (outline-indent-ellipsis " ▼")
  :config
  (add-hook 'python-mode-hook #'outline-indent-minor-mode)
  (add-hook 'python-ts-mode-hook #'outline-indent-minor-mode)
  (add-hook 'yaml-mode-hook #'outline-indent-minor-mode)
  (add-hook 'yaml-ts-mode-hook #'outline-indent-minor-mode))

(provide 'my-fold)
