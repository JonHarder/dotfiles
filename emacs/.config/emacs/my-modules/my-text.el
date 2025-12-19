(straight-use-package 'mixed-pitch)

(set-fill-column 80)

(defun my-text-mode-hook ()
  (auto-fill-mode 1)
  (flyspell-mode 1))

(add-hook 'text-mode-hook #'my-text-mode-hook)

(straight-use-package 'jinx)
(global-jinx-mode +1)
(keymap-global-set "M-$" #'jinx-correct)

(defun cycle-capitalization ()
  "Cycle capitalization of previous word.

Capitalization schemes are:
	- Regular capitalization: ensure only the first letter is capitalized
	- All caps: Capitalize all letters of the word
	- No caps: No Letters of the word are capitalized"
  (interactive)
  (let ((state (capitalize-state)))
	(save-excursion
	  (goto-char (beginning-of-thing 'word))
	  (cond
	   ((eq 'lower state)
	    (capitalize-word 1))
	   ((eq 'capital state)
	    (upcase-word 1))
	   ((eq 'all-caps state)
	    (downcase-word 1))))))

(defun capitalize-state ()
  "Return a symbol representing the capitalization state of the previous word.

Returns one of: 'lower, 'capital, or 'all-caps under the following senarios:

	'lower    The first character of the word is alpha and lowercase.
	'capital  The first character of the word is alpha and uppercase (but not every character in the word is uppercase.)
	'all-caps All letters of the word are alpha and uppercase."
  (interactive)
  (let* ((word (word-at-point t))
	     (upper-first-char-p (char-uppercase-p (string-to-char word)))
	     (all-upper-p (map-every-p (lambda (i val) (char-uppercase-p val)) word)))
	(cond
	 (all-upper-p 'all-caps)
	 (upper-first-char-p 'capital)
	 (t 'lower))))

(define-key global-map [remap capitalize-word] #'cycle-capitalization)

(provide 'my-text)
