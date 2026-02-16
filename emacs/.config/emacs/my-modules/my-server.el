(server-start)

(defun my/server-edit-save ()
  "Save buffer without prompting, then finish server edit."
  (interactive)
  (when (buffer-modified-p)
    (save-buffer))
  (server-edit))

(add-hook 'server-switch-hook
		  (lambda ()
			(local-set-key (kbd "C-x #") #'my/server-edit-save)))

(provide 'my-server)
