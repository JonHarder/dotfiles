---
name: emacs-config
description: Use when changing the literate Emacs config under emacs/.config/emacs — config.org, org-babel, :tangle, my-modules/*.el, init.el, early-init.el, reloading or restarting Emacs, or getting diagnostics on Emacs Lisp. Covers which file to edit, how to tangle without churning the whole repo, and how to apply a change to the running instance.
---

# Emacs config (literate, org-babel tangled)

## Source of truth

`emacs/.config/emacs/config.org` is the **only** file to hand-edit. It holds
243 `emacs-lisp` src blocks, each carrying its own tangle target:

```
#+begin_src emacs-lisp :tangle "my-modules/my-ai.el" :mkdirp yes
```

Targets are `my-modules/my-NAME.el` (the bulk), plus `init.el` and
`early-init.el`.

Everything under `my-modules/` that has a `:tangle`, and `init.el` /
`early-init.el`, are **generated** — never hand-edit them, the next tangle
silently overwrites the edit.

Two exceptions, both hand-maintained and **not** generated: `my-calendar.el`
and `my-evil-config.el`. Neither is tangled from `config.org` nor `require`d
from `init.el` — they are dead code. Edits to them survive a re-tangle, and
they do nothing at runtime.

Each `my-modules/my-NAME.el` ends with `(provide 'my-NAME)` (two exceptions
append a little more code after it: `my-appearance.el`, `my-prog-mode.el`).
`init.el` adds `my-modules/` to `load-path` and `require`s 58 modules in a
deliberate order starting `my-appearance` → `my-util` → `my-core`. Adding a
module means adding a block with a `:tangle`, the `(provide ...)`, **and** a
`require` in the `init.el` blocks of `config.org`.

`#+STARTUP: fold` is set in `config.org`, so the buffer opens folded.

## Workflow

1. Edit the block in `config.org`.
2. Tangle so the `.el` matches (below).
3. Verify: `jj diff --stat` shows **only** `config.org` + that one `.el`.
4. Apply to the running Emacs, or tell the user a restart is needed.

## Tangling

`org-babel-tangle` takes the universal prefix as a **raw argument**, not as
positional args — the single most common way to get this wrong:

| Call                       | Effect                                         |
| -------------------------- | ---------------------------------------------- |
| `(org-babel-tangle)`       | whole file (what `M-x org-babel-tangle` does)  |
| `(org-babel-tangle '(4))`  | only the block at point                        |
| `(org-babel-tangle '(16))` | only the **tangle file of the block at point** |

**Prefer `'(16)`.** It regenerates the complete target file from all of its
blocks while touching nothing else. Verified: point inside a `my-ai.el` block →
"Tangled 4 code blocks", and no other generated file's mtime moved.

Quote it as `'(16)`. `(org-babel-tangle nil nil t)` is **wrong** — that binds
`LANG-RE`, the language regexp, not the prefix. Point must be **inside** a src
block, so search for a string unique to your block.

### From inside Emacs (preferred)

Point inside the block, then via `emacs_eval-elisp`:

```elisp
(find-file "/Users/jharder/dotfiles/emacs/.config/emacs/config.org")
(goto-char (point-min))
(search-forward "string-unique-to-your-block")
(org-babel-tangle '(16))
```

`find-file` and `insert-file-contents` are on the MCP allowlist, so this
works over the MCP. The MCP's 30s execution cap is not a problem for tangling.

### From Bash (fallback)

```bash
cd /Users/jharder/dotfiles/emacs/.config/emacs
emacs -Q --batch --eval '(progn (require (quote org)) (require (quote ob-tangle))
  (find-file "config.org") (goto-char (point-min))
  (search-forward "string-unique-to-your-block")
  (let ((org-confirm-babel-evaluate nil)) (org-babel-tangle (quote (16)))))'
```

Full-file variant (all 243 blocks): same recipe, `(org-babel-tangle)`, no
`search-forward`. Run from the config directory — `:tangle` targets are
relative to `default-directory`.

### Org version

The live instance runs **Emacs 31.1 with bundled org 9.8.7**
(`/Applications/Emacs.app/Contents/Resources/lisp/org/ob-tangle.elc`) — *not*
straight's newer org checkout in `straight/build/org/`, which is off
`load-path`. `emacs -Q` resolves the same file, so the batch recipe matches live
behaviour. If tangle output looks wrong, compare `(org-version)` and
`(symbol-file 'org-babel-tangle)` between the live instance and the batch run
rather than guessing.

### A full re-tangle is NOT cosmetic

As of 2026-09-29, 8 of the 62 generated files are out of sync with
`config.org`, so a full tangle always produces a burst of unrelated diffs —
mostly indentation and `;; -*- lexical-binding: t; -*-` cookies, but also
**real** changes:

- `my-org.el` — currently has **unmatched brackets** and will not load; the
  re-tangle normalises the indentation and fixes it.
- `my-buffers.el` — gains a `with-eval-after-load 'ibuffer` wrapper, which
  changes load-time semantics.
- `my-appearance.el` — gains `:straight t` on `spacious-padding`, i.e. the
  package actually gets installed.
- `my-shells.el` — **loses** `(define-minor-mode my/vterm-keys-mode ...)` and
  its `vterm-mode-hook` entry, because that code exists only in the generated
  file and has no block in `config.org`; its `my/vterm-keys-keymap` is defined
  nowhere. It cannot be regenerated, only deleted.

Prefer the scoped `'(16)` tangle. If a full tangle already happened, drop the
noise with `jj restore <every file you didn't mean to touch>`, run from
`/Users/jharder/dotfiles`.

## Verifying

`jj diff --stat` is the primary check: it should list `config.org` and exactly
one `.el`.

`check-parens` is a useful second opinion on generated `.el` files:

```bash
emacs -Q --batch --eval '(with-temp-buffer
  (insert-file-contents "emacs/.config/emacs/my-modules/my-NAME.el")
  (check-parens) (message "parens OK"))'
```

`config.org` is not valid elisp (`=verbatim=`, `~subscript~`, tables) and will
*always* report "Unmatched bracket or quote" — that is not a bug. And a stale
generated file can legitimately fail while `config.org` is fine; fix it by
re-tangling, never by hand-patching the `.el`.

`emacs_get-diagnostics` is **not** empty and Elisp LSP **is** configured
(`lsp-mode` and `eglot` both tangle into `my-prog-mode.el`). The ~19
diagnostics are mostly `checkdoc` / `org-lint` / `emacs-lisp` checker noise,
some bogus. Read them, don't treat the count as a verdict.

Counting blocks in Elisp: `#+begin_src` in a regexp is a *postfix repetition
of* `^` and silently fails to match — use `(regexp-quote "#+begin_src")`. And
35 blocks are indented inside headings; `^#+begin_src` misses them, but org
tangles them anyway.

## Applying changes to the running Emacs

The `emacs_*` tools are mediated by the MCP security layer
(`mcp-server-security`), configured in the `use-package mcp-server :custom`
block in `config.org`. **Query the allowlist rather than trusting any list,
including this one** — it drifts:

```elisp
mcp-server-security-allowed-dangerous-functions
```

As of 2026-09-29 it holds `async-shell-command`, `shell-command`,
`shell-command-to-string`, `getenv`, `load`, `find-file`,
`insert-file-contents`, `with-current-buffer`.

Still blocked (from `mcp-server-security-dangerous-functions`, 41 entries):
`eval`, `write-file`, `delete-file`, `copy-file`, `rename-file`,
`append-to-file`, `start-process`, `make-process`, `call-process`,
`make-directory`, `kill-emacs`, `url-retrieve`, and more. The authoritative
list is in `emacs/.config/emacs/straight/repos/emacs-mcp-server/mcp-server-security.el`
— that tree is gitignored, so read it, never edit it.

Three guards, in the order they apply:

1. **Symbol blocklist.** `mcp-server-security--check-form-safety` walks a form
   **recursively over symbols**, so any form merely *mentioning* a blocked
   symbol is refused — inside a quoted list, as `#'foo`, or in
   `(memq 'foo ...)`. That is why you cannot edit the allowlist through the
   MCP, and why `load` looked blocked even when you were only listing symbols.
2. **Sensitive files.** Even allowlisted, `find-file`, `write-file`,
   `copy-file`, `rename-file`, `write-region`, `append-to-file` are still
   refused for `~/.ssh/`, `~/.gnupg/`, `~/.authinfo*` and friends
   (`mcp-server-security-sensitive-file-patterns`).
3. **Sensitive buffers.** `switch-to-buffer` / `set-buffer` /
   `with-current-buffer` are refused on sensitive buffer *names*.

Practical consequences:

- `use-package` `:custom`, `:init` and `:demand` values apply when the config
  loads, so **changing those needs an Emacs restart**. Say so explicitly
  instead of implying a reload sufficed. (The allowlist itself is the one
  exception: `setq` is not blocklisted, so you *can* change it at runtime over
  the MCP.)
- `load` being allowlisted means a module can be applied to a running Emacs
  with no restart: `(load "my-modules/my-NAME.el")`. That is the fast iteration
  loop for module changes.
- Treat the blocklist as a speed bump, not a sandbox. `funcall`, `apply`,
  `intern` and `load-file` are not on it, so anything reachable by those names
  is reachable. Don't claim a change is a security boundary.

## jj

- One logical unit per change: `jj new` before editing, then
  `jj describe -m "<pkg>: <lowercase summary>"`. Repo style, e.g.
  `emacs: add binding for spacious-padding-mode`.
- `jj restore <paths>` reverts paths to the parent commit — the tool for
  dropping unrelated tangle churn.
- Run `jj` from `/Users/jharder/dotfiles`, not from a package subdirectory.

## Traps

- Editing through the `~/.config/emacs/...` stow symlink works, but if Emacs
  holds the file open you get autosave/lock junk (`#config.org#`, `.#config.org`)
  in `jj status`. Never commit those; prefer repo-relative paths.
- `straight/`, `elpa/`, `custom.el`, `local-config.el*` and the caches are
  gitignored, so they never appear in `jj status`. Don't try to commit them.
- `gnus.el` and `part.el` sit beside the generated files but are untracked and
  not org output.
- opencode config is read once at startup. After editing agents, skills, or
  `opencode.emacs.jsonc`, restart opencode; for an Emacs-launched server also
  run `M-x opencode-restart`.
