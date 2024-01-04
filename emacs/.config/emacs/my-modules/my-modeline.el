;; TODO: update faces to make this prettier
;; how do you work off of the color palette of the current theme?
(defface my-modeline-mode-face
  '((t :background "grey50" :foreground "white" :inherit bold))
  "Face for the major mode when displayed in the modeline.")
(defface my-modeline-buffer-face
  '((t :background "#3355bb" :foreground "white" :inherit bold))
  "Face for displaying the buffer name on the modeline.")
(defface my-modeline-evil-insert-state
  '((t :background "green"))
  "Face to indicate the current evil state is insert.")
(defface my-modeline-evil-normal-state
  '((t :background "blue"))
  "Face to indicate the current evil state is normal.")
(defface my-modeline-evil-visual-state
  '((t :background "yellow"))
  "Face to indicate the current evil state is visual.")
(defface my-modeline-evil-replace-state
  '((t :background "red"))
  "Face to indicate the current evil state is replace.")
(defface my-modeline-evil-emacs-state
  '((t :background "purple"))
  "Face to indicate the current evil state is Emacs.")

(defun my-modeline--major-mode-name ()
  "Return the capitalized `major-mode' name."
  (capitalize (symbol-name major-mode)))

(defun my-modeline--buffer-name ()
  "Return the buffer's name."
  (format " %s "(buffer-name)))

(defun my-modeline--evil-state-face ()
  "Return a symbol associated with a face to propertize the current evil state."
  (cond
   ((eq evil-state 'insert)
    'my-modeline-evil-insert-state)
   ((eq evil-state 'normal)
    'my-modeline-evil-normal-state)
   ((eq evil-state 'visual)
    'my-modeline-evil-visual-state)
   ((eq evil-state 'replace)
    'my-modeline-evil-replace-state)
   ((eq evil-state 'emacs)
    'my-modeline-evil-emacs-state)
   (t 'default)))

(defvar-local my-modeline-evil-state
    '(:eval
      (propertize (symbol-name evil-state) 'face (my-modeline--evil-state-face))))

(defvar-local my-modeline-major-mode
    '(:eval
      (list
       (propertize "λ" 'face 'shadow)
       " "
       (propertize (my-modeline--major-mode-name)
		   'face 'my-modeline-mode-face))))

(defvar-local my-modeline-buffer
    '(:eval
      (format "%s" (propertize
		    (my-modeline--buffer-name)
		    'face 'my-modeline-buffer-face))))

;; Any variable used in the mode line format MUST be marked as `risky-local-variable'.
(dolist (component '(my-modeline-major-mode
		     my-modeline-buffer
		     my-modeline-evil-state))
  (put component 'risky-local-variable t))

;;; My mode line
; (setq-default mode-line-format
; 		   '("%e"
; 		     my-modeline-evil-state
; 		     my-modeline-buffer
; 		     " "
; 		     my-modeline-major-mode))

;;; The default mode line
(setq-default mode-line-format
       	    '("%e" mode-line-front-space
       	      (:propertize
       	       ("" mode-line-mule-info mode-line-client mode-line-modified
       		mode-line-remote)
       	       display (min-width (5.0)))
       	      mode-line-frame-identification mode-line-buffer-identification "   "
       	      mode-line-position evil-mode-line-tag (vc-mode vc-mode) "  " mode-line-modes
       	      mode-line-misc-info mode-line-end-spaces))

(provide 'my-modeline)
