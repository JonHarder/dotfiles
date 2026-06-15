(defvar text-navigation-repeat-map
  (let ((map (make-sparse-keymap)))
	(define-key map "n" #'next-line)
	(define-key map "p" #'previous-line)
	(define-key map "f" #'forward-char)
	(define-key map "b" #'backward-char)
	map))

(put 'next-line 'repeat-map 'text-navigation-repeat-map)
(put 'previous-line 'repeat-map 'text-navigation-repeat-map)
(put 'forward-char 'repeat-map 'text-navigation-repeat-map)
(put 'backward-char 'repeat-map 'text-navigation-repeat-map)

(provide 'my-repeat)
