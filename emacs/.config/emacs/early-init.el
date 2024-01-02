;; disable package.el in favor of straight.el
(setq package-enable-at-startup nil)

(setq gc-cons-threshold most-positive-fixnum
       gc-cons-percentage 0.5)

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold (* 1024 1024 20)
		  gc-cons-percentage 0.2)
	    (message "*** Emacs loaded in %s with %d garbage collections."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time)))
		     gcs-done)))
