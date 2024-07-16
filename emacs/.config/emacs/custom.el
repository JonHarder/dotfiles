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
     ((:application tramp :machine "Jonathans-MacBook-Pro-9.local")
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
 '(org-agenda-files
   '("/Users/jharder/Dropbox/RBC/Internship/events.org"
     "/Users/jharder/Dropbox/RBC/Internship/main.org"
     "/Users/jharder/schedule.org"
     "/Users/jharder/blog/tech_articles.org"))
 '(safe-local-variable-values
   '((org-todo-keywords "TODO" "WORKING" "REVIEW" "|" "DONE" "CANCELED"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t :background "#292D3E")))
 '(header-line ((t :box (:line-width 4 :color "#232635" :style nil))))
 '(header-line-highlight ((t :box (:color "#EEFFFF"))))
 '(line-number ((t :background "#292D3E")))
 '(mode-line ((t :box (:line-width 6 :color "#232635" :style nil))))
 '(mode-line-active ((t :box (:line-width 6 :color "#232635" :style nil))))
 '(mode-line-highlight ((t :box (:color "#EEFFFF"))))
 '(mode-line-inactive ((t :box (:line-width 6 :color "#282c3d" :style nil))))
 '(org-document-title ((t (:height 2.0 :underline t))))
 '(org-level-1 ((t (:height 1.6 :inherit outline-1))))
 '(org-level-2 ((t (:height 1.5 :inherit outline-2))))
 '(org-level-3 ((t (:height 1.2 :inherit outline-3))))
 '(org-level-4 ((t (:height 1.1 :inherit outline-4))))
 '(org-level-5 ((t (:height 1.0 :inherit outline-5))))
 '(tab-bar-tab ((t :box (:line-width 4 :color "#292D3E" :style nil))))
 '(tab-bar-tab-inactive ((t :box (:line-width 4 :color "#242837" :style nil))))
 '(window-divider ((t :background "#292D3E" :foreground "#292D3E")))
 '(window-divider-first-pixel ((t :background "#292D3E" :foreground "#292D3E")))
 '(window-divider-last-pixel ((t :background "#292D3E" :foreground "#292D3E"))))
(put 'narrow-to-region 'disabled nil)
