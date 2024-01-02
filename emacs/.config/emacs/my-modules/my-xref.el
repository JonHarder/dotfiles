(evil-define-key 'normal xref--xref-buffer-mode-map
  (kbd "j") #'xref-next-line
  (kbd "k") #'xref-prev-line
  (kbd "RET") #'xref-goto-xref
  (kbd "q") #'quit-window)

(provide 'my-xref)
