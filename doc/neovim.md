# Neovim Guide

Neovim handles editing, buffers, splits, LSP, search, and the floating terminal.

Leader key:

```txt
Space
```

## Buffers

A buffer is an open file.

| Key | Action |
| --- | --- |
| `Tab` | Next buffer |
| `Shift-Tab` | Previous buffer |
| `<leader><leader>` | Search open buffers |
| `<leader>bd` | Delete current buffer |
| `<leader>bo` | Delete other buffers |

## Splits

A split is a visible editor window.

| Key | Action |
| --- | --- |
| `<leader>wv` | Create vertical split |
| `<leader>wh` | Create horizontal split |
| `<leader>wq` | Close current split |
| `<leader>wo` | Keep only current split |
| `<leader>w=` | Equalize split sizes |

## Move Between Splits

These keys also move through tmux panes when there is no Neovim split in that direction.

| Key | Action |
| --- | --- |
| `Ctrl-h` | Move left |
| `Ctrl-j` | Move down |
| `Ctrl-k` | Move up |
| `Ctrl-l` | Move right |

## Resize Splits

| Key | Action |
| --- | --- |
| `<leader>wH` | Resize left |
| `<leader>wJ` | Resize down |
| `<leader>wK` | Resize up |
| `<leader>wL` | Resize right |

## File Explorer

Neo-tree is configured as a floating file explorer.

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle file explorer |
| `\` | Toggle file explorer |

Inside Neo-tree:

| Key | Action |
| --- | --- |
| `Enter` | Open file |
| `s` | Open in horizontal split |
| `S` | Open in vertical split |
| `q` | Close explorer |

## Search

| Key | Action |
| --- | --- |
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep project |
| `<leader>s.` | Recent files |
| `<leader>/` | Search current buffer |
| `<leader>sd` | Search diagnostics |

## Floating Terminal

| Key | Action |
| --- | --- |
| `<leader>tt` | Toggle floating terminal |
| `Esc Esc` | Leave terminal mode |

The floating terminal uses a smart size: 80% of the window on small screens, capped on large screens.

## Save

| Key | Action |
| --- | --- |
| `Ctrl-s` | Save file |

## Copilot

Copilot suggestions appear inline, not inside the completion menu.

Authenticate once with:

```vim
:Copilot auth
```
