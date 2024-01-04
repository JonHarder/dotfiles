(setq isearch-lazy-count t
      lazy-count-prefix-format "(%s/%s) "
      lazy-count-suffix-format nil)

(evil-define-key 'normal occur-mode-map
  (kbd "j") #'next-error-no-select
  (kbd "k") #'previous-error-no-select
  (kbd "RET") #'occur-mode-goto-occurrence
  (kbd "q") #'quit-window)

(evil-define-key 'normal grep-mode-map
  (kbd "j") #'next-error-no-select
  (kbd "k") #'previous-error-no-select
  (kbd "q") #'quit-window)

(provide 'my-search)
