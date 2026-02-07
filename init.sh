#!/usr/bin/sh
# Dotfile bootstrap script using GNU Stow

set -e

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

if ! command -v stow &> /dev/null; then
  echo 'GNU Stow is not installed on this machine.'
  exit 1
fi

DOTFILE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Core components — always stowed
for component in git gtk tmux cursor misc zsh; do
  if [ -d "$DOTFILE_DIR/$component" ]; then
    echo "Stowing $component..."
    stow -d "$DOTFILE_DIR" -t "$HOME" --adopt "$component"
  fi
done

# Ensure zplug is installed
if [ ! -d "$XDG_DATA_HOME/zsh/zplug" ]; then
  git clone https://github.com/zplug/zplug "$XDG_DATA_HOME/zsh/zplug"
fi

# Ensure tmux plugin manager is installed
if [ ! -d "$XDG_DATA_HOME/tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$XDG_DATA_HOME/tmux/plugins/tpm"
fi

# Optional components (pass as arguments, e.g. ./init.sh archlinux i3)
for component in "$@"; do
  if [ -d "$DOTFILE_DIR/$component" ]; then
    echo "Stowing $component..."
    stow -d "$DOTFILE_DIR" -t "$HOME" --adopt "$component"
  else
    echo "Warning: component '$component' not found, skipping."
  fi
done

echo "Done. Restart your shell to pick up changes."
