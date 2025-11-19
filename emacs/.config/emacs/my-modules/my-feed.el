(straight-use-package 'elfeed)
(setq elfeed-feeds
      '(("https://protesilaos.com/codelog.xml" code emacs)
        ("http://rss.desiringgod.org/" christianity)
		("https://batsov.com/atom.xml" code)
        ("https://karthinks.com/index.xml" code emacs)
        ("https://www.thegospelcoalition.org/feed/" christianity)
        ("https://www.firstthings.com/rss/web-exclusives" christianity)
		("https://irreal.org/blog/?feed=rss2" code emacs)
		("https://twingate.com/changelog.rss.xml" kipsu)))

(provide 'my-feed)
