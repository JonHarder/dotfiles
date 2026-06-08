(use-package magit
:straight t)

(use-package jj-mode
  :straight (:host github :repo "bolivier/jj-mode.el"))

(use-package majutsu
  :straight (:host github :repo "0WD0/majutsu")
  :commands (majutsu))

(provide 'my-jj)
