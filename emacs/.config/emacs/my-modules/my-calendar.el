(setq calendar-date-style 'iso)

(evil-define-key 'normal calendar-mode-map
  (kbd "l") 'calendar-forward-day
  (kbd "h") 'calendar-backward-day
  (kbd "w") #'calendar-forward-week
  (kbd "b") #'calendar-backward-week
  (kbd "k") 'calendar-backward-week
  (kbd "j") 'calendar-forward-week
  (kbd "q") 'calendar-exit
  (kbd "0") 'calendar-beginning-of-week
  (kbd "$") 'calendar-end-of-week
  (kbd ".") 'calendar-goto-today
  (kbd "d d") 'diary-view-entries
  (kbd "d i") 'diary-insert-entry)

(appt-activate 1)

(evil-define-key 'normal diary-fancy-display-mode-map
  (kbd "q") 'quit-window)

(provide 'my-calendar)
