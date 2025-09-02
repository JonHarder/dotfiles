(straight-use-package 'ace-window)
(setq aw-keys '(?d ?a ?n ?e ?s ?i ?r ?h ?t))

(setq switch-to-buffer-obey-display-actions t)

(add-to-list 'display-buffer-alist
             '("\\*eshell\\*"
               (display-buffer-at-bottom)
               (side . bottom)
               (slot . 0)
               (window-height . 15)))

(add-to-list 'display-buffer-alist
             '("\\*vterm.*\\*"
               (display-buffer-at-bottom)
               (side . bottom)
               (slot . 0)
               (window-height . 30)))

(add-to-list 'display-buffer-alist
             '("Calendar"
               (display-buffer-below-selected)
               (window-height . 15)))

(defun window-management-mode ()
  "Manipulate windows (size, location, number, etc)."
  (interactive)
  (let ((transient-keymap (make-sparse-keymap)))
    (define-key transient-keymap (kbd "j") (lambda () (interactive) (enlarge-window 5)))
    (define-key transient-keymap (kbd "k") (lambda () (interactive) (shrink-window 5)))
    (define-key transient-keymap (kbd "h") (lambda () (interactive) (shrink-window-horizontally 5)))
    (define-key transient-keymap (kbd "l") (lambda () (interactive) (enlarge-window-horizontally 5)))

    (set-transient-map transient-keymap t nil "Window management keymap: [j]grow height, [k]shrink height, [l]grow width, [h]shrink width")
    (message "Window management transient keymap activated.")))

(evil-define-key 'normal 'global
  (kbd "<leader> w m") #'window-management-mode)

(straight-use-package 'ace-jump-mode)

(provide 'my-navigation)
