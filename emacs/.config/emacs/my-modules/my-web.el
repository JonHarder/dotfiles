(evil-define-key 'normal eww-mode-map
  (kbd "q") #'quit-window
  (kbd "H") #'eww-back-url
  (kbd "L") #'eww-forward-url
  (kbd "<leader> m b") #'eww-switch-to-buffer
  ;; (kbd "g") #'eww
  )
(provide 'my-web)
