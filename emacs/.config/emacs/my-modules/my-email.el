(straight-use-package 'notmuch)

(add-to-list 'load-path "/opt/homebrew/Cellar/mu/1.10.7/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)

(setq mu4e-attachments-dir "~/Downloads"
      mu4e-maildir "~/Mail"
      mu4e-get-mail-command "mbsync -a"
      mu4e-refile-folder "/Archive"
      mu4e-sent-folder "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder "/Trash")

(setq smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      user-mail-address "jharder@kipsu.com")

(provide 'my-email)
