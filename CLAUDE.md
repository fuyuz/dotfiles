# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS dotfiles for Apple Silicon (aarch64-darwin), declaratively managed with **Nix Flakes** + **nix-darwin** + **home-manager**. Two profiles exist: `personal` and `work`, differing only in profile-specific packages (e.g., Docker/Figma for work, Parallels/Wine for personal).

## Commands

```bash
# Apply configuration changes (auto-detects hostname, defaults to personal profile)
./scripts/darwin-switch

# Apply with explicit profile
PROFILE=work ./scripts/darwin-switch

# Update all flake inputs
nix flake update

# Format Nix files
nix fmt

# Rollback to previous generation
sudo darwin-rebuild --rollback
```

## Version Control

**Use jj (jujutsu) instead of git.** Git commands are denied in Claude Code settings.

| Operation | jj command |
|---|---|
| Status | `jj status` / `jj st` |
| Diff | `jj diff` |
| Log | `jj log` |
| Commit | `jj commit -m "msg"` (no staging needed — all changes auto-tracked) |
| Amend message | `jj describe -m "msg"` |
| Squash into parent | `jj squash` |
| Create new change | `jj new` |
| Bookmarks (branches) | `jj bookmark set <name>` |
| Push | `jj git push` |
| Fetch | `jj git fetch` |
| Rebase | `jj rebase` |
| Switch to revision | `jj new <rev>` / `jj edit <rev>` |

## Architecture

The flake has two darwin configurations (`personal`, `work`) that share a common base:

```
flake.nix
├── nix/darwin/
│   ├── default.nix      # Shared macOS config (keyboard, dock, fonts, nix GC, touchID)
│   ├── homebrew.nix      # Shared Homebrew casks (Arc, 1Password, Raycast, etc.)
│   ├── personal.nix      # Personal-only packages
│   └── work.nix          # Work-only packages
│
└── nix/home/
    ├── default.nix        # Imports all home-manager modules
    ├── shell/zsh.nix      # zsh config, aliases, oh-my-zsh
    ├── shell/starship.nix # Prompt with custom jj integration
    ├── programs/cli-tools.nix  # CLI packages (50+)
    ├── programs/git.nix   # git + gh + delta
    ├── programs/neovim.nix     # Neovim with lazy.nvim (plugins managed outside Nix)
    └── files/default.nix  # Symlinks from configs/ into ~/.config/ via mkOutOfStoreSymlink
```

Config files in `configs/` are symlinked into place by `nix/home/files/default.nix` using `mkOutOfStoreSymlink`, so edits to files in `configs/` take effect immediately without rebuilding.

## Key customization points

- **Add CLI tools**: `nix/home/programs/cli-tools.nix`
- **Shell aliases/functions**: `nix/home/shell/zsh.nix`
- **Shell abbreviations**: `configs/zsh-abbr/user-abbreviations`
- **macOS system defaults**: `nix/darwin/default.nix`
- **Homebrew GUI apps**: `nix/darwin/homebrew.nix`
- **Neovim plugins/config**: `configs/nvim/init.lua` (managed by lazy.nvim, not Nix)
- **WezTerm config**: `configs/wezterm/wezterm.lua`
- **Hammerspoon shortcuts**: `configs/hammerspoon/init.lua`

## Code style

- Nix files are formatted with `nixfmt-tree` (`nix fmt`)
- Lua files (neovim, wezterm, hammerspoon) use `stylua` for formatting
- Only add comments to public interfaces; prefer self-documenting code
