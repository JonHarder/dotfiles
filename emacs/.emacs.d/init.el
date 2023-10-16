(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))

;;; temp function for hilton work
(defun hilton-extract (file dest)
  (interactive "fFile: \nDDestination: ")
  (let ((unzipped (file-name-sans-extension file))
	(shortened (format "%s.csv"
			   (car (split-string file "\\.")))))
    (shell-command (format "unzip %s"
			   file))
    (rename-file unzipped (concat
			   dest "/" shortened))
    (delete-file file)))

(defun find-config ()
  "Open the user's config file."
  (interactive)
  (find-file (concat user-emacs-directory "config.org")))

;;;; Shells
(setq explicit-shell-file-name "/bin/zsh"
      shell-file-name "/bin/zsh")

;; Window Management
(setq switch-to-buffer-obey-display-actions t)

(add-to-list 'display-buffer-alist
	     '("\\*eshell\\*"
	       (display-buffer-in-side-window)
	       (side . bottom)
	       (slot . 0)
	       (window-height . 15)))

(add-to-list 'display-buffer-alist
	     '("Calendar"
	       (display-buffer-below-selected)
	       (window-height . 15)))

;; Toggles
(evil-define-key 'normal 'global
  (kbd "<leader> T t") #'modus-themes-toggle
  (kbd "<leader> T n") #'display-line-numbers-mode)

;; Eshell
(straight-use-package 'eshell-syntax-highlighting)
(eshell-syntax-highlighting-global-mode +1)
(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)


;; Http
(straight-use-package 'restclient)
(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))


;; Programming modes
;;; General settings applicable to all programming modes.
(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;; LSP setup
;; Emacs 29 packages `eglot', so no need to install it.
(add-hook 'eglot-managed-mode-hook
	  (lambda ()
	    (setq eldoc-documentation-strategy #'eldoc-documentation-compose)
	    (setq eldoc-documentation-functions
		  '(flymake-eldoc-function
		    eglot-signature-eldoc-function
		    eglot-hover-eldoc-function))))
		  

;;; Lisps

;;; Yaml
(straight-use-package 'yaml-mode)

;;; Docker
(straight-use-package 'dockerfile-mode)

;;; Terraform
(straight-use-package 'terraform-mode)

;;; Rust
(straight-use-package 'rust-mode)

;;; PHP
(straight-use-package 'php-mode)

;; Reading
;;; Epub support
(straight-use-package 'nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; Icons
(straight-use-package 'all-the-icons)
;;; If icons aren't showing up, you may need to install the font.
;;; If so, uncomment and execute the following line.
;; (all-the-icons-install-fonts t)

(straight-use-package 'all-the-icons-completion)
(all-the-icons-completion-mode)
(if (require 'marginalia nil nil)
    (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

;; miscellanious functions
(defun masteringemacs ()
  "Open the masteringemacs epub manual."
  (interactive)
  ;; ensure the nov package is installed
  (require 'nov)
  (find-file "~/Dropbox/Emacs/mastering-emacs-v4.epub"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(connection-local-criteria-alist
   '(((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile)
     ((:application tramp :machine "localhost")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp :machine "Jonathans-MBP-3.askey.com")
      tramp-connection-local-darwin-ps-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)
     ((:application eshell)
      eshell-connection-default-profile)))
 '(connection-local-profile-alist
   '((tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))
     (eshell-connection-default-profile
      (eshell-path-env-list))))
 '(custom-safe-themes
   '("de32d907a31a725e1a59f4be9ff5196d01f0532d9e857dd6b2b3927231a3d4f8" "fd2c6edaa0547670b038d650611e60786aae04c69123f63b5614c0d3c2576d7d" "0a93bd213a979d71bcca53b0bc23ef700759cc998b4c575e24bed53d163d1dc4" "d0a8b03464d54a18186b85f026a8f643991599659c629a6d10326e3c735b4639" "565c31b3d2fc6aa6292d0a2cd101ba1a059af254f46424b17f877b7814b79d74" "86d836326126dfed4b5c0be39eb16d0dba2644f579b0f7777eb07902b308378b" "23f215306af885a2a3730adb77d796f092eb41d5a8661abf071c82284f3450be" "a52e733a48d4f4dd3003410c2270140bb83f39d847d5b2a4b33eadc98a7291c6" "5306a83397853b49ec2ef1dc2ce417b4c9f5a3f4dad2deb21a19424479c98190" "c46ace6cc71a9bc412713ed6a01ba51907fa385774f83884924f9b754866c701" "4b2cd63773de734589514d19bba09d4e88fb6f61b1ac75bb8d778c68092a4465" "af74555caf764197ce1534b6da1847f99fea05332240b60947e4bcb9a1cacfcf" "a446c13f86bf810f669c345e0c17e7c3d7ce7a43c3172b6f6c5932e430df1949" "097e3658aea0debbbe554d0ac3aec42f23b8cdc8d973e344242ba811e69609b9" "949dced57bf1176a3c18382e45e5340eb95a42fa2bf7278939e7c5b963388344" "62156cd8d83a2ede9036356b85337b23f004234c13ee3368500c6b7e13e0442d" "499fa10f9cbc4f70627bb52d7d8741ffe653d3a3d502fb082b2bcb4601348c7e" "f1ec043b7c6b4b1e085e176d0548aaf73f5ccfda093c52ed2f444ccb803b9852" "e0d330b59b97872ded5ef2aeb1dd842a4f90152b76d4edff4b7f1107d2d0eb46" "6ca663019600e8e5233bf501c014aa0ec96f94da44124ca7b06d3cf32d6c5e06" default))
 '(org-agenda-files '("/Users/jharder/Dropbox/Work/index.org"))
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-doi ol-eww ol-gnus ol-info ol-irc ol-mhe ol-rmail ol-w3m ol-man)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
