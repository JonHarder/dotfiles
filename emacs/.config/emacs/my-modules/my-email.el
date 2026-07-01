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
    (:name "today's mail" :query "date:today tag:inbox" :key ".")
    (:name "Todo" :query "tag:todo" :key "t")
    (:name "This Week" :query "date:mon..today tag:inbox" :key "w")
    (:name "Pull requests" :query "tag:pullrequest not tag:deleted" :key "p")
    (:name "Sent" :query "is:sent" :key "s")))

(setq notmuch-search-oldest-first nil)

;; Put notmuch buffers in motion state
(with-eval-after-load 'meow
  (dolist (mode '(notmuch-hello-mode
                  notmuch-search-mode
                  notmuch-show-mode
                  notmuch-tree-mode))
    (add-to-list 'meow-mode-state-list `(,mode . motion)))
  
  (dolist (mode '(notmuch-message-mode))
    (add-to-list 'meow-mode-state-list `(,mode . insert))))

(defvar my/notmuch-delete-tags
  '("trash")
  "Tags to set on a thread to mark it for deletion.

This is particularly aimed at mail integrations where a tag like 'trash'
is honored as a request to delete the thread.  See
`notmuch-archive-tags' and `notmuch-search-archive-thread' if you simply
want to remove it from your inbox, which is the more standard notmuch
method.")

(defun my/notmuch-search-delete-thread ()
  "Delete thread by adding `my/notmuch-delete-tags' to it."
  (interactive)
  (let ((tags-to-add (mapcar (lambda (tag)
							   (format "+%s" tag))
							 my/notmuch-delete-tags))
		(tags-to-remove '("-inbox" "-unread")))
	(notmuch-search-tag (append tags-to-add tags-to-remove))
	(notmuch-search-next-thread)))

(with-eval-after-load 'notmuch
  (keymap-set notmuch-search-mode-map (kbd "d") #'my/notmuch-search-delete-thread))

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
