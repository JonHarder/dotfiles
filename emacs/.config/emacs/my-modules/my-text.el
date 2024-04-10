(straight-use-package 'mixed-pitch)

(set-fill-column 80)

(defun my-text-mode-hook ()
  (auto-fill-mode 1)
  (flyspell-mode 1))

(add-hook 'text-mode-hook #'my-text-mode-hook)

(provide 'my-text)
