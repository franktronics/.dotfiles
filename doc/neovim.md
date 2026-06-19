# Neovim Guide

Neovim handles editing, buffers, splits, LSP, search, and the floating terminal.

Leader key:

```txt
Space
```

## Editing

Pairs are inserted automatically in insert mode.

| Typed | Inserted |
| --- | --- |
| `(` | `()` |
| `[` | `[]` |
| `{` | `{}` |
| `'` | `''` |
| `"` | `""` |

HTML, JSX, and TSX tags are also closed automatically when Tree-sitter can identify the syntax.

## Buffers

A buffer is an open file.

| Key | Action |
| --- | --- |
| `Tab` | Next buffer |
| `Shift-Tab` | Previous buffer |
| `<leader><leader>` | Search open buffers |
| `<leader>bd` | Delete current buffer (preserves split layout) |
| `<leader>bo` | Delete other buffers |

## Splits

A split is a visible editor window.

When creating a split, the current buffer moves to the new pane (which receives focus) and the previously active buffer appears in the original pane.

Press `s` to start a split command.

| Key | Action |
| --- | --- |
| `sv` | Create vertical split |
| `ss` | Create horizontal split |
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

The floating explorer uses a visible blue double border.

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
| `y` | Copy (yank) file or directory to clipboard |
| `x` | Cut file or directory to clipboard |
| `p` | Paste from clipboard |
| `<C-r>` | Clear clipboard |
| `q` | Close explorer |

The clipboard is shared across all Neovim instances via a state file, so a
file or directory yanked in one project can be pasted into another project.

## Search

| Key | Action |
| --- | --- |
| `f` | Jump to a visible character with Flash labels |
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep project |
| `<leader>s.` | Recent files |
| `<leader>/` | Search current buffer |
| `<leader>sd` | Search diagnostics |

Press `f`, type the target character, then press the displayed label to jump directly to that location.

## LSP Navigation

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | Show references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `gD` | Go to TypeScript source definition when vtsls is attached |
| `gO` | Show document symbols |
| `gW` | Show workspace symbols |
| `K` | Show LSP hover documentation |

LSP hover, signature help, command messages, and long messages are displayed through noice.nvim popups.

## Completion

Completion is provided by blink.cmp.

| Key | Action |
| --- | --- |
| `Ctrl-Space` | Open completion menu or documentation |
| `Ctrl-n` / `Ctrl-p` | Select next / previous item |
| `Enter` | Accept selected completion |
| `Ctrl-e` | Hide completion menu |
| `Ctrl-k` | Toggle signature help |

Completion sources include LSP, paths, snippets, and current buffer words.

## Floating Terminal

| Key | Action |
| --- | --- |
| `<leader>tt` | Toggle floating terminal |
| `Esc Esc` | Leave terminal mode |

The floating terminal uses a smart size: 80% of the window on small screens, capped on large screens.

## Git

| Key or command | Action |
| --- | --- |
| `<leader>gg` | Open LazyGit in a floating terminal |
| `:LazyGit` | Open LazyGit in a floating terminal |
| `<leader>gb` | Show a large Git blame window with commit details and diff |
| `<leader>gB` | Toggle inline Git blame for the current line |
| `<leader>gp` | Preview current Git hunk |
| `<leader>gs` | Stage current Git hunk or visual selection |
| `<leader>gr` | Reset current Git hunk or visual selection |
| `<leader>gu` | Undo staged Git hunk |
| `<leader>gd` | Diff current file against the index |
| `]h` | Next Git hunk |
| `[h` | Previous Git hunk |

LazyGit must be installed on the system for these commands to work.

## Save

| Key | Action |
| --- | --- |
| `Ctrl-s` | Save file |

Supported buffers are formatted automatically on save.

| Filetypes | Formatter |
| --- | --- |
| Lua | stylua |
| JavaScript, TypeScript, JSON, HTML, CSS, YAML | prettier |
| Shell | shfmt |
| C, C++ | clang-format |

Use `<leader>f` to format the current buffer manually.

## Copilot

Copilot suggestions appear inline, not inside the completion menu.

| Key | Action |
| --- | --- |
| `Tab` | Accept inline suggestion in insert mode |
| `Alt-]` / `Alt-[` | Next / previous inline suggestion |
| `Ctrl-]` | Dismiss inline suggestion |

Authenticate once with:

```vim
:Copilot auth
```
