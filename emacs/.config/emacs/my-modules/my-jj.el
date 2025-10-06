(straight-use-package
 '(jj-mode :type git
           :host github
           :repo "bolivier/jj-mode.el"))
(require 'evil)
(require 'magit)

;; NOTE: as of [2025-09-13], jj-mode does not have support for
;; interactive commands like squash, split, resolve, etc.  this would
;; require more extensive UI editing features, and how they would
;; integrate with the philosophy of Jujutsu is still under
;; consideration.  Mainly, how would you interactively add up hunks
;; for a command like ~squash -i~ without implicitly bringing
;; something like git's staging area back?
(evil-define-key 'normal jj-mode-map
  (kbd "TAB") #'magit-section-toggle
  (kbd "RET") #'jj-enter-dwim
  (kbd "j") #'magit-section-forward
  (kbd "k") #'magit-section-backward
  (kbd "b") #'jj-bookmark-transient
  (kbd "c") #'jj-commit
  (kbd "d") #'jj-describe
  (kbd "e") #'jj-edit-changeset
  (kbd "n") #'jj-new
  (kbd "a") #'jj-abandon
  (kbd "r") #'jj-rebase-transient
  (kbd "D") #'jj-diff
  (kbd "t") #'jj-tug
  (kbd "u") #'jj-undo
  (kbd ".") #'jj-git-transient
  (kbd "g r") #'jj-log-refresh)

(provide 'my-jj)
