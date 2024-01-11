(evil-define-key 'normal epa-key-list-mode-map
  (kbd "TAB") #'forward-button
  (kbd "m") #'epa-mark-key
  (kbd "u") #'epa-unmark-key)
