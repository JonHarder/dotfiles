(defvar-keymap char-line-repeat-map
  :repeat t
  "n" #'next-line
  "p" #'previous-line
  "f" #'forward-char
  "b" #'backward-char)

(defvar-keymap word-para-repeat-map
  :repeat t
  "f" #'forward-word
  "b" #'backward-word
  "{" #'backward-paragraph
  "}" #'forward-paragraph
  "n" #'forward-sexp
  "p" #'backward-sexp
  "k" #'kill-sexp)

(provide 'my-repeat)
