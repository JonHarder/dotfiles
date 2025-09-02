(straight-use-package 'howm)
;; Commenting this out for now since getting all the linking working
;; in org is a bit of a pain
;; NOTE: must be set before howm itself loads
;; (require 'howm-org)
(setq howm-follow-theme t)

(require 'howm)
(add-hook 'howm-mode-hook #'howm-mode-set-buffer-name)
(add-hook 'after-save-hook #'howm-mode-set-buffer-name)

;; Bindings
(evil-define-key 'normal howm-mode-map
  (kbd "RET") #'action-lock-magic-return)

(define-key howm-menu-mode-map (kbd "j") #'next-line)
(define-key howm-menu-mode-map (kbd "k") #'previous-line)

(evil-define-key 'normal howm-view-summary-mode-map
  (kbd "j") #'next-line
  (kbd "k") #'previous-line
  (kbd "r") #'howm-view-sort-reverse
  (kbd "J") #'riffle-scroll-other-window
  (kbd "K") #'riffle-scroll-other-window-down
  (kbd "s") #'howm-list-grep-fixed
  (kbd "S") #'howm-view-sort
  (kbd "/") #'howm-list-grep
  (kbd "RET") #'howm-view-summary-open
  (kbd "q") #'howm-view-kill-buffer)

(provide 'my-howm)
