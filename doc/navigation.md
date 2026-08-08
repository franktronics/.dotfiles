# Navigation Guide

This setup has one navigation rule: use `cmd-*` outside the terminal and `Ctrl-h/j/k/l` inside the terminal.

| Layer | Scope | Main keys |
| --- | --- | --- |
| AeroSpace | macOS windows and workspaces | `cmd-h/j/k/l`, `cmd-1..8` |
| tmux | Terminal sessions, windows, panes | `C-a`, `Ctrl-h/j/k/l` |
| Neovim | Buffers, splits, code | `<leader>`, `Ctrl-h/j/k/l` |

## Daily Mental Model

| Need | Use |
| --- | --- |
| Move between macOS apps/windows | AeroSpace |
| Move between terminal panes | tmux |
| Move between visible editor splits | Neovim |
| Move between open files | Neovim buffers |
| Open a shell without leaving Neovim | Floating terminal |

## Core Keys

| Key | Action |
| --- | --- |
| `cmd-h/j/k/l` | Move between AeroSpace windows |
| `Ctrl-h/j/k/l` | Move between Neovim splits and tmux panes |
| `Tab` | Next Neovim buffer |
| `Shift-Tab` | Previous Neovim buffer |
| `<leader><leader>` | Search open buffers |
| `<leader>e` | Toggle file explorer |
| `I` in Neo-tree | Open a file for inspection without keeping it as a buffer |
| `<leader>tt` | Toggle floating terminal |

## Recommended Workflow

1. Open Ghostty.
2. Start or attach a tmux session.
3. Open a project in Neovim inside tmux.
4. Use AeroSpace for macOS windows.
5. Use tmux for terminal panes.
6. Use Neovim for files, buffers, splits, and code navigation.
