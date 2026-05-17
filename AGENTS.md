# Agent Instructions

This repository is a personal development environment configuration centered around Neovim, tmux, Ghostty, and AeroSpace.

## Project Purpose

The goal of this project is to provide a coherent macOS development setup with consistent navigation across:

| Tool | Role |
| --- | --- |
| Neovim | Editor, buffers, splits, LSP, plugins |
| tmux | Terminal sessions, windows, panes |
| Ghostty | Terminal emulator |
| AeroSpace | macOS window manager |

The setup is intentionally small, practical, and focused on predictable keyboard navigation.

## Read Documentation First

Before changing behavior, keymaps, setup scripts, navigation rules, or tool integration, read the relevant files in `doc/`.

Important documentation files:

| File | Purpose |
| --- | --- |
| `doc/navigation.md` | Global navigation model |
| `doc/tmux.md` | tmux sessions, windows, panes, copy mode |
| `doc/neovim.md` | Neovim buffers, splits, explorer, terminal, search |
| `doc/aerospace.md` | AeroSpace workspaces, windows, layouts |
| `doc/workflow.md` | Daily workflow and cleanup commands |

The documentation is part of the product. Treat it as source code.

## Documentation Rule

Update `doc/` whenever a change impacts how the system works.

This includes changes to:

| Change type | Documentation impact |
| --- | --- |
| Keymaps | Update the relevant navigation docs |
| Plugin behavior | Update Neovim docs |
| tmux bindings or session behavior | Update tmux docs |
| AeroSpace bindings or workspace behavior | Update AeroSpace docs |
| Ghostty behavior that affects workflow | Update navigation or workflow docs |
| Setup/install/update scripts | Update workflow docs and README if needed |
| Daily workflow | Update `doc/workflow.md` |

If a change does not affect user-facing behavior, documentation may not need an update.

## Design Rules

- Keep changes minimal and practical.
- Preserve the existing navigation model unless explicitly asked to change it.
- Avoid introducing keybinding conflicts between Neovim, tmux, Ghostty, and AeroSpace.
- Prefer clear configuration over clever abstractions.
- Do not add backward-compatibility code unless there is a concrete need.
- Write comments only when they explain something non-obvious.
- Keep code, comments, and documentation in English.

## Navigation Model

The current navigation model is:

| Scope | Owner | Main keys |
| --- | --- | --- |
| macOS windows and workspaces | AeroSpace | `cmd-*` |
| terminal sessions, windows, panes | tmux | `C-a`, `Ctrl-h/j/k/l` |
| editor buffers and splits | Neovim | `<leader>`, `Ctrl-h/j/k/l` |

Ghostty should stay simple. tmux owns terminal panes and sessions.

## Important Files

| Path | Purpose |
| --- | --- |
| `init.lua` | Neovim entrypoint |
| `lua/config/options.lua` | Core Neovim options |
| `lua/config/keymaps.lua` | Core Neovim keymaps |
| `lua/config/lazy.lua` | lazy.nvim bootstrap and plugin loading |
| `lua/plugins/` | Neovim plugin specs |
| `tmux/tmux.conf` | Repository tmux config |
| `aerospace/aerospace.toml` | Repository AeroSpace config |
| `ghostty/config` | Repository Ghostty config |
| `scripts/setup.sh` | Install, update, sync, and check script |
| `doc/` | User-facing documentation |

Runtime system copies may exist outside this repository, including:

| Path | Purpose |
| --- | --- |
| `~/.tmux.conf` | Active tmux config |
| `~/.aerospace.toml` | Active AeroSpace config |
| `~/Library/Application Support/com.mitchellh.ghostty/config` | Active Ghostty config |

When changing repository copies of tmux, AeroSpace, or Ghostty configs, consider whether the runtime copies must also be updated via `scripts/setup.sh --update`.

## Validation

Use the smallest relevant validation for the change.

Useful checks:

```sh
nvim --headless '+qa'
```

```sh
~/.config/nvim/scripts/setup.sh --check
```

```sh
aerospace reload-config
```

```sh
tmux -f ~/.tmux.conf start-server
```

Do not claim validation passed unless it was actually run.

## Setup Script

Use `scripts/setup.sh` for system-level config operations.

Common commands:

```sh
~/.config/nvim/scripts/setup.sh --check
```

```sh
~/.config/nvim/scripts/setup.sh --update
```

```sh
~/.config/nvim/scripts/setup.sh --sync-from-system
```

The setup script copies files by default. Do not replace this behavior with symlinks unless explicitly requested.
