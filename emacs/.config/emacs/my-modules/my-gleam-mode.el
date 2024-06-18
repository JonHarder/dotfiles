(straight-use-package
 '(gleam-mode
   :type git
   :host github
   :branch "gleam-ts-mode"
   :repo "gleam-lang/gleam-mode"))
;; Note, this doesn't seem to work by itself just yet. I may need to add some additional code to help it out.
;; I'm not totally sure that it picks up the gleam-ts-mode correctly
;; running `(load-library "gleam-ts-mode")` afterwords picks up tne new #'gleam-ts-install-grammar
;; but that results in an error, saying it can't find the installed grammar
(provide 'my-gleam-mode)
