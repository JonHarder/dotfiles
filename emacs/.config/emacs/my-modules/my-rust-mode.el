;; -*- lexical-binding: t; -*-
(use-package rust-mode
  :straight t
  :init
  (setq rust-mode-treesitter-derive t)
  (setq rust-format-on-save t)
  :hook (rust-mode . (lambda () (prettify-symbols-mode))))

(provide 'my-rust-mode)
