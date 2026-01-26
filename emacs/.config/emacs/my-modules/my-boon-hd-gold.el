;;; my-boon-hd-gold.el --- Hands Down (Gold) keymap for boon  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(require 'boon)

;; LEFT HAND

;; top row
;; j
(define-key boon-command-map "j" 'boon-quote-character)

;; g
(define-key boon-moves-map "g" '("go back" . boon-backward-search-map))
(define-key boon-moves-map "G" 'boon-qsearch-previous)

;; m
(define-key boon-moves-map "m" '("march forward" . boon-forward-search-map))
(define-key boon-moves-map "M" 'boon-qsearch-next)

;; p
(define-key boon-command-map "p" '("pilfer" . occur))
(define-key boon-command-map "P" '("play macro" . kmacro-start-macro))

;; home row
;; r
(define-key boon-command-map "r" '("aRound" . boon-enclose))

;; s
(define-key boon-command-map "s" '("substitue" . boon-substitute-region))

;; n
(define-key boon-command-map "n" '("nullify" . boon-take-region)) ; "delete"
(define-key boon-command-map "N" 'boon-treasure-region) ; "duplicate"

;; d
(define-key boon-command-map "d" '("drop" . boon-splice)) ; "pop"
(define-key boon-command-map "D" 'yank-pop)

;; b
(define-key boon-command-map "b" '("bounce" . boon-goto-map))

;; Bottom row
;; x
(define-key boon-command-map "x" 'boon-x-map)

;; f


;; l
(define-key boon-command-map "l" '("l looks like the insert point" . boon-set-insert-like-state))
(define-key boon-command-map "L" 'boon-open-next-line-and-insert)
(define-key boon-command-map (kbd "C-l") 'boon-open-line-and-insert)

;; c
(define-key boon-command-map "c" 'boon-c-god)

;; w
(define-key boon-command-map "w" 'insert-register) ; write to register
(define-key boon-command-map "W" 'boon-copy-to-register)

;; RIGHT HAND
;; top row

;; ;
(define-key boon-moves-map ";" 'xref-find-definitions)
(define-key boon-moves-map ":" 'xref-find-references)

;; .
(define-key boon-moves-map "." 'boon-beginning-of-line)

;; /
(define-key boon-moves-map "/" 'previous-line)
(define-key boon-moves-map "\\" 'backward-paragraph)

;; "
(define-key boon-moves-map "\"" 'next-line)

;; '
(define-key boon-moves-map "'" 'boon-end-of-line)

;; home row
;; ,
(define-key boon-moves-map "," 'avy-goto-word-1)
(define-key boon-moves-map "<" 'avy-goto-char)

;; a
(define-key boon-moves-map "a" '("antes" . boon-smarter-backward))

;; e
(define-key boon-moves-map "e" 'backward-char)
(define-key boon-moves-map "E" 'boon-smarter-upward)

;; i
(define-key boon-moves-map "i" 'forward-char)
(define-key boon-moves-map "I" 'boon-smarter-downward)

;; h
(define-key boon-moves-map "h" 'boon-smarter-forward)

;; bottom row
;; _


(provide 'my-boon-hd-gold)
;;; my-boon-hd-gold.el ends here
