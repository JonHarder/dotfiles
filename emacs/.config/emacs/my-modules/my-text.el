(straight-use-package 'mixed-pitch)

(defun my-text-mode-hook ()
  (auto-fill-mode 1)
  (flyspell-mode 1)
  (mixed-pitch-mode 1))

(add-hook 'text-mode-hook #'my-text-mode-hook)

(provide 'my-text)
