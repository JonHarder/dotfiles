(setq explicit-shell-file-name "/opt/homebrew/bin/nu"
      shell-file-name "/bin/zsh")

(setenv "GITHUB_KEY" "/Users/jharder/.ssh/docker_github")

(straight-use-package 'eshell-syntax-highlighting)
(eshell-syntax-highlighting-global-mode +1)
(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)
(setq eshell-visual-commands nil)

(defconst pcmpl-docker-commands
  '("run" "exec" "ps" "build" "pull" "images" "login" "logout"
    "search" "version" "info"
    "compose"))

(defvar docker-images-command "docker images | tail -n +2 | awk '{ if($1 != \"<none>\") { if($2 == \"<none>\") { print $1 } else { printf(\"%s:%s\\n\", $1, $2) } } }'")

(defun pcmpl-docker-images ()
  (let ((results (shell-command-to-string docker-images-command)))
    (string-split results "\n")))

(defun pcomplete/docker ()
  "Completion for `docker'."
  (pcomplete-here* pcmpl-docker-commands)
  (cond
   ((pcomplete-match (regexp-opt '("run")) 1)
    (pcomplete-here* (pcmpl-docker-images)))))

(defun eshell/f (&optional file)
  (interactive)
  (if file
      (find-file file)
    (call-interactively #'find-file)))

(defun eshell/d (&optional dir)
  (interactive)
  (if dir (dired dir) (dired ".")))

(setq eshell-prompt-function
      (lambda ()
	(let ((home-path (getenv "HOME")))
	  (concat
	   (string-replace home-path "~" (eshell/pwd))
	   " $ "))))

(setq eshell-prompt-regexp ".*$ ")

(straight-use-package
 '(eat :type git
       :host codeberg
       :repo "akib/emacs-eat"
       :files ("*.el" ("term" "term/*.el") "*.texi"
	       "*.ti" ("terminfo/e" "terminfo/e/*")
	       ("terminfo/65" "terminfo/65/*")
	       ("integration" "integration/*")
	       (:exclude ".dir-locals.el" "*-tests.el"))))
(eat-eshell-mode 1)

(straight-use-package 'vterm)
(straight-use-package 'multi-vterm)
(setq vterm-shell "/opt/homebrew/bin/nu")

(provide 'my-shells)
