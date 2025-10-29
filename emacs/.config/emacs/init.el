;;; init --- Basic, initial settings -*- lexical-binding: t -*-

;;; Commentary:
;;; This setups up straight.el for package management and
;;; loads my modules

;;; Code:

(setq straight-repository-branch "develop")

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-verision 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
		(url-retrieve-synchronously
		 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
		 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq straight-built-in-pseudo-packages
	  '(emacs nadvice python image-mode project flymake))

(load-file (expand-file-name "local-config.el" user-emacs-directory))

(add-to-list 'load-path (locate-user-emacs-file "my-modules"))

(require 'my-appearance)
(require 'my-util)
(require 'my-core)
(require 'my-mouse)
(require 'my-meow)
(require 'my-modeline)

(require 'my-calendar)
(require 'my-completion)
(require 'my-tree-sitter)
(require 'my-gtd)
(require 'my-denote)
(require 'my-dired)
(require 'my-docker-mode)
(require 'my-ediff)
(require 'my-email)
(require 'my-epub)
(require 'my-feed)
(require 'my-gpg)
(require 'my-go-mode)
(require 'my-help)
(require 'my-http)
(require 'my-icons)
(require 'my-lisp-mode)
(require 'my-git)
(require 'my-markup)
(require 'my-navigation)
(require 'my-web)
(require 'my-neon-mode)
(require 'my-nushell-mode)
(require 'my-org)
(require 'my-php-mode)
(require 'my-prog-mode)
(require 'my-python-mode)
(require 'my-rest-mode)
(require 'my-text)
(require 'my-timers)
(require 'my-just)
(require 'my-jj)
(require 'my-avy)

(require 'my-rust-mode)
(require 'my-search)
(require 'my-shells)
(require 'my-typst)
(require 'my-terraform-mode)
(require 'my-vim-mode)

(provide 'init)
;;; init.el ends here
