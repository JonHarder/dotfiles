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

(defun my-modeline--evil-state-face ()
  "Return a symbol associated with a face to propertize the current evil state."
  (pcase evil-state
    ('insert 'my-modeline-indicator-magenta)
    ('normal 'my-modeline-indicator-green)
    ('visual 'my-modeline-indicator-yellow)
    ('replace 'my-modeline-indicator-red)
    ('emacs 'my-modeline-evil-emacs-state)))

(defun my-modeline--buffer-name ()
  "Return the buffer's name."
  (format " %s "(buffer-name)))

(defun my-modeline--buffer-name-face ()
  (let ((file (buffer-name)))
    (cond
     ((and (mode-line-window-selected-p)
	   file
	   (buffer-modified-p))
      '(italic mode-line-buffer-id))
     ((and file (buffer-modified-p))
      'italic)
     ((mode-line-window-selected-p)
      'mode-line-buffer-id))))

(defun my-modeline--major-mode-indicator ()
  (let ((indicator (cond
		    ((derived-mode-p 'text-mode) "§")
		    ((derived-mode-p 'prog-mode) "λ")
		    ((or (derived-mode-p 'comint-mode)
			 (derived-mode-p 'eshell-mode))
		     ">_"))))
    (propertize indicator 'face 'shadow)))

(defvar-local my-modeline-evil-state
    '(:eval
      (propertize (upcase (symbol-name evil-state)) 'face (my-modeline--evil-state-face))))

(defvar-local my-modeline-major-mode
    '(:eval
      (list
       (my-modeline--major-mode-indicator)
       " "
       (propertize (my-modeline--major-mode-name)
		   'face 'normal))))

(defvar-local my-modeline-buffer-name
    '(:eval
      (format "%s" (propertize
		    (my-modeline--buffer-name)
		    'face (my-modeline--buffer-name-face)))))

;; Any variable used in the mode line format MUST be marked as `risky-local-variable'.
(dolist (component '(my-modeline-major-mode
		     my-modeline-buffer-name
		     my-modeline-evil-state))
  (put component 'risky-local-variable t))

;;; My mode line
(setq mode-line-right-align-edge 'right-margin)
(setq-default mode-line-format
	      '("%e"
		my-modeline-evil-state
		my-modeline-buffer-name
		" "
		my-modeline-major-mode
		"  "
		global-mode-string))
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

(provide 'my-modeline)
