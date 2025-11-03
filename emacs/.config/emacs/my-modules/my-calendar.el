(with-eval-after-load 'calendar
  (keymap-set calendar-mode-map (kbd "h") #'calendar-backward-day)
  (keymap-set calendar-mode-map (kbd "l") #'calendar-forward-day))

(setq calendar-date-style 'iso)

(appt-activate 1)

(provide 'my-calendar)
