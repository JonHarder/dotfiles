(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-indent)
(straight-use-package 'tree-sitter-langs)

(setq treesit-language-source-alist
  '((rust "https://github.com/tree-sitter/tree-sitter-rust")

(setq treesit-load-name-override-list '((rust "libtree-sitter-rust" "tree_sitter_rust")))

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(provide 'my-tree-sitter)
