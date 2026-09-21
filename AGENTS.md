# AGENTS.md — dotfiles repo notes for AI agents

Quick orientation for working in this repo without re-discovering its
structure. Kept deliberately small; extend it when you learn something new
(especially the symlinking map).

## Version control

- This repo is versioned with **jujutsu (`jj`)**, backed by a git repo. Use
  `jj status` / `jj new` / `jj describe`, not `git`, for day-to-day work.
  Run jj commands from `/Users/jharder/dotfiles`.
- Workflow convention: `jj new` to start a fresh change before making edits,
  then `jj describe -m "..."` to name it. One logical unit per change.

## Layout and stow

- Every top-level directory is a GNU stow **package**: it mirrors the target
  tree relative to `~` (mostly under `~/.config/<app>`).
- Stow creates **relative symlinks**, e.g.
  `~/.config/opencode -> ../dotfiles/opencode/.config/opencode`. Editing
  through the symlink edits the same file as the repo path.
- Currently stowed (observed symlinks under `~/.config`): **aerospace,
  emacs, jj, opencode, zsh**.
- Present in the repo but **not currently stowed**: aerc, alacritty, git,
  gpg, helix, mbsync-personal, mbsync-work, mc, nb, neru, nushell, nvim,
  skhd, vifm, yabai, zellij. Some of those exist in `~` as real files/dirs
  instead of symlinks (e.g. `~/.gitconfig`, `~/.gnupg`, `~/.config/helix`,
  `~/.config/zellij`, `~/.config/nushell`) — local copies, not links.
- Which target to expect per package: `~/.config/<app>` for XDG-style apps;
  `~` directly for `gpg/.gnupg`, `skhd/.skhdrc`, `yabai/.yabairc`,
  `mbsync-*/.mbsyncrc`, `nb/.nbrc`.

## Practical consequences for agents

- Prefer editing via repo-relative paths (`/Users/jharder/dotfiles/...`) so
  `jj` sees the change directly; `~/.config/...` paths work identically but
  can be a source of confusion with `jj`/git.
- Editing files through `~/.config/...` while Emacs has them open creates
  Emacs autosave/lock junk (`#name#`, `.#name`) that shows up in
  `jj status` — do not commit those.
- To add a new package to the live setup: run `stow <app>` from the repo
  root (or `stow --restow <app>` after edits); the dotfiles README.org
  documents this.

## opencode / Emacs specifics

- Global opencode config: `opencode/.config/opencode/` (`opencode.jsonc`,
  `agents/`, `instructions/`), loaded through the symlinked
  `~/.config/opencode`.
- Emacs-launched opencode servers use `opencode/.config/opencode/opencode.emacs.jsonc`
  via `OPENCODE_CONFIG` (registers the emacs MCP server + emacs instructions).
- Emacs config: `emacs/.config/emacs/config.org` is the source of truth;
  `.el` files (e.g. `my-modules/my-ai.el`) are **tangled** from it by
  org-babel. Do not edit `.el` files directly without a reason.
- The opencode server reads its config (including `agents/*.md`) at boot —
  after config/agent changes, restart the server (from Emacs:
  `M-x opencode-restart`, or shutdown + reopen a session), not just Emacs.