(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

(when nil
  (evil-define-key 'normal ediff-mode-map
		   (kbd "j") #'ediff-next-difference
		   (kbd "k") #'ediff-previous-difference))

(provide 'my-ediff)
