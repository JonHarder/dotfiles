(straight-use-package 'ace-window)
(setq aw-keys '(?d ?a ?n ?e ?s ?i ?r ?h ?t))

(setq switch-to-buffer-obey-display-actions t)

(add-to-list 'display-buffer-alist
             '("\\*eshell.*\\*"
               (display-buffer-at-bottom)
               (side . bottom)
               (slot . 0)
               (window-height . .40)))

(add-to-list 'display-buffer-alist
             '("\\*vterm.*\\*"
               (display-buffer-at-bottom)
               (side . bottom)
               (slot . 0)
               (window-height . .40)))

(add-to-list 'display-buffer-alist
             '("Calendar"
               (display-buffer-below-selected)
               (window-height . .20)))

(require 'evil)

(defun window-management-mode ()
  "Manipulate windows (size, location, number, etc)."
  (interactive)
  (let ((transient-keymap (make-sparse-keymap)))
    (define-key transient-keymap (kbd "j") (lambda ()
                                             (interactive) (enlarge-window 3)))
    (define-key transient-keymap (kbd "k") (lambda ()
                                             (interactive) (shrink-window 3)))
    (define-key transient-keymap (kbd "h") (lambda ()
                                             (interactive) (shrink-window-horizontally 3)))
    (define-key transient-keymap (kbd "l") (lambda ()
                                             (interactive) (enlarge-window-horizontally 3)))
    (define-key transient-keymap (kbd "v") #'split-window-right)
    (define-key transient-keymap (kbd "s") #'split-window-below)
    (define-key transient-keymap (kbd "c") #'delete-window)
    (define-key transient-keymap (kbd "o") #'delete-other-windows)
    (define-key transient-keymap (kbd "w") #'other-window)
    (define-key transient-keymap (kbd "L") #'evil-window-right)
    (define-key transient-keymap (kbd "H") #'evil-window-left)
    (define-key transient-keymap (kbd "J") #'evil-window-down)
    (define-key transient-keymap (kbd "K") #'evil-window-up)

    (set-transient-map transient-keymap t nil "Window management keymap: [j]grow height, [k]shrink height, [l]grow width, [h]shrink width
[w]other-window [J]window-down [K]window-up [H]window-left [L]window-right
[v]vertical-split [s]split
[c]close-window [o]close-others")
    (message "Window management transient keymap activated.")))

(evil-define-key 'normal 'global
  (kbd "<leader> w m") #'window-management-mode)

(straight-use-package 'ace-jump-mode)

(provide 'my-navigation)
