(use-package magit
:straight t)

(straight-use-package
 '(jj-mode :type git
           :host github
           :repo "bolivier/jj-mode.el"))
(provide 'my-jj)
