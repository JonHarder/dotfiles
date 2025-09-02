(straight-use-package 'symex)
(symex-initialize)

(evil-define-key 'normal symex-mode-map
  (kbd "s-;") #'symex-mode-inferface)
