;; -*- lexical-binding: t; -*-
(use-package rust-mode
  :straight t
  :init
  (setq rust-mode-treesitter-derive t)
  (setq rust-format-on-save t)
  (setq rust-rustfmt-switches '("--edition=2024"))
  :hook (rust-mode . (lambda () (prettify-symbols-mode))))

(provide 'my-rust-mode)
