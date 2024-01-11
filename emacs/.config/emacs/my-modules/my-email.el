(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-stream-type 'tls
      smtpmail-smtp-service 465
      user-mail-address "jharder@kipsu.com")

(straight-use-package 'notmuch)

(setq notmuch-hello-sections
      '(notmuch-hello-insert-saved-searches
	notmuch-hello-insert-search
	notmuch-hello-insert-alltags
	notmuch-hello-insert-footer))

(setq notmuch-saved-searches
      '((:name "inbox" :query "tag:inbox" :key "i")
	(:name "unread" :query "tag:unread" :key "u")
	(:name "flagged" :query "tag:flagged" :key "f")
	(:name "drafts" :query "tag:draft" :key "d")
	(:name "today's mail" :query "date:today tag:inbox" :key "t")))

(evil-define-key 'normal notmuch-hello-mode-map
  (kbd "TAB") #'widget-forward
  (kbd "RET") #'widget-button-press
  (kbd "i") #'notmuch-search
  (kbd "s") #'notmuch-search
  (kbd "g") #'notmuch-jump-search
  (kbd "q") #'notmuch-bury-or-kill-this-buffer)

(evil-define-key 'normal notmuch-search-mode-map
  (kbd "j") #'notmuch-search-next-thread
  (kbd "k") #'notmuch-search-previous-thread
  (kbd "q") #'notmuch-bury-or-kill-this-buffer
  (kbd "RET") #'notmuch-search-show-thread
  (kbd "-") #'notmuch-search-remove-tag
  (kbd "+") #'notmuch-search-add-tag
  (kbd "*") #'notmuch-search-tag-all)

(defun notmuch-search-delete-threads (&optional beg end)
  (interactive (notmuch-interactive-region))
  (notmuch-search-tag '("+deleted" "-inbox") beg end))

(defun notmuch-search-add-todo-tag (&optional beg end)
  (interactive (notmuch-interactive-region))
  (notmuch-search-tag '("+todo") beg end))

(evil-define-key 'normal notmuch-search-mode-map
  (kbd "d") #'notmuch-search-delete-threads
  (kbd "a") #'notmuch-search-archive-thread
  (kbd "t") #'notmuch-search-add-todo-tag
  (kbd "r") #'notmuch-refresh-this-buffer)

(evil-define-key 'normal notmuch-show-mode-map)

(provide 'my-email)
