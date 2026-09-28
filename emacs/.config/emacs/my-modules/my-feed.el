;; -*- lexical-binding: t; -*-
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
		  ("https://www.jamescherti.com/category/emacs/feed" code emacs)
		  ("https://batsov.com/atom.xml" code)
		  ("https://blog.rust-lang.org/feed.xml" code rust)
		  ("https://aws.amazon.com/blogs/security/feed/" security)
		  ("https://karthinks.com/index.xml" code emacs)
		  ("https://steveklabnik.com/topics/rust/feed.xml" code rust)
		  ("https://www.thegospelcoalition.org/feed/" christianity)
		  ("https://irreal.org/blog/?feed=rss2" code emacs)
		  ("https://twingate.com/changelog.rss.xml" kipsu))))

(provide 'my-feed)
