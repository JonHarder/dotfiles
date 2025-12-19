;; -*- lexical-binding: t; -*-

;;; Code:
(setq gnus-select-method '(nnnil nil))

(setq gnus-secondary-select-methods
	  '((nnimap "home"
				(nnimap-address "imap.gmail.com")
				(nnimap-server-port "imaps")
				(nnimap-stream ssl)
				(nnir-search-engine imap)
				(nnmail-expiry-target "nnimap+home:[Gmail]/Trash")
				(nnmail-expiry-wait 'immediate))
		(nnimap "work"
				(nnimap-address "imap.gmail.com")
				(nnimap-server-port "imaps")
				(nnimap-stream ssl)
				(nnir-stream ssl)
				(nnir-search-engine imap)
				(nnmail-expiry-target "nnimap+work:[Gmail]/Trash")
				(nnmail-expiry-wait 'immediate))))

(setq gnus-posting-styles
	  '((".*" ; Matches all groups of messages
		 (address "Jon Harder <jonharder6@gmail.com>"))
		("work" ; Matches Gnus group called "work"
		 (address "Jon Harder <jharder@kipsu.com>")
		 (organization "Kipsu")
		 ("X-Message-SMTP-Method" "smtp smtp.gmail.com 587 jharder@kipsu.com"))))
