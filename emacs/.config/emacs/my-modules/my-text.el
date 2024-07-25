(straight-use-package 'mixed-pitch)

(set-fill-column 80)

(defun my-text-mode-hook ()
  (auto-fill-mode 1)
  (flyspell-mode 1))

(add-hook 'text-mode-hook #'my-text-mode-hook)

(defun cycle-capitalization ()
  "Cycle capitalization of previous word.

Capitalization schemes are:
  - Regular capitalization: ensure only the first letter is capitalized
  - All caps: Capitalize all letters of the word
  - No caps: No Letters of the word are capitalized"
  (interactive)
  (save-excursion
    (let ((word-begin (beginning-of-thing 'word)))
      (goto-char word-begin)
      (capitalize-word 1))))

(evil-define-key '(insert normal) global-map
  (kbd "M-c") #'cycle-capitalization)

(provide 'my-text)
