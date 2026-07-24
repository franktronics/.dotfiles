#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMUX_SOURCE="$REPO_DIR/tmux/tmux.conf"
AEROSPACE_SOURCE="$REPO_DIR/aerospace/aerospace.toml"
GHOSTTY_SOURCE="$REPO_DIR/ghostty/config"

TMUX_TARGET="$HOME/.tmux.conf"
AEROSPACE_TARGET="$HOME/.aerospace.toml"
GHOSTTY_TARGET="$HOME/Library/Application Support/com.mitchellh.ghostty/config"

usage() {
  printf '%s\n' "Usage: $0 --install | --update | --sync-from-system | --check"
}

log() {
  printf '%s\n' "$1"
}

backup_file() {
  local file="$1"
  if [[ -e "$file" ]]; then
    local backup="$file.backup.$(date +%Y%m%d%H%M%S)"
    cp "$file" "$backup"
    log "Backed up: $file -> $backup"
  else
    log "No backup needed: $file does not exist"
  fi
}

copy_file() {
  local source="$1"
  local target="$2"
  mkdir -p "$(dirname "$target")"
  cp "$source" "$target"
  log "Copied: $source -> $target"
}

install_tmux_plugin() {
  local name="$1"
  local repository="$2"
  local plugin_dir="$HOME/.tmux/plugins/$name"

  if [[ ! -d "$plugin_dir" ]]; then
    mkdir -p "$(dirname "$plugin_dir")"
    git clone "$repository" "$plugin_dir"
    log "Installed tmux plugin: $name"
  else
    log "Tmux plugin already installed: $name"
  fi
}

install_tmux_plugins() {
  install_tmux_plugin "vim-tmux-navigator" "https://github.com/christoomey/vim-tmux-navigator"
  install_tmux_plugin "tmux-resurrect" "https://github.com/tmux-plugins/tmux-resurrect"
  install_tmux_plugin "tmux-continuum" "https://github.com/tmux-plugins/tmux-continuum"
}

reload_services() {
  if command -v aerospace >/dev/null 2>&1; then
    aerospace reload-config || true
    log "Reloaded AeroSpace config"
  else
    log "Skipped AeroSpace reload: aerospace command not found"
  fi

  if command -v tmux >/dev/null 2>&1 && tmux info >/dev/null 2>&1; then
    tmux source-file "$TMUX_TARGET" || true
    log "Reloaded tmux config"
  else
    log "Skipped tmux reload: no running tmux server"
  fi
}

install_configs() {
  log "Installing configs from: $REPO_DIR"
  backup_file "$TMUX_TARGET"
  backup_file "$AEROSPACE_TARGET"
  backup_file "$GHOSTTY_TARGET"

  copy_file "$TMUX_SOURCE" "$TMUX_TARGET"
  copy_file "$AEROSPACE_SOURCE" "$AEROSPACE_TARGET"
  copy_file "$GHOSTTY_SOURCE" "$GHOSTTY_TARGET"
  install_tmux_plugins
  reload_services
  log "Install completed."
}

update_configs() {
  log "Updating runtime configs from: $REPO_DIR"
  copy_file "$TMUX_SOURCE" "$TMUX_TARGET"
  copy_file "$AEROSPACE_SOURCE" "$AEROSPACE_TARGET"
  copy_file "$GHOSTTY_SOURCE" "$GHOSTTY_TARGET"
  install_tmux_plugins
  reload_services
  log "Update completed."
}

sync_from_system() {
  log "Syncing runtime configs back into repository"
  copy_file "$TMUX_TARGET" "$TMUX_SOURCE"
  copy_file "$AEROSPACE_TARGET" "$AEROSPACE_SOURCE"
  copy_file "$GHOSTTY_TARGET" "$GHOSTTY_SOURCE"
  log "Sync completed."
}

check_setup() {
  log "Checking required commands"
  command -v nvim >/dev/null 2>&1 || { log 'Missing nvim'; exit 1; }
  log "Found nvim: $(command -v nvim)"

  command -v tmux >/dev/null 2>&1 || { log 'Missing tmux'; exit 1; }
  log "Found tmux: $(command -v tmux)"

  command -v git >/dev/null 2>&1 || { log 'Missing git'; exit 1; }
  log "Found git: $(command -v git)"

  nvim --headless '+qa'
  log "Validated Neovim config"

  tmux -f "$TMUX_SOURCE" start-server
  log "Validated tmux config: $TMUX_SOURCE"

  if command -v aerospace >/dev/null 2>&1; then
    aerospace reload-config || true
    log "Reloaded AeroSpace config"
  else
    log "Skipped AeroSpace reload: aerospace command not found"
  fi

  log 'Setup check completed.'
}

case "${1:-}" in
  --install)
    install_configs
    ;;
  --update)
    update_configs
    ;;
  --sync-from-system)
    sync_from_system
    ;;
  --check)
    check_setup
    ;;
  *)
    usage
    exit 1
    ;;
esac
