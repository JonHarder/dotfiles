(use-package tree-sitter
  :straight t
  :hook ((go-mode . tree-sitter-mode)
		 (python-mode . tree-sitter-mode)
		 (terraform-mode . tree-sitter-mode)
		 (bash-ts-mode . tree-sitter-mode))
  :config
  (setq treesit-auto-install-grammar 'always)
  (setq treesit-enabled-modes t)
  (use-package tree-sitter-langs
	:straight t)
  (use-package tree-sitter-indent
	:straight t))

;; NOTE: this should no longer be necessary with emacs 31 tree sitter improvements
;; (setq treesit-language-source-alist
;; 	  '((rust "https://github.com/tree-sitter/tree-sitter-rust")
;; 		(typst "https://github.com/uben0/tree-sitter-typst")))

(setq treesit-load-name-override-list '((rust "libtree-sitter-rust" "tree_sitter_rust")))

;; (global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(provide 'my-tree-sitter)
