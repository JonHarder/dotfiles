(evil-define-key '(insert emacs visual) 'global
  (kbd "s-x") #'execute-extended-command)

(require 'evil)

(evil-define-key 'normal 'global
  (kbd "<leader> ;") #'eval-expression
  (kbd "<leader> q") #'save-buffers-kill-terminal
  (kbd "<leader> x") #'execute-extended-command
  (kbd "<leader> z") #'ispell-word
  (kbd "<leader> TAB") (lambda ()
                         (interactive)
                         (switch-to-buffer nil))
  (kbd "g r") #'revert-buffer
  (kbd "SPC SPC") #'other-window
  ;; App launcher
  (kbd "<leader> a c") #'calendar
  (kbd "<leader> a a") #'org-agenda
  (kbd "<leader> a n") #'notmuch
  (kbd "<leader> a =") #'calc
  ;; buffers
  (kbd "<leader> b b") #'consult-buffer
  (kbd "<leader> b n") #'next-buffer
  (kbd "<leader> b p") #'previous-buffer
  (kbd "<leader> b s") #'save-buffer
  (kbd "<leader> b i") #'ibuffer
  (kbd "<leader> b d") #'evil-delete-buffer
  (kbd "<leader> b c") #'kill-current-buffer
  (kbd "<leader> b r") #'rename-buffer
  ;; config related commands
  (kbd "<leader> c .") #'find-config
  (kbd "<leader> c r") (lambda () (interactive) (load-file user-init-file))
  (kbd "<leader> c t") #'consult-theme
  ;; dired
  (kbd "<leader> d d") #'dired-jump
  (kbd "<leader> d j") #'dired
  ;; evaluation
  (kbd "<leader> e e") #'eval-last-sexp
  (kbd "<leader> e d") #'eval-defun
  ;; files
  (kbd "<leader> f b") #'bookmark-jump
  (kbd "<leader> f d") #'diff-buffer-with-file
  (kbd "<leader> f i") (lambda () (interactive) (find-file org-default-notes-file))
  (kbd "<leader> f B") #'bookmark-set
  (kbd "<leader> f c") #'find-config
  (kbd "<leader> f f") #'find-file
  (kbd "<leader> f r") #'rename-visited-file
  ;; getting things done (gtd)
  (kbd "<leader> g s") #'gtd-find-schedule
  (kbd "<leader> g o") #'gtd-find-oneoff
  (kbd "<leader> g i") #'gtd-find-inbox
  (kbd "<leader> g c") #'gtd-capture
  ;; help(ful) commands
  (kbd "<leader> h i") (lambda (node) (interactive "MNode: ")
                         (info (format "(%s)Top" node)))
  (kbd "<leader> h M") #'info-emacs-manual
  (kbd "<leader> h v") #'helpful-variable
  (kbd "<leader> h f") #'helpful-function
  (kbd "<leader> h k") #'helpful-key
  (kbd "<leader> h m") #'describe-mode
  (kbd "<leader> h r") #'info-display-manual
  ;; imenu
  (kbd "<leader> i") #'consult-outline
  ;; jumping (ace)
  (kbd "<leader> j") #'ace-jump-word-mode
  ;; org
  (kbd "<leader> o c") #'org-capture
  (kbd "<leader> o s") #'org-store-link
  ;; occur
  (kbd "<leader> o o") #'occur
  ;; project
  (kbd "<leader> p !") #'project-shell-command
  (kbd "<leader> p &") #'project-async-shell-command
  (kbd "<leader> p D") #'project-dired
  (kbd "<leader> p b") #'project-switch-to-buffer
  (kbd "<leader> p c") #'compile
  (kbd "<leader> p d") #'project-find-dir
  (kbd "<leader> p e") #'project-eshell
  (kbd "<leader> p f") #'project-find-file
  (kbd "<leader> p m") #'magit-project-status
  (kbd "<leader> p k") #'project-kill-buffers
  (kbd "<leader> p p") #'project-switch-project
  (kbd "<leader> p /") #'project-find-regexp
  ;; shells
  (kbd "<leader> s e") #'eshell-here
  ;;; (kbd "<leader> s t") #'eat
  (kbd "<leader> s t") #'multi-vterm
  ;; tab commands
  (kbd "<leader> t t") #'tab-switch
  (kbd "<leader> t n") #'tab-new
  (kbd "<leader> t j") #'tab-next
  (kbd "<leader> t k") #'tab-previous
  (kbd "<leader> t f") #'find-file-other-tab
  (kbd "<leader> t b") #'switch-to-buffer-other-tab
  (kbd "<leader> t r") #'tab-rename
  (kbd "<leader> t d") #'tab-close
  ;; windows
  (kbd "<leader> .") #'evil-window-split
  (kbd "<leader> /") #'evil-window-vsplit
  (kbd "<leader> w w") #'ace-window
  (kbd "<leader> w h") #'evil-window-left
  (kbd "<leader> w l") #'evil-window-right
  (kbd "<leader> w j") #'evil-window-down
  (kbd "<leader> w k") #'evil-window-up
  (kbd "<leader> w H") #'evil-window-move-far-left
  (kbd "<leader> w L") #'evil-window-move-far-right
  (kbd "<leader> w K") #'evil-window-move-very-top
  (kbd "<leader> w J") #'evil-window-move-very-bottom
  (kbd "<leader> w c") #'evil-window-delete
  (kbd "<leader> w v") #'evil-window-vsplit
  (kbd "<leader> w s") #'evil-window-split
  (kbd "<leader> w o") #'delete-other-windows
  (kbd "<leader> w =") #'balance-windows
  ;; toggles
  (kbd "<leader> T t") #'modus-themes-toggle
  (kbd "<leader> T n") #'display-line-numbers-mode
  (kbd "<leader> T s") #'spacious-padding-mode
  (kbd "<leader> T w") #'whitespace-mode)

(evil-define-key 'normal 'global
  "s" nil)
(evil-define-key 'normal 'global
  ;; (kbd "s l") #'forward-sexp
  (kbd "s h") #'backward-sexp
  (kbd "s j") #'down-list
  (kbd "s k") #'backward-up-list
  (kbd "s d") #'kill-sexp
  (kbd "s $") #'forward-sentence
  (kbd "s 0") #'backward-sentence)

(provide 'my-bindings)
