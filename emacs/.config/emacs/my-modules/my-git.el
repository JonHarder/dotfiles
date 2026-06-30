(straight-use-package
 '(magit :type git :host github :repo "magit/magit"))

(use-package pr-review
  :bind (:map pr-review-mode-map
			  ("m" . pr-review-merge)
			  ("g" . pr-review-refresh))
  :config
  (setq pr-review-forges-alist
		'(("github.com" . (github "api.github.com" "JonHarder")))))

(straight-use-package 'diff-hl)
(global-diff-hl-mode 1)

(provide 'my-git)
