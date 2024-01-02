(straight-use-package 'rust-mode)
(setq rust-format-on-save t)
(add-hook 'rust-mode-hook
	  (lambda () (prettify-symbols-mode)))
(provide 'my-rust-mode)
