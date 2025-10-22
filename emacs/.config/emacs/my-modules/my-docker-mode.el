(straight-use-package 'dockerfile-mode)

(straight-use-package 'docker)
(keymap-global-set "C-c d" #'docker)

(provide 'my-docker-mode)
