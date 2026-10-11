;; -*- lexical-binding: t; -*-

(delete-selection-mode 1)
(provide 'my-editor)

;; bind `kill-paragraph' to something
(global-set-key (kbd "C-s-k") #'kill-paragraph)
