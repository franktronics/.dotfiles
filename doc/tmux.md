# tmux Guide

tmux manages terminal sessions, windows, and panes.

Prefix key:

```txt
C-a
```

Press `C-a`, release, then press the next key.

## Sessions

A session is a persistent terminal workspace.

Do not run `tmux` or `tmux attach` from inside an attached tmux session. tmux
prints `sessions should be nested with care` in that situation. Use `C-a d` to
detach first, then run tmux from the parent shell.

| Command | Action |
| --- | --- |
| `tmux` | Start a new unnamed session |
| `tmux new -s work` | Start a session named `work` |
| `tmux attach` | Attach to the last session |
| `tmux attach -t work` | Attach to session `work` |
| `tmux ls` | List sessions |
| `tmux kill-session -t work` | Delete session `work` |
| `tmux kill-server` | Delete all sessions |

## Session Recovery

tmux-resurrect saves the session structure, windows, panes, layouts, working
directories, and supported running programs. tmux-continuum saves this state
automatically every 15 minutes and restores the latest snapshot when a new tmux
server starts.

Recovery is automatic after starting tmux following a reboot or crash:

```sh
tmux
```

Manual controls are available when needed:

| Key | Action |
| --- | --- |
| `C-a Ctrl-s` | Save a snapshot now |
| `C-a Ctrl-r` | Restore the latest snapshot |

The plugins reconstruct the workspace but cannot resume process memory, SSH
connections, or unsaved application state. A crash can lose changes made since
the latest snapshot.

## macOS File Access

macOS protects directories such as `~/Documents`, `~/Desktop`, and
`~/Downloads` with TCC privacy controls. tmux runs a long-lived server process,
so it needs its own permission even when Ghostty or Terminal already has access.

If tmux reports `Operation not permitted` in one of those directories, add
`/opt/homebrew/bin/tmux` in **System Settings > Privacy & Security > Full Disk
Access**, then stop existing tmux servers and start a new session. Recheck this
permission after a Homebrew tmux upgrade.

Inside tmux:

| Key | Action |
| --- | --- |
| `C-a d` | Detach from current session |
| `C-a s` | List and switch sessions |
| `C-a $` | Rename current session |

## Windows

A tmux window is like a tab inside a session.

| Key | Action |
| --- | --- |
| `C-a c` | Create a new window in the current path |
| `C-a n` | Next window |
| `C-a p` | Previous window |
| `C-a w` | List windows |
| `C-a ,` | Rename current window |
| `C-a &` | Kill current window |

## Status Bar

The status bar is shown at the bottom and uses a GitHub Dark color palette to match Neovim.

| Area | Shows |
| --- | --- |
| Left | Current session name |
| Middle | tmux windows, with the active window highlighted |
| Right | `PREFIX` when `C-a` is active, current time, and host name |

## Panes

A pane is a split inside a tmux window.

tmux enables extended keys for Ghostty, so modified keys like `Ctrl+Enter` are passed through to terminal applications. This keeps `Ctrl+Enter` available for multiline prompts in tools such as opencode.

| Key | Action |
| --- | --- |
| `C-a \|` | Split horizontally |
| `C-a -` | Split vertically |
| `Ctrl-h` | Move to left pane or Neovim split |
| `Ctrl-j` | Move to lower pane or Neovim split |
| `Ctrl-k` | Move to upper pane or Neovim split |
| `Ctrl-l` | Move to right pane or Neovim split |
| `C-a z` | Zoom current pane |
| `C-a x` | Kill current pane |

## Resize Panes

| Key | Action |
| --- | --- |
| `C-a H` | Resize left |
| `C-a J` | Resize down |
| `C-a K` | Resize up |
| `C-a L` | Resize right |

## Copy Mode

Copy mode lets you navigate terminal output with vi-like keys.

| Key | Action |
| --- | --- |
| `C-a [` | Enter copy mode |
| `h/j/k/l` | Move cursor |
| `/` | Search forward |
| `?` | Search backward |
| `v` | Start selection |
| `y` | Copy selection |
| `C-a ]` | Paste copied text |

## Useful Examples

Create a project session:

```sh
tmux new -s my-project
```

Detach without killing it:

```txt
C-a d
```

Return later:

```sh
tmux attach -t my-project
```

Delete it when done:

```sh
tmux kill-session -t my-project
```
