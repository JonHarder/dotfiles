(straight-use-package
 '(hyperbole :type git
             :host github
             :repo "emacs-straight/hyperbole"))
(hyperbole-mode 1)
(evil-define-key '(normal insert visual) 'global
  (kbd "s-<return>") #'hkey-either)
(provide 'my-hyperbole)
