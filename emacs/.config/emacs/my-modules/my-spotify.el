(straight-use-package 'smudge)

(defun load-spotify-credentials ()
  (interactive)
  (load "~/spotify.el.gpg"))

(evil-define-key 'normal smudge-track-search-mode-map
  (kbd "RET") #'smudge-track-select)
