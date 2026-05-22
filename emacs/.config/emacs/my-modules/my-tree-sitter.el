(use-package tree-sitter
  :straight t
  :hook ((go-mode . tree-sitter-mode)
		 (python-mode . tree-sitter-mode)
		 (terraform-mode . tree-sitter-mode)
		 (bash-ts-mode . tree-sitter-mode))
  :config
  (use-package tree-sitter-langs
	:straight t)
  (use-package tree-sitter-indent
	:straight t))

(setq treesit-language-source-alist
  '((rust "https://github.com/tree-sitter/tree-sitter-rust")
    (typst "https://github.com/uben0/tree-sitter-typst")))

(setq treesit-load-name-override-list '((rust "libtree-sitter-rust" "tree_sitter_rust")))

;; (global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(provide 'my-tree-sitter)
