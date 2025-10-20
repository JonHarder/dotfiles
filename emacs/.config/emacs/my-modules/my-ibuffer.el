(when nil
  (evil-define-key '(normal motion) ibuffer-mode-map
    (kbd "<leader> x") 'execute-extended-command
    ;; navigation
    (kbd "{") 'ibuffer-backwards-next-marked
    (kbd "}") 'ibuffer-forward-next-marked

    ;; mark commands
    (kbd "J") 'ibuffer-jump-to-buffer
    (kbd "m") 'ibuffer-mark-forward
    (kbd "~") 'ibuffer-toggle-marks
    (kbd "u") 'ibuffer-unmark-forward
    (kbd "DEL") 'ibuffer-unmark-backward
    (kbd "U") 'ibuffer-unmark-all-marks
    (kbd "* *") 'ibuffer-mark-special-buffers
    (kbd "* m") 'ibuffer-mark-by-mode
    (kbd "* i") 'ibuffer-mark-unsaved-buffers
    (kbd "* n") #'ibuffer-mark-by-name-regexp
    (kbd "* r") 'ibuffer-mark-read-only-buffers
    (kbd "* /") 'ibuffer-mark-dired-buffers
    (kbd "* h") 'ibuffer-mark-help-buffers
    (kbd "d") 'ibuffer-mark-for-delete

    ;; filtering
    (kbd "/ m") #'ibuffer-filter-by-mode
    (kbd "/ i") #'ibuffer-filter-by-modified
    (kbd "/ n") #'ibuffer-filter-by-name
    (kbd "/ f") #'ibuffer-filter-by-filename
    (kbd "/ .") #'ibuffer-filter-by-file-extension
    (kbd "/ s") #'ibuffer-save-filters
    (kbd "/ /") #'ibuffer-filter-disable


    ;; actions
    (kbd "x") 'ibuffer-do-kill-on-deletion-marks
    (kbd "gr") 'ibuffer-update

    ;; immediate actions
    (kbd "A") 'ibuffer-do-view
    (kbd "D") 'ibuffer-do-delete
    (kbd "K") 'ibuffer-do-kill-lines))

(provide 'my-ibuffer)
