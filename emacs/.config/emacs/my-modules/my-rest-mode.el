;; -*- lexical-binding: t; -*-

;;; Code:

(use-package restclient
  :straight (:type git :host github :repo "emacsorphanage/restclient")
  :init
  (setq restclient-enable-eval t)
  :mode ("\\.http$" . restclient-mode))

(provide 'my-rest-mode)
