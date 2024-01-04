(setq dired-kill-when-opening-new-dired-buffer t) 
(require 'dired)
(setq dired-listing-switches "-hAFl")
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

(define-key dired-mode-map (kbd "SPC") nil)
(evil-define-key '(normal motion) dired-mode-map
  (kbd "j") #'dired-next-line
  (kbd "k") #'dired-previous-line
  (kbd "h") #'dired-up-directory
  (kbd "l") #'dired-find-file
  (kbd "n") #'evil-search-next
  (kbd "N") #'evil-search-previous
  (kbd "s") #'eshell
  (kbd "g o") #'dired-insert-subdir
  (kbd "g d") #'dired-kill-subdir
  (kbd "g j") #'dired-next-subdir
  (kbd "g k") #'dired-prev-subdir
  (kbd "z a") #'dired-dotfiles-toggle
  (kbd ".") #'dired-dotfiles-toggle
  (kbd "g g") #'dired-first-file
  (kbd "G") #'dired-last-file
  (kbd "<left>") #'dired-up-directory
  (kbd "<right>") #'dired-find-file
  (kbd "<up>") #'dired-previous-line
  (kbd "<down>") #'dired-next-line)

(defun dired-first-file ()
  "Jump the point to the first dired entry that isn't . or .."
  (interactive)
  (beginning-of-buffer)
  (dired-next-line 3))

(defun dired-last-file ()
  "Jump the point to the last dired entry."
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

(straight-use-package 'dired-preview)
(setq dired-preview-delay 0.2)
(evil-define-key 'normal dired-mode-map
  (kbd "P") #'dired-preview-global-mode)

(straight-use-package 'all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(setq all-the-icons-dired-monochrome nil)

(provide 'my-dired)
