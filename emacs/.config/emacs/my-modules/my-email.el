(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-stream-type 'tls
      smtpmail-smtp-service 465
      user-mail-address "jharder@kipsu.com")

(straight-use-package 'notmuch)

;; (straight-use-package 'ol-notmuch)

(defun my-notmuch-message-mode-hook ()
  (auto-fill-mode -1)
  (visual-line-mode 1))

  (add-hook 'notmuch-message-mode-hook #'my-notmuch-message-mode-hook)

(setq notmuch-hello-section
	  '(notmuch-hello-insert-saved-searches
		notmuch-hello-insert-search
		notmuch-hello-insert-alltags
		notmuch-hello-insert-footer))

(setq notmuch-saved-searches
  '((:name "attachments" :query "tag:attachment" :key "a")
    (:name "inbox" :query "tag:inbox" :key "i")
    (:name "unread" :query "tag:unread" :key "u")
    (:name "flagged" :query "tag:flagged" :key "f")
    (:name "drafts" :query "tag:draft" :key "d")
    (:name "today's mail" :query "date:today tag:inbox tag:unread" :key ".")
    (:name "Todo" :query "tag:todo" :key "t")
    (:name "This Week" :query "date:mon..today tag:inbox" :key "w")
    (:name "Pull requests" :query "tag:pullrequest not tag:deleted" :key "p")
    (:name "Sent" :query "is:sent" :key "s")))

(setq notmuch-search-oldest-first nil)

(defun notmuch-search-delete-threads (&optional beg end)
  (interactive (notmuch-interactive-region))
  (notmuch-search-tag '("+deleted" "-inbox") beg end)
  (notmuch-search-next-thread))

;; TODO: this function could be made more generic by checking
;; to see which notmuch mode we are in and calling the relevant
;; `notmuch-*-tag' function. e.g. `notmuch-search-tag', `notmuch-show-tag', etc.
(defun notmuch-search-add-todo-tag (&optional beg end)
  (interactive (notmuch-interactive-region))
  (notmuch-search-tag '("+todo") beg end)
  (notmuch-search-next-thread))

(defun notmuch-show-delete-thread ()
  (interactive)
  (notmuch-show-tag '("+deleted" "-inbox")))

(defun notmuch-show-tag-todo ()
  (interactive)
  (notmuch-show-tag '("+todo")))

(provide 'my-email)
