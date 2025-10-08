;; Icons
(straight-use-package 'all-the-icons)
;;; If icons aren't showing up, you may need to install the font.
;;; If so, uncomment and execute the following line.
;; (all-the-icons-install-fonts t)

(straight-use-package 'all-the-icons-completion)
(all-the-icons-completion-mode)
(if (require 'marginalia nil nil)
(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(provide 'my-icons)
