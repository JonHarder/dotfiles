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
	(:name "today's mail" :query "date:today" :key "t")))

(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-stream-type 'tls
      smtpmail-smtp-service 465
      user-mail-address "jharder@kipsu.com")

(provide 'my-email)
