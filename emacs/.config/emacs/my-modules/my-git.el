(straight-use-package
 '(magit :type git :host github :repo "magit/magit"))
(evil-set-initial-state 'magit-status-mode 'normal)

(evil-define-key '(normal motion) magit-status-mode-map
  (kbd "?") #'magit-dispatch
  (kbd "b") #'magit-branch
  (kbd "q") #'magit-mode-bury-buffer
  (kbd "c") #'magit-commit
  (kbd "e") #'magit-ediff-dwim
  (kbd "f") #'magit-fetch
  (kbd "j") #'magit-next-line
  (kbd "k") #'magit-previous-line
  (kbd "}") #'magit-section-forward
  (kbd "{") #'magit-section-backward
  (kbd "TAB") #'magit-section-toggle
  (kbd "RET") #'magit-visit-thing
  (kbd "i") #'magit-gitignore
  (kbd "l") #'magit-log
  (kbd "m") #'magit-merge
  (kbd "P") #'magit-push
  (kbd "p") #'magit-pull
  (kbd "M") #'magit-remote
  (kbd "r") #'magit-rebase
  (kbd "t") #'magit-tag
  (kbd "R") #'magit-reset
  (kbd "$") #'magit-process-buffer
  ;; delete
  (kbd "d d") 'magit-discard
  (kbd "z") #'magit-stash)

(evil-define-key '(normal visual) magit-status-mode-map
	(kbd "s") 'magit-stage
	(kbd "u") 'magit-unstage)

(evil-define-key '(normal motion) magit-log-mode-map
  (kbd "q") 'magit-log-bury-buffer
  (kbd "r") 'magit-rebase
  (kbd "j") 'magit-next-line
  (kbd "k") 'magit-previous-line
  (kbd "}") 'magit-section-forward
  (kbd "{") 'magit-section-backward
  (kbd "RET") 'magit-show-commit
  (kbd "f") #'magit-fetch)

(evil-define-key '(normal) git-rebase-mode-map
(kbd "p") #'git-rebase-pick
(kbd "b") #'git-rebase-break
    (kbd "e") #'git-rebase-edit
(kbd "dd") #'git-rebase-kill-line
(kbd "s") #'git-rebase-squash
    (kbd "r") #'git-rebase-reword
(kbd "f") #'git-rebase-fixup
(kbd "J") #'git-rebase-move-line-down
(kbd "K") #'git-rebase-move-line-up)

(evil-define-key '(normal motion) magit-revision-mode-map
  (kbd "j") 'magit-next-line
  (kbd "k") 'magit-previous-line
  (kbd "}") 'magit-section-forward
  (kbd "{") 'magit-section-backward
  (kbd "TAB") 'magit-section-toggle
  (kbd "RET") 'magit-visit-thing
  (kbd "q") 'magit-mode-bury-buffer)

(straight-use-package 'forge)

(straight-use-package 'git-gutter)
(global-git-gutter-mode)

(provide 'my-git)
