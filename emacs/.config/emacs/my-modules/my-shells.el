;; -*- lexical-binding: t; -*-
(setq explicit-shell-file-name "/opt/homebrew/bin/nu"
	  explicit-shell-file-name "/bin/zsh"
	  explicit-zsh-args '("--login" "--interactive"
						  shell-file-name "/bin/zsh"))

(setenv "GITHUB_KEY" "/Users/jharder/.ssh/docker_github")
(add-to-list 'exec-path "/usr/local/go/bin")
(add-to-list 'exec-path "/opt/homebrew/bin")
(add-to-list 'exec-path "/Library/TeX/texbin")
(add-to-list 'exec-path "/Users/jharder/.rustup/toolchains/stable-aarch64-apple-darwin/bin")

(add-hook 'eshell-mode-hook
          (lambda ()
            (setenv "TERM" "eterm")
            (setenv "PAGER" "cat")))

(require 'eshell)
(add-to-list 'eshell-modules-list 'eshell-smart)

(straight-use-package 'eshell-syntax-highlighting)
(require 'eshell-syntax-highlighting)
(eshell-syntax-highlighting-global-mode +1)

;; (require 'em-smart)
;; (setq eshell-where-to-jump 'begin)
;; (setq eshell-smart-space-goes-to-end nil)

;; (setq eshell-review-quick-commands nil)
(require 'em-term)

(setq eshell-visual-commands
      '("vi"
        "vim"
        "hx"
        "screen"
        "nvim"
        "bacon"
        ;; "gh"
        "tmux"
        "top"
        "htop"
        "less"
        "more"
        "lynx"
        "links"
        "ncftp"
        "mutt"
        "pine"
        "tin"
        "trn"
        "elm"))

(setq eshell-visual-subcommands
      '(("jj" "squash" "split")))

(defconst pcmpl-docker-commands
  '("run" "exec" "ps" "build" "pull" "images" "login" "logout"
    "search" "version" "info"
    "compose"))

(defvar docker-images-command "docker image ls | tail -n +2 | awk '{ if($1 != \"<none>\") { if($2 == \"<none>\") { print $1 } else { printf(\"%s:%s\\n\", $1, $2) } } }'")
(defun pcmpl-docker-images ()
  (let ((results (shell-command-to-string docker-images-command)))
    (string-split results "\n")))

(defun pcomplete/docker ()
  "Completion for `docker'."
  (pcomplete-here* pcmpl-docker-commands)
  (cond
   ((pcomplete-match (regexp-opt '("run")) 1)
    (pcomplete-here* (pcmpl-docker-images)))))

(require 'eshell)
(require 'esh-mode)

(defun eshell/p ()
  (interactive)
  (eshell/pwd))

(defun eshell/less (file)
  "Use `view-file' instead of less when viewing FILE."
  (interactive)
  (view-file file))

(defun eshell/f (&optional file)
  "Shorthand for `find-file', opening FILE."
  (interactive)
  (if file
      (find-file file)
    (call-interactively #'find-file)))

(defun eshell/d (&optional dir)
  "Run `dired' for directory DIR, or current dir if not given."
  (interactive)
  (if dir (dired dir) (dired ".")))

(defun eshell/q ()
  "Kill the `eshell' process and close its window."
  (interactive)
  (if (one-window-p)
	  (switch-to-buffer nil)
	(delete-window)))

(defun eshell-here ()
  "Open an `eshell' window relative to the active buffer's file."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (name (car (last (split-string parent "/" t))))
         (buffer-name (concat "*eshell: " name "*")))
    (if-let* ((buffer (get-buffer buffer-name)))
        (progn
          (display-buffer buffer)
          (switch-to-buffer buffer))
      (eshell "new")
      (rename-buffer (concat "*eshell: " name "*"))
      (insert "ls")
      (eshell-send-input))))

(setq eshell-prompt-function
      (lambda ()
        (let* ((home-path (getenv "HOME"))
               (dir (string-replace home-path "~" (eshell/pwd)))
               (branch nil)) ; (magit-get-current-branch)))
          (concat
           (propertize dir 'face `(:foreground "#61bfff"))
           (if branch
               (concat (propertize " on \uE0A0 " 'face `(:foreground "white"))
                       (propertize branch 'face `(:foreground "green")))
             "")
           " $ "))))

(setq eshell-prompt-regexp ".*$ ")

(straight-use-package 'eat)

(straight-use-package 'vterm)
(straight-use-package 'multi-vterm)
(setq vterm-shell "/opt/homebrew/bin/nu")

(provide 'my-shells)
