(straight-use-package 'evil)
(setq evil-vsplit-window-right t)
(setq evil-split-window-below t)
(setq evil-undo-system 'undo-redo)
(evil-mode 1)

(defvar my-normal-modes
  '(Info-mode
    Man-mode
    magit-log-mode
    occur-mode
    magit-revision-mode
    notmuch-hello-mode
    notmuch-search-mode
    notmuch-show-mode
    ibuffer-mode
    calendar-mode
    org-agenda-mode
    grep-mode)
  "Modes for which evil should begin in normal mode.")

(dolist (mode my-normal-modes)
  (evil-set-initial-state mode 'normal))

(defvar my-insert-modes
  '(vterm-mode
    eshell-mode
    eat-mode)
  "Modes for which evil should begin in insert mode.")

(dolist (mode my-insert-modes)
  (evil-set-initial-state mode 'insert))

(defvar my-emacs-modes '()
  "Modes to start in native emacs mode.")

(dolist (mode my-emacs-modes)
  (evil-set-initial-state mode 'emacs))

(setq evil-normal-state-cursor '(box "light blue")
      evil-insert-state-cursor '(bar "medium sea green")
      evil-visual-state-cursor '(hollow "orange"))

(evil-set-leader 'normal (kbd "<SPC>"))

(straight-use-package 'evil-surround)
(global-evil-surround-mode 1)

(straight-use-package 'evil-numbers)
(define-key evil-normal-state-map (kbd "C-a") #'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-x") #'evil-numbers/dec-at-pt)

(straight-use-package 'evil-commentary)
(evil-commentary-mode)

(provide 'my-evil-config)
