(setq dired-kill-when-opening-new-dired-buffer t) 
(require 'dired)
(setq dired-listing-switches "-hAl")
;; this pre-fills the destination prompt of copy and rename
;; commands with the directory of the other dired buffer
;; if one is open. Very handy
(setq dired-dwim-target t)

;; don't show all the file details by default
;; They're still accessible with '('
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(defun dired-dotfiles-toggle ()
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p)
        (progn
          (set (make-local-variable 'dired-dotfiles-show-p) nil)
          (message "h")
          (dired-mark-files-regexp "^\\\.")
          (dired-do-kill-lines))
      (progn (revert-buffer)
             (set (make-local-variable 'dired-dotfiles-show-p) t)))))

(keymap-set dired-mode-map "." #'dired-dotfiles-toggle)

(defun dired-mark-files-extension (extension)
  "Mark all files with the given file EXTENSION.

 EXTENSION should not contain the . prefix.
 When called interactively, derive the extension from the current file
 under the point in the dired buffer."
  (interactive
   (list (if current-prefix-arg
             (read-string "Extension: ")
           (file-name-extension (dired-get-filename))))
   'dired-mode)
  (dired-mark-files-regexp (concat "." extension "$")))

(keymap-set dired-mode-map "K" #'dired-do-kill-lines)
(keymap-set dired-mode-map "h" #'dired-up-directory)
(keymap-set dired-mode-map "l" #'dired-find-file)
(defun dired-go-home ()
  (interactive)
  (dired-jump nil "~/"))
(keymap-set dired-mode-map "~" #'dired-go-home)

(defun dired-first-file ()
  "Jump the point to the first dired entry that isn't . or .."
  (interactive)
  (beginning-of-buffer)
  (dired-next-line 1))

(defun dired-last-file ()
  "Jump the point to the last dired entry."
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

(straight-use-package 'dired-preview)
(setq dired-preview-delay 0.2)

(straight-use-package 'all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(setq all-the-icons-dired-monochrome nil)

(provide 'my-dired)
