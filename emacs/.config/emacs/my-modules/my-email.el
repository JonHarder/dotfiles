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

(setq notmuch-hello-sections
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
	(:name "Pull requests" :query "tag:pullrequest not tag:deleted" :key "p")))

(setq notmuch-search-oldest-first nil)

(evil-define-key 'normal notmuch-hello-mode-map
  (kbd "TAB") #'widget-forward
  (kbd "RET") #'widget-button-press
  (kbd "m") #'notmuch-mua-mail
  (kbd "p") #'notmuch-poll-and-refresh-this-buffer
  (kbd "/") #'notmuch-search
  (kbd ".") #'notmuch-jump-search
  (kbd "q") #'notmuch-bury-or-kill-this-buffer)

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

(evil-define-key 'normal notmuch-search-mode-map
  (kbd "d") #'notmuch-search-delete-threads
  (kbd "a") #'notmuch-search-archive-thread
  (kbd "/") #'notmuch-search
  (kbd "s s") #'notmuch-search-filter
  (kbd "s j") #'notmuch-jump-search
  (kbd "s t") #'notmuch-search-filter-by-tag
  (kbd "j") #'notmuch-search-next-thread
  (kbd "k") #'notmuch-search-previous-thread
  (kbd "g r") #'notmuch-refresh-this-buffer
  (kbd "p") #'notmuch-poll-and-refresh-this-buffer
  (kbd "q") #'notmuch-bury-or-kill-this-buffer
  (kbd "t") #'notmuch-search-add-todo-tag
  (kbd "RET") #'notmuch-search-show-thread
  (kbd "*") #'notmuch-search-tag-all)

(evil-define-key '(visual normal) notmuch-search-mode-map
  (kbd "-") #'notmuch-search-remove-tag
  (kbd "+") #'notmuch-search-add-tag
  (kbd "t") #'notmuch-search-add-todo-tag)

(defun notmuch-show-delete-thread ()
  (interactive)
  (notmuch-show-tag '("+deleted" "-inbox")))

(defun notmuch-show-tag-todo ()
  (interactive)
  (notmuch-show-tag '("+todo")))

(evil-define-key 'normal notmuch-show-mode-map
  (kbd "a") #'notmuch-show-archive-thread
  (kbd "d") #'notmuch-show-delete-thread
  (kbd "t") #'notmuch-add-todo-tag
  (kbd "r") #'notmuch-show-reply-sender
  (kbd "q") #'notmuch-bury-or-kill-this-buffer
  (kbd "g j") #'notmuch-show-next-open-message
  (kbd "g k") #'notmuch-show-previous-open-message
  (kbd "TAB") #'notmuch-show-next-button
  (kbd "RET") #'notmuch-show-toggle-message
  (kbd "+") #'notmuch-show-add-tag
  (kbd "-") #'notmuch-show-remove-tag
  (kbd "t") #'notmuch-show-tag-todo)

(evil-define-key 'normal notmuch-message-mode-map
  (kbd "<leader> m a") #'mail-add-attachment)

(provide 'my-email)
