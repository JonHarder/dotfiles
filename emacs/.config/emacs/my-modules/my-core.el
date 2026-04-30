(setq custom-file (concat user-emacs-directory "custom.el"))

;; Assume left to right text direction all the time
(setq-default bidi-display-reordering 'left-to-right
			  bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; skip fontification during input
(setq redisplay-skip-fontification-on-input t)

;; increase process output buffer for lsp
(setq read-process-output-max (* 4 1024 1024)) ; 4MB

;; auto chmod scripts on save
(add-hook 'after-save-hook
		  #'executable-make-buffer-file-executable-if-script-p)

;; use sane syntax in re-builder
(setq reb-re-syntax 'string)

;; proportional window splitting
(setq window-combination-resize t)

;; Reversible C-x 1 (delete-other-windows)
(winner-mode +1)

(defun toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode
		   (equal (selected-window) (next-window)))
	  (winner-undo)
	(delete-other-windows)))

;; auto-select help windows
(setq help-window-select t)

(setq backup-directory-alist '(("." . "~/.backups")))

(setq dictionary-server "dict.org")

(provide 'my-core)
