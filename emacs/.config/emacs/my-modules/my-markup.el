;; -*- lexical-binding: t; -*-
(straight-use-package 'markdown-mode)
(use-package markdown-ts-mode
  :mode ("\\.md\\'" "\\.mdx\\'" "\\.markdown\\'")
  :config
  (require 'markdown-ts-mode-x))

(use-package markdown-ts-appear
  :straight t
  :hook (markdown-ts-mode . markdown-ts-appear-mode))

(setq markdown-header-scaling t)

(straight-use-package 'json-mode)

(straight-use-package 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))

(straight-use-package 'json-mode)

(provide 'my-markup)
