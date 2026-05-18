(setq-default tab-width 4)

(let ((fnm-bin (expand-file-name "~/.local/share/fnm/aliases/default/bin")))
  (when (file-directory-p fnm-bin)
	(add-to-list 'exec-path fnm-bin)
	(setenv "PATH" (concat fnm-bin ":" (getenv "PATH")))))

(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(defvar menu-bar-project-menu '())

(add-hook 'eglot-managed-mode-hook
		  (lambda ()
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)
            (setq eldoc-documentation-functions
                  '(eglot-signature-eldoc-function
                    eglot-hover-eldoc-function))))

(setq-default eglot-workspace-configuration
			  '(:yaml
				(:schemas
				 (:https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.34.4-standalone-strict/all.json
				  ["k8s/**/*.yaml" "manifests/**/*.yaml" "deploy/**/*.yaml"]))))

(use-package eldoc-box
  :hook (eglot-managed-mode . eldoc-box-hover-mode))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
			   `(terraform-mode . ("terraform-ls" "serve"))))

(straight-use-package 'hl-todo)
(global-hl-todo-mode 1)

(electric-pair-mode 1)

(provide 'my-prog-mode)

;; need to set some flymake variable that aparently needs to be in scope
(setq flymake-allowed-file-name-masks nil)
(straight-use-package 'flycheck)
(global-flycheck-mode 1)

;; (straight-use-package '(flyover
;;                         :type git
;;                         :host github
;;                         :repo "konrad1977/flyover"))
;; (add-hook 'flycheck-mode-hook #'flyover-mode)
;; (setq flyover-levels '(error warning info))
