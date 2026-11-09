;; -*- lexical-binding: t; -*-

(delete-selection-mode 1)

;; bind `kill-paragraph' to something
(global-set-key (kbd "C-s-k") #'kill-paragraph)

(use-package expand-region
  :straight t
  :bind ("C-=" . er/expand-region))

(use-package change-inner
  :straight t
  :bind (("M-i" . change-inner)
		 ("M-o" . change-outer)))

(provide 'my-editor)
;;; my-editor.el ends here
