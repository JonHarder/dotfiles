(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
			   '(php-mode . ("intelephense" "--stdio"))))
(straight-use-package 'php-mode)
(provide 'my-php-mode)
