(straight-use-package 'elfeed)
(setq elfeed-feeds
      '(("https://protesilaos.com/codelog.xml" code emacs)
        ("http://rss.desiringgod.org/" christianity)
        ("https://karthinks.com/index.xml" emacs)
        ("https://www.thegospelcoalition.org/feed/" christianity)
        ("https://www.firstthings.com/rss/web-exclusives" christianity)
		("https://irreal.org/blog/?feed=rss2" emacs)))

(with-eval-after-load 'evil-collection
  (evil-collection-define-key 'normal 'elfeed-search-mode-map
							  (kbd "SPC") nil))

(when nil
  (evil-define-key 'normal elfeed-search-mode-map
				   (kbd "q") #'quit-window
				   (kbd "j") #'next-line
				   (kbd "k") #'previous-line
				   (kbd "u") #'elfeed-update
				   (kbd "+") #'elfeed-search-tag-all
				   (kbd "-") #'elfeed-search-untag-all
				   (kbd "RET") #'elfeed-search-show-entry)

  (evil-define-key 'normal elfeed-show-mode-map
				   (kbd "q") #'elfeed-kill-buffer))

(provide 'my-feed)
