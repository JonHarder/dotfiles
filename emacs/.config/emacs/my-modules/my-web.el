(when nil
  (evil-define-key 'normal 'eww-mode-map
    (kbd "q") #'quit-window
    (kbd "H") #'eww-back-url
    (kbd "L") #'eww-forward-url
    (kbd "<leader> m b") #'eww-switch-to-buffer
    ;; (kbd "g") #'eww
    ))
(provide 'my-web)

(defun google-this (start end)
  "google-this googles either the selected region or the symbol at point.

It makes use of the `browse-url' method which can be configured
to query using a variety of tools.  By default, it will search
using an external browser configured via the operating system."
  (interactive "rGoogle: ")
  (let ((query (if (region-active-p)
                   (buffer-substring start end)
                 (thing-at-point 'symbol t))))
    (browse-url (format "https://google.com/search?q=%s" query))))

(provide 'my-web)
