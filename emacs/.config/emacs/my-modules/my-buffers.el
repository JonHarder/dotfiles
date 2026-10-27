;;; package --- buffer related configuration -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(with-eval-after-load 'ibuffer
  (keymap-set ibuffer-mode-map "SPC" #'ibuffer-visit-buffer-other-window-noselect))

(global-set-key (kbd "C-c i") #'ibuffer)
;; (global-set-key (kbd "C-c b"))

(provide 'my-buffers)
;;; my-buffers.el ends here
