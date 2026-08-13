(with-eval-after-load 'consult
  (global-set-key (kbd "C-c t t") #'consult-theme))
(global-set-key (kbd "C-c t l") #'display-line-numbers-mode)
(provide 'my-toggles)
