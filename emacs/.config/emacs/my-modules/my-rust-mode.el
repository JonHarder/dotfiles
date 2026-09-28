;; -*- lexical-binding: t; -*-
(use-package rust-mode
  :straight t
  :init
  (setq rust-mode-treesitter-derive t)
  (setq rust-format-on-save t)
  :hook (rust-mode . (lambda () (prettify-symbols-mode))))

(use-package flycheck-rust
  ;; disabled for now because it seems like the hook setup doesn't
  ;; work, and breaks syntax highlighting for every buffer that uses
  ;; flycheck, or.....all of theme
  :disabled t
  :straight t
  :after rust-mode
  :hook (flycheck-mode . #'flycheck-rust-setup))

(provide 'my-rust-mode)
