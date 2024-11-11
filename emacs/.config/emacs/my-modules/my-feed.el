(straight-use-package 'elfeed)
  (setq elfeed-feeds
	'("https://protesilaos.com/codelog.xml"
	  "http://rss.desiringgod.org/"
	  "https://www.thegospelcoalition.org/feed/"
	  "https://www.firstthings.com/rss/web-exclusives"))

  (evil-define-key 'normal elfeed-search-mode-map
(kbd "q") #'quit-window
(kbd "j") #'next-line
(kbd "k") #'previous-line
(kbd "u") #'elfeed-update
(kbd "+") #'elfeed-search-tag-all
(kbd "-") #'elfeed-search-untag-all
(kbd "RET") #'elfeed-search-show-entry)

  (evil-define-key 'normal elfeed-show-mode-map
(kbd "q") #'elfeed-kill-buffer)

  (provide 'my-feed)
