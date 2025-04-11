;; TODO: update faces to make this prettier
;; how do you work off of the color palette of the current theme?
(defface my-modeline-mode-face
  '((t :background "grey50" :foreground "white" :inherit bold))
  "Face for the major mode when displayed in the modeline.")

(defface my-modeline-buffer-face
  '((t :inherit bold))
  "Face for displaying the buffer name on the modeline.")

(defface my-modeline-evil-replace-state
  '((t :background "red"))
  "Face to indicate the current evil state is replace.")
(defface my-modeline-evil-emacs-state
  '((t :background "purple"))
  "Face to indicate the current evil state is Emacs.")

(defface my-modeline-evil-insert-state
  '((default :inherit bold)
(((class color) (min-colors 88) (background light))
 :background "#6a1aaf" :foreground "black")
(((class color) (min-colors 88) (background dark))
 :background "#e0a0ff" :foreground "black")
(t :background "magenta" :foreground "black"))
  "Face for insert mode indicator.")

(defface my-modeline-evil-normal-state
  '((default :inherit bold)
(((class color) (min-colors 88) (background light))
 :background "#005f00" :foreground "black")
(((class color) (min-colors 88) (background dark))
 :background "#73fa7f" :foreground "black")
(t :background "green" :foreground "black"))
  "Face for normal mode indicator.")

(defface my-modeline-evil-visual-state
  '((default :inherit bold)
(((class color) (min-colors 88) (background light))
 :background "#6f4000" :foreground "black")
(((class color) (min-colors 88) (background dark))
 :background "#f0c526" :foreground "black")
(t :background "yellow" :foreground "black"))
  "Face for normal mode indicator.")

(defface my-modeline-indicator-red-bg
  '((default :inherit bold)
(((class color) (min-colors 88))
 :foreground "white" :background "red"))
  "Face for modeline indicators")

(defface my-modeline-indicator-blue
  '((default :inherit bold)
(((class color) (min-colors 88) (background light))
 :foreground "#00228a")
(((class color) (min-colors 88) (background dark))
 :foreground "#880bfff")
(t :foreground "blue"))
  "Face for modeline indicators")

(defface my-modeline-indicator-green
  '((default :inherit bold)
(((class color) (min-colors 88) (background light))
 :foreground "#005f00")
(((class color) (min-colors 88) (background dark))
 :foreground "#73fa7f")
(t :foreground "green"))
  "Face for modeline indicators")

(defface my-modeline-indicator-red
  '((default :inherit bold)
(((class color) (min-colors 88) (background light))
 :foreground "#880000")
(((class color) (min-colors 88) (background dark))
 :foreground "#ff9f9f")
(t :foreground "red"))
  "Face for modeline indicators")


(defface my-modeline-indicator-magenta
  '((default :inherit bold)
(((class color) (min-colors 88) (background light))
 :foreground "#6a1aaf")
(((class color) (min-colors 88) (background dark))
 :foreground "#e0a0ff")
(t :foreground "magenta"))
  "Face for modeline indicators")

(defface my-modeline-indicator-yellow
  '((default :inherit bold)
(((class color) (min-colors 88) (background light))
 :foreground "#6f4000")
(((class color) (min-colors 88) (background dark))
 :foreground "#f0c526")
(t :foreground "yellow"))
  "Face for modeline indicators")

(defun my-modeline--major-mode-name ()
  "Return the capitalized `major-mode' name."
  (capitalize (string-replace "-mode" "" (symbol-name major-mode))))

(defun my-modeline--evil-state-name-and-face ()
  "Return a symbol associated with a face to propertize the current evil state."
  (pcase evil-state
	('insert '("INSERT" my-modeline-evil-insert-state))
	('normal '("NORMAL" my-modeline-evil-normal-state))
	('visual '("VISUAL" my-modeline-evil-visual-state))
	('replace '("REPLAC" my-modeline-indicator-red))
	('emacs '("EMACS" my-modeline-evil-emacs-state))))

(defun my-modeline--buffer-name ()
  "Return the buffer's name."
  (format "%s "(buffer-name)))

