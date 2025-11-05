(straight-use-package 'meow)
(require 'meow)

(defun meow-setup-core ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty))

(setq meow-use-clipboard t)

(meow-motion-define-key
 '("j" . meow-next)
 '("k" . meow-prev)
 '("<escape>" . ignore))

(defun gtd-find-file ()
  (interactive)
  (find-file (concat gtd-directory "/gtd.org")))

(meow-leader-define-key
 '("RET" . embark-act)
 ;; file/buffer commands
 '("ff" . find-file)
 '("fg" . gtd-find-file)
 '("fi" . gtd-find-inbox)
 '("fc" . find-config)
 '("bs" . save-buffer)
 '("bb" . consult-buffer)
 '("bi" . ibuffer)
 '("i" . consult-imenu)
 ;; programming keymap
 ;; currently just maps to `eglot-mode-map'
 ;; terminals/vc
 '("sv" . vterm)
 '("se" . eshell)
 ;; code things
 '("ed" . eldoc)
 '("ee" . eglot)
 '("ek" . eldoc-box-help-at-point)
 
 '("a" . avy-goto-char-timer)
 '("oo" . occur)
 '("l" . recenter-top-bottom)
 ;; apps (org agenda, etc)
 '("oa" . org-agenda)
 '("oc" . org-capture)
 '("j" . jj-log)
 ;; denote bindings
 '("nb" . denote-backlinks)
 '("nn" . denote-open-or-create)
 '("nj" . denote-journal-new-or-existing-entry)
 '("ng" . consult-denote-grep)
 ;; tab bindings
 '("tt" . tab-switch)
 '("tr" . tab-rename)
 '("tn" . tab-new)
 '("tj" . tab-next)
 '("tk" . tab-previous)
 '("td" . tab-close)
 ;; window management
 '("ww" . ace-window)
 '("wv" . split-window-right)
 '("ws" . split-window-below)
 ;; Use SPC (0-9) for digit arguments.
 '("1" . meow-digit-argument)
 '("2" . meow-digit-argument)
 '("3" . meow-digit-argument)
 '("4" . meow-digit-argument)
 '("5" . meow-digit-argument)
 '("6" . meow-digit-argument)
 '("7" . meow-digit-argument)
 '("8" . meow-digit-argument)
 '("9" . meow-digit-argument)
 '("0" . meow-digit-argument)
 '("/" . meow-keypad-describe-key)
 '("?" . meow-cheatsheet))

(setq meow-org-motion-keymap (make-keymap))
(meow-define-state org-motion
  "Org-mode structural motion"
  :lighter "[O]"
  :keymap meow-org-motion-keymap)

(meow-define-keys 'org-motion
  '("<escape>" . meow-normal-mode)
  '("i" . meow-insert-mode)
  '("g" . meow-normal-mode)
  '("u" . meow-undo)
  ;; Moving between headlines
  '("k" . org-previous-visible-heading)
  '("j" . org-next-visible-heading)
  ;; moving between headings at the same level
  '("p" . org-backward-heading-same-level)
  '("n" . org-forward-heading-same-level)
  ;; Moving subtrees themselves
  '("K" . org-move-subtree-up)
  '("J" . org-move-subtree-down)
  ;; subtree de/promotion
  '("L" . org-demote-subtree)
  '("H" . org-promote-subtree)
  '(">" . org-demote-subtree)
  '("<" . org-promote-subtree)
  ;; Completion-style search of headings
  '("v" . consult-org-heading)
  ;; setting subtree metadata
  '("l" . org-set-property)
  '("t" . org-todo)
  '("d" . org-deadline)
  '("s" . org-schedule)
  '("e" . org-set-effort)
  ;; Block navigation
  '("b" . org-previous-block)
  '("f" . org-next-block)
  ;; Narrowing/widening
  '("N" . org-narrow-to-subtree)
  '("W" . widen))

(meow-normal-define-key
 '("0" . meow-expand-0)
 '("9" . meow-expand-9)
 '("8" . meow-expand-8)
 '("7" . meow-expand-7)
 '("6" . meow-expand-6)
 '("5" . meow-expand-5)
 '("4" . meow-expand-4)
 '("3" . meow-expand-3)
 '("2" . meow-expand-2)
 '("1" . meow-expand-1)
 '("-" . negative-argument)
 '(";" . meow-reverse)
 '("," . meow-inner-of-thing)
 '("." . meow-bounds-of-thing)
 '("[" . meow-beginning-of-thing)
 '("]" . meow-end-of-thing)
 '(">" . meow-indent)
 '("a" . meow-append)
 '("A" . meow-open-below)
 '("b" . meow-back-word)
 '("B" . meow-back-symbol)
 '("c" . meow-change)
 '("d" . meow-delete)
 '("D" . meow-backward-delete)
 '("e" . meow-next-word)
 '("E" . meow-next-symbol)
 '("f" . meow-find)
 '("g" . meow-cancel-selection)
 '("G" . meow-grab)
 '("h" . meow-left)

 '("H" . meow-left-expand)
 '("i" . meow-insert)
 '("I" . meow-open-above)
 '("j" . meow-next)
 '("J" . meow-next-expand)
 '("k" . meow-prev)
 '("K" . meow-prev-expand)
 '("l" . meow-right)
 '("L" . meow-right-expand)
 '("m" . meow-join)
 '("n" . meow-search)
 '("o" . meow-block)
 '("O" . meow-org-motion-mode)
 '("p" . meow-yank)
 '("q" . meow-quit)
 '("Q" . meow-goto-line)
 '("r" . meow-replace)
 '("R" . meow-swap-grab)
 '("s" . meow-kill)
 '("t" . meow-till)
 '("u" . meow-undo)
 '("U" . meow-undo-in-selection)
 '("v" . meow-visit)
 '("w" . meow-mark-word)
 '("W" . meow-mark-symbol)
 '("x" . meow-line)
 '("X" . meow-goto-line)
 '("y" . meow-save)
 '("Y" . meow-sync-grab)
 '("z" . meow-pop-selection)
 '("'" . repeat)
 '("/" . consult-line)
 '(":" . execute-extended-command)
 '("<escape>" . ignore))

(add-hook 'vterm-mode-hook #'meow-insert)
(add-hook 'eshell-mode-hook #'meow-insert)
(add-hook 'org-capture-mode-hook #'meow-insert)

(meow-global-mode 1)

(keymap-global-set "C-<return>" #'embark-act)
(keymap-global-set "s-<return>" #'embark-dwim)

;; adding a specific keybinding for org mode since it already binds this binding
(with-eval-after-load 'org
  (keymap-set org-mode-map "C-<return>" #'embark-act))

(provide 'my-meow)
