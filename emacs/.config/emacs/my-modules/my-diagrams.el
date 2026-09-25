(use-package d2-mode
  :straight t
  :init
  (setq d2-flags (list "--layout" "elk" "--theme" "200"))
  (define-advice d2-compile
	  (:before (&rest _) setup) (save-buffer)))
		
(provide 'my-diagrams)
