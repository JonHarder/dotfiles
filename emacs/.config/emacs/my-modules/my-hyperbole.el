;;; my-hyperbole --- Summary
;;; Commentary:

;;; Code:
(use-package hyperbole
  :disabled t
  :straight t
  :config
  (hyperbole-mode 1)
  (hywiki-mode :all)
  (customize-save-variable 'hsys-org-enable-smart-keys t))

(provide 'my-hyperbole)
;;; my-hyperbole.el ends here
