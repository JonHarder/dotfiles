(keymap-set ibuffer-mode-map "SPC" #'ibuffer-visit-buffer-other-window-noselect)

(global-set-key (kbd "C-c i") #'ibuffer)

 (provide 'my-buffers)
