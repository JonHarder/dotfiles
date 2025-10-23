(straight-use-package
 '(magit :type git :host github :repo "magit/magit"))

(straight-use-package 'forge)

(straight-use-package 'diff-hl)
(global-diff-hl-mode 1)

(provide 'my-git)
