(use-package magit
:straight t)

(use-package jj-mode
  :disabled t
  :straight (:host github :repo "bolivier/jj-mode.el"))

(use-package majutsu
  :straight (:host github :repo "0WD0/majutsu")
  :commands (majutsu)
  :bind ("C-c j" . majutsu))

(provide 'my-jj)
