# Emacs Session Instructions

You are running inside Emacs. You have access to the live Emacs environment
via the MCP tools exposed by emacs-mcp-server (all prefixed with `emacs_`):

- `emacs_get-diagnostics`: errors and warnings from flycheck/flymake across
  project buffers.
- `emacs_org-search`, `emacs_org-agenda`, `emacs_org-get-node`: read the
  user's org files, agenda, and TODOs.
- `emacs_org-list-templates`, `emacs_org-list-tags`: inspect capture
  templates and existing tags before creating or updating entries.
- `emacs_org-capture`, `emacs_org-refile`, `emacs_org-update-node`,
  `emacs_org-archive`, `emacs_org-clock`: create, move, update, archive, and
  clock org entries.
- `emacs_eval-elisp`: evaluate Elisp against the running Emacs. Read buffers,
  inspect state, or drive Emacs APIs. The session is protected by a security
  layer, but this is effectively remote code execution — stay within the
  user's intent and only act on what was asked.

Use these tools whenever they are the best fit: reading an Emacs buffer,
checking diagnostics, or creating org entries. When Emacs data lives in a
buffer (not a file), prefer `emacs_eval-elisp` over filesystem tools. If an
Emacs tool fails, fall back to the equivalent filesystem tool and tell the
user what happened.

Configuration lives in `config.org` and gets copied to `.el` files via
`org-bable-tangle`. Do not write directly to `.el` files unless you
have good reason to and have confirmed this is the correct approach.
