(setq-default tab-width 4)

(let ((fnm-bin (expand-file-name "~/.local/share/fnm/aliases/default/bin")))
  (when (file-directory-p fnm-bin)
	(add-to-list 'exec-path fnm-bin)
	(setenv "PATH" (concat fnm-bin ":" (getenv "PATH")))))

(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package lsp-mode
  :straight t
  :commands lsp)

(use-package lsp-ui
  :straight t
  :after (lsp-mode)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions))

(defvar menu-bar-project-menu '())

(use-package eglot
  :hook (eglot-managed-mode . (lambda ()
								(setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)
								(setq eldoc-documentation-functions
									  '(eglot-signature-eldoc-function
										eglot-hover-eldoc-function))))
  :config
  (setq-default
   eglot-workspace-configuration
   '(:yaml
	 (
	  :completion t
	  :validate t
	  :hover t
	  :schemas
	  (:https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.34.4-local/all.json
	   ["k8s/**/*.yaml" "manifests/**/*.yaml" "deploy/**/*.yaml"]
	   :https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json
	   [".github/workflows/*.yml" ".github/workflows/*.yaml"]
	   :https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-action.json
	   [".github/actions/*.yml" ".github/actions/*.yaml"])))))

(use-package eldoc-box
  :straight t
  ;; Uncomment if you want this to pop up automatically
  ;; :hook (eglot-managed-mode . eldoc-box-hover-mode)
  :config
  (set-face-attribute 'eldoc-box-body nil
					  :family (face-attribute 'default :family)
					  :height (face-attribute 'default :height)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
			   `(terraform-mode . ("terraform-ls" "serve"))))

(straight-use-package 'hl-todo)
(global-hl-todo-mode 1)

(electric-pair-mode 1)

(provide 'my-prog-mode)

;; need to set some flymake variable that aparently needs to be in scope
(setq flymake-allowed-file-name-masks nil)
(use-package flycheck
  :straight t
  :config
  (global-flycheck-mode 1))

;; (straight-use-package '(flyover
;;                         :type git
;;                         :host github
;;                         :repo "konrad1977/flyover"))
;; (add-hook 'flycheck-mode-hook #'flyover-mode)
;; (setq flyover-levels '(error warning info))
