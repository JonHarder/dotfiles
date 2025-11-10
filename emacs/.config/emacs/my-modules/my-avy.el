(defun avy-action-embark (pt)
  (unwind-protect
	  (save-excursion
		(goto-char pt)
		(embark-act))
	(select-window
	 (cdr (ring-ref avy-ring 0))))
  t)

(setq avy-timeout-seconds 0.4)

(with-eval-after-load 'avy
  (setf (alist-get ?. avy-dispatch-alist) #'avy-action-embark))

(provide 'my-avy)
