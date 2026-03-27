(straight-use-package 'markdown-mode)
(setq markdown-header-scaling t)

(straight-use-package 'json-mode)

(straight-use-package 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))

(straight-use-package 'json-mode)

(provide 'my-markup)
