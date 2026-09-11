;; -*- lexical-binding: t; -*-

(with-eval-after-load 'consult
  (global-set-key (kbd "C-c t t") #'consult-theme))
(global-set-key (kbd "C-c t l") #'display-line-numbers-mode)

(use-package olivetti
  :straight t
  :bind
  ("C-c t o" . olivetti-mode))

(use-package imenu-list
  :straight t
  :bind
  ("C-c t i" . imenu-list-smart-toggle))

(provide 'my-toggles)
