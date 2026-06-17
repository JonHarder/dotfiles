(use-package avy
  :straight t
  :config
  (with-eval-after-load 'embark
	(defun avy-action-embark (pt)
	  (unwind-protect
		  (save-excursion
			(goto-char pt)
			(embark-act))
		(select-window
		 (cdr (ring-ref avy-ring 0))))
	  t)
	(setf (alist-get ?. avy-dispatch-alist) #'avy-action-embark))
  (setq avy-timeout-seconds 0.4)
  :bind (("C-c a" . #'avy-goto-char-timer)))

(provide 'my-avy)
