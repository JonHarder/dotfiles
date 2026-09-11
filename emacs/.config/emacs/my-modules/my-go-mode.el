;; -*- lexical-binding: t; -*-
(use-package go-mode
  :straight t
  :init
  (setq gofmt-command "/usr/local/go/bin/gofmt")
  :config
  (defun my-go-mode-hook ()
	(when (eq major-mode 'go-mode)
      (gofmt-before-save)))
  (setenv "PATH"
          (concat
           "/usr/local/go/bin:"
           "/Library/TeX/texbin:"
           "/opt/homebrew/bin:"
           (getenv "PATH")))
  :hook (before-save . my-go-mode-hook))

(provide 'my-go-mode)
