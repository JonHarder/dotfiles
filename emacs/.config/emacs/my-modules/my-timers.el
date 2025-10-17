(straight-use-package 'tmr)
(require 'tmr)
(with-eval-after-load 'tmr
  (evil-define-key 'normal 'global
	(kbd "<leader> . n") #'tmr-with-details
	(kbd "<leader> . .") #'tmr-tabulated-view)
  (evil-define-key 'normal tmr-tabulated-mode-map
	(kbd "g r") #'tmr-tabulated--refresh
	(kbd "x") #'tmr-cancel))
(provide 'my-timers)
