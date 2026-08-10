(use-package elfeed
  :straight t
  :commands (elfeed)
  :bind (("C-c e" . elfeed)
		 :map elfeed-search-mode-map
		 ("g" . elfeed-update))
  :config
  (setq elfeed-feeds
		'(("https://protesilaos.com/codelog.xml" code emacs)
		  ("http://rss.desiringgod.org/" christianity)
		  ("https://batsov.com/atom.xml" code)
		  ("https://www.wiz.io/feed/rss.xml" security)
		  ("https://rss.beehiiv.com/feeds/xgtkummmum.xml" security)
		  ("https://aws.amazon.com/blogs/security/feed/" security)
		  ("https://karthinks.com/index.xml" code emacs)
		  ("https://www.thegospelcoalition.org/feed/" christianity)
		  ("https://www.firstthings.com/rss/web-exclusives" christianity)
		  ("https://irreal.org/blog/?feed=rss2" code emacs)
		  ("https://twingate.com/changelog.rss.xml" kipsu))))

(provide 'my-feed)