(defun my-modeline--buffer-name-face ()
  (let ((file (buffer-name)))
	(cond
	 ((and (mode-line-window-selected-p)
		   file
		   (buffer-modified-p))
	  '(italic underline mode-line-buffer-id))
	 ((and file (buffer-modified-p))
	  'italic)
	 ((mode-line-window-selected-p)
	  '(underline mode-line-buffer-id)))))

(defun my-modeline--major-mode-indicator ()
  (let ((indicator (cond
					((derived-mode-p 'text-mode) "§")
					((derived-mode-p 'prog-mode) "λ")
					((or (derived-mode-p 'comint-mode)
						 (derived-mode-p 'eshell-mode))
					 ">_"))))
	(propertize indicator 'face 'shadow)))

(defun my-modeline--git-branch ()
  "Return propertized git branch."
  (when-let ((branch (car (vc-git-branches))))
	(propertize branch 'face 'bold)))

(defvar-local my-modeline-remote
	'(:eval
	  (when (file-remote-p default-directory)
		(propertize " @ " 'face 'my-modeline-indicator-red-bg))))


(defvar-local my-modeline-git-branch
	'(:eval
	  (if-let (((mode-line-window-selected-p))
			   (branch (my-modeline--git-branch)))
		  (list
		   " "
		   (propertize (char-to-string #xE0A0) 'face 'shadow)
		   " "
		   branch
		   " "))))

(defvar-local my-modeline-evil-state
	'(:eval
	  (let* ((name-face (my-modeline--evil-state-name-and-face))
			 (name (car name-face))
			 (face (cadr name-face)))
		(propertize (upcase name) 'face face))))

(defvar-local my-modeline-major-mode
	'(:eval
	  (when (mode-line-window-selected-p)
		(list
		 (my-modeline--major-mode-indicator)
		 " "
		 (propertize (my-modeline--major-mode-name)
					 'face 'my-modeline-buffer-face)))))

(defvar-local my-modeline-buffer-name
	'(:eval
	  (list
	   " "
	   (format "%s" (propertize
					 (my-modeline--buffer-name)
					 'face (my-modeline--buffer-name-face)))
	   " ")))

(defvar-local my-modeline-date
	'(:eval
	  (when (mode-line-window-selected-p)
		(let ((date-time (format-time-string "%H:%M %b %d, %Y")))
		  (propertize date-time 'face 'underline)))))

(defvar-local my-modeline-pos-in-buffer
	'(:eval
	  (when (mode-line-window-selected-p)
		(let ((pos (line-number-at-pos)))
		  (list
		   (propertize "L" 'face 'bold)
		   (format "%s" pos)
		   " "
		   )))))

;; Any variable used in the mode line format MUST be marked as `risky-local-variable'.
(dolist (component '(my-modeline-git-branch
					 my-modeline-major-mode
					 my-modeline-buffer-name
					 my-modeline-remote
					 my-modeline-evil-state
					 my-modeline-pos-in-buffer
					 my-modeline-date))
  (put component 'risky-local-variable t))

;;; My mode line
;;; Disabled for now in favor of 'doom-modeline
;; (setq mode-line-right-align-edge 'right-margin)
;; (setq-default mode-line-format
;; 	  '("%e"
;; 		my-modeline-evil-state
;; 		my-modeline-remote
;; 		my-modeline-buffer-name
;; 		my-modeline-major-mode
;; 		" "
;; 		my-modeline-git-branch
;; 		" "
;;                 my-modeline-pos-in-buffer
;; 		my-modeline-date))

;;; The default mode line
;; (setq-default mode-line-format
;; 		     '("%e" mode-line-front-space
;; 		       (:propertize
;; 			("" mode-line-mule-info mode-line-client mode-line-modified
;; 			 mode-line-remote)
;; 			display (min-width (5.0)))
;; 		       mode-line-frame-identification mode-line-buffer-identification "   "
;; 		       mode-line-position evil-mode-line-tag (vc-mode vc-mode) "  " mode-line-modes
;; 		       mode-line-misc-info mode-line-end-spaces))

(straight-use-package 'doom-modeline) 
(provide 'my-modeline)
