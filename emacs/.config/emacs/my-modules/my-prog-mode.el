(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

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

(straight-use-package 'hl-todo)
(global-hl-todo-mode 1)

(electric-pair-mode 1)

(provide 'my-prog-mode)
