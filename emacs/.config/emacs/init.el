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

(load-file "local-config.el")

(add-to-list 'load-path (locate-user-emacs-file "my-modules"))

(require 'my-appearance)
(require 'my-modeline)
(require 'my-core)
(require 'my-evil-config)
(require 'my-bindings)

(require 'my-calendar)
(require 'my-completion)
(require 'my-denote)
(require 'my-dired)
(require 'my-docker-mode)
(require 'my-ediff)
(require 'my-email)
(require 'my-epub)
(require 'my-gpg)
(require 'my-help)
(require 'my-http)
(require 'my-ibuffer)
(require 'my-icons)
(require 'my-lisp-mode)
(require 'my-magit)
(require 'my-markup)
(require 'my-navigation)
(require 'my-nushell-mode)
(require 'my-org)
(require 'my-php-mode)
(require 'my-prog-mode)
(require 'my-python-mode)
(require 'my-rest-mode)

(require 'my-rust-mode)
(require 'my-search)
(require 'my-shells)
(require 'my-terraform-mode)
(require 'my-util)
(require 'my-vim-mode)
(require 'my-xref)
