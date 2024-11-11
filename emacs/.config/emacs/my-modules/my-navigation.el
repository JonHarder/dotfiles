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
	 '("Calendar"
	   (display-buffer-below-selected)
	   (window-height . 15)))

(straight-use-package 'ace-jump-mode)

(provide 'my-navigation)
