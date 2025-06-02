(straight-use-package 'go-mode)
(setq gofmt-command "/usr/local/go/bin/gofmt")
(setenv "PATH"
	(concat
	 "/usr/local/go/bin:"
	 (getenv "PATH")))
(defun my-go-mode-hook ()
  (when (eq major-mode 'go-mode)
	(gofmt-before-save)))
(add-hook 'before-save-hook #'my-go-mode-hook)
(provide 'my-go-mode)
