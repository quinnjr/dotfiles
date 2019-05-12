#!/usr/bin/sh

if ! type "stow" &> /dev/null; then
  echo 'GNU Stow is not installed on this machine.'
  exit 1
fi

stow -t "$HOME" zsh
stow -t "$HOME" xwindow
stow -t "$HOME" i3
