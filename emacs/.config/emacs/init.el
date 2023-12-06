(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))

;;; temp function for hilton work

;; Http
(straight-use-package 'restclient)
(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))


;; Reading
;;; Epub support
(straight-use-package 'nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; miscellanious functions
(defun masteringemacs ()
  "Open the masteringemacs epub manual."
  (interactive)
  ;; ensure the nov package is installed
  (require 'nov)
  (find-file "~/Dropbox/Emacs/mastering-emacs-v4.epub"))

