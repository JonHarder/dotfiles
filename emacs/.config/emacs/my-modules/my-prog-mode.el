(setq-default tab-width 4)

(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-ui)

(defvar menu-bar-project-menu '())

(add-hook 'eglot-managed-mode-hook
	  (lambda ()
	(setq eldoc-documentation-strategy #'eldoc-documentation-compose)
	(setq eldoc-documentation-functions
		  '(flymake-eldoc-function
		eglot-signature-eldoc-function
		eglot-hover-eldoc-function))))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
	   `(terraform-mode . ("terraform-ls" "serve"))))

(with-eval-after-load 'eglot
  (evil-define-key 'normal prog-mode-map
	(kbd "<leader> r d") #'eglot-find-declaration
	;; #'eglot-find-implementation is already handled by embark
	(kbd "<leader> r r") #'xref-find-references))

(straight-use-package 'hl-todo)
(global-hl-todo-mode 1)

(electric-pair-mode 1)

(provide 'my-prog-mode)

(straight-use-package 'flycheck)
(global-flycheck-mode 1)

(straight-use-package '(flyover
                        :type git
                        :host github
                        :repo "konrad1977/flyover"))
(add-hook 'flycheck-mode-hook #'flyover-mode)
(setq flyover-levels '(error warning info))
