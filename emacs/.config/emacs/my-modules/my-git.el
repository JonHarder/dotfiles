(straight-use-package
 '(magit :type git :host github :repo "magit/magit"))

(straight-use-package 'pr-review)
(setq pr-review-forges-alist
	  ;; default, reads api-host & username from ghub config
      '(("github.com" . (github "api.github.com" "JonHarder"))))

(straight-use-package 'diff-hl)
(global-diff-hl-mode 1)

(provide 'my-git)
