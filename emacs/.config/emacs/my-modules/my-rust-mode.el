(straight-use-package 'rust-mode)
(setq rust-format-on-save t)
(setq rust-rustfmt-switches '("--edition=2024"))
(add-hook 'rust-mode-hook
		  (lambda () (prettify-symbols-mode)))
(provide 'my-rust-mode)
