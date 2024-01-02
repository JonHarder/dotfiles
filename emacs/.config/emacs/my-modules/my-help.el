(straight-use-package 'helpful)

(evil-define-key '(normal motion) helpful-mode-map
  (kbd "q") #'quit-window)

(evil-define-key '(normal motion) help-mode-map
  (kbd "q") #'quit-window)

(evil-define-key '(normal motion) Info-mode-map
  (kbd "<tab>") 'Info-next-reference
  (kbd "S-<tab>") 'Info-prev-reference
  (kbd "RET") 'Info-follow-nearest-node
  (kbd "d") 'Info-directory
  (kbd "u") 'Info-up
  (kbd "s") 'Info-search
  (kbd "i") 'Info-index
  (kbd "a") 'info-apropos
  (kbd "q") 'quit-window

  (kbd "y y") 'Info-copy-current-node-name

  [mouse-1] 'Info-mouse-follow-nearest-node
  [follow-link] 'mouse-face
  ;; goto
  (kbd "g m") 'Info-menu
  (kbd "g t") 'Info-top-node
  (kbd "g T") 'Info-toc
  (kbd "g j") 'Info-next
  (kbd "g k") 'Info-prev)

(evil-define-key 'normal Man-mode-map
  (kbd "q") #'quit-window)

(provide 'my-help)
