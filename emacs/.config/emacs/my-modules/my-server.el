(require 'server)

(server-start)

(defun my/server-edit-save ()
  "Save buffer without prompting, then finish server edit."
  (interactive)
  (when (buffer-modified-p)
    (save-buffer))
  (server-edit))

(add-hook 'server-switch-hook
		  (lambda ()
			(local-set-key (kbd "C-c C-c") #'my/server-edit-save)))

(provide 'my-server)
