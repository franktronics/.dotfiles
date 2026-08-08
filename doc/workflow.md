# Workflow Guide

This guide shows a typical development flow with Ghostty, tmux, AeroSpace, and Neovim.

## Start Work

Open Ghostty and create a named session:

```sh
tmux new -s project-name
```

Open your project:

```sh
cd ~/path/to/project
nvim
```

## Return To Work Later

List sessions:

```sh
tmux ls
```

Attach to a session:

```sh
tmux attach -t project-name
```

After a reboot or crash, start tmux normally:

```sh
tmux
```

The latest saved workspace is restored automatically. tmux-continuum saves
every 15 minutes. Use `C-a Ctrl-s` before a planned restart to save immediately.

## Common Flow

| Need | Key or command |
| --- | --- |
| Find a file | `<leader>sf` |
| Search text | `<leader>sg` |
| Open file explorer | `<leader>e` |
| Inspect a file temporarily | `I` in Neo-tree |
| New vertical split | `<leader>wv` |
| New horizontal split | `<leader>wh` |
| Move around splits/panes | `Ctrl-h/j/k/l` |
| Next buffer | `Tab` |
| Previous buffer | `Shift-Tab` |
| Floating shell | `<leader>tt` |
| Git UI | `<leader>gg` |
| Git blame line | `<leader>gb` |
| Preview Git hunk | `<leader>gp` |
| Save | `Ctrl-s` |
| Save tmux workspace | `C-a Ctrl-s` |

## Clean Up

Delete current Neovim buffer:

```txt
<leader>bd
```

Delete other Neovim buffers:

```txt
<leader>bo
```

Detach from tmux without killing the session:

```txt
C-a d
```

Kill a tmux session:

```sh
tmux kill-session -t project-name
```

Kill every tmux session:

```sh
tmux kill-server
```

## Update Dotfiles

Apply repository configs to system locations:

```sh
~/.config/nvim/scripts/setup.sh --update
```

Check the setup:

```sh
~/.config/nvim/scripts/setup.sh --check
```
