(with-eval-after-load 'calendar
  (keymap-set calendar-mode-map (kbd "h") #'calendar-backward-day)
  (keymap-set calendar-mode-map (kbd "l") #'calendar-forward-day)
  (keymap-set calendar-mode-map (kbd "J") #'calendar-forward-month)
  (keymap-set calendar-mode-map (kbd "K") #'calendar-backward-month)
  (keymap-set calendar-mode-map (kbd "H") #'calendar-scroll-left)
  (keymap-set calendar-mode-map (kbd "L") #'calendar-scroll-right))

(setq calendar-date-style 'iso)

(appt-activate 1)

(straight-use-package 'time-zones)

(provide 'my-time)
