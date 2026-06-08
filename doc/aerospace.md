# AeroSpace Guide

AeroSpace manages macOS windows and workspaces.

Ghostty is not floating by default. It is managed as a normal tiled window.

## Window Focus

| Key | Action |
| --- | --- |
| `cmd-h` | Focus left window |
| `cmd-j` | Focus lower window |
| `cmd-k` | Focus upper window |
| `cmd-l` | Focus right window |

## Move Windows

| Key | Action |
| --- | --- |
| `cmd-shift-h` | Move window left |
| `cmd-shift-j` | Move window down |
| `cmd-shift-k` | Move window up |
| `cmd-shift-l` | Move window right |
| `cmd-shift-f` | Toggle floating/tiling |

## Workspaces

| Key | Action |
| --- | --- |
| `cmd-1..8` | Switch workspace |
| `cmd-shift-1..8` | Move current window to workspace |
| `cmd-tab` | Switch to previous workspace |

## Layouts

| Key | Action |
| --- | --- |
| `cmd-/` | Toggle tiles layout |
| `cmd-,` | Toggle accordion layout |
| `cmd-u` | Resize smaller |
| `cmd-i` | Resize larger |

## Service Mode

| Key | Action |
| --- | --- |
| `cmd-shift-;` | Enter service mode |
| `esc` | Reload config and return to main mode |
| `r` | Flatten workspace tree |
| `f` | Toggle floating/tiling |
| `backspace` | Close all windows except current |

## Reload Config

From the shell:

```sh
aerospace reload-config
```
