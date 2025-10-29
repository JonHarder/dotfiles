(straight-use-package 'doom-modeline) 
(setq doom-modeline-height 35)
(setq doom-modeline-bar-width 4)
(setq doom-modeline-hud t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-enable-word-count t)

;; (straight-use-package 'doom-modeline-now-playing)
;; (require 'doom-modeline-now-playing)
;; (doom-modeline-now-playing-timer)

(doom-modeline-mode 1)

(provide 'my-modeline)
