(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-indent)
(straight-use-package 'tree-sitter-langs)

(setq treesit-language-source-alist
  '((rust "https://github.com/tree-sitter/tree-sitter-rust")
    (typst "https://github.com/uben0/tree-sitter-typst")))

(setq treesit-load-name-override-list '((rust "libtree-sitter-rust" "tree_sitter_rust")))

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(provide 'my-tree-sitter)
