#!/bin/sh

set -eu

echo "start dotfiles setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(homebrew/setup.homebrew.sh rectangle/setup.rectangle.sh sheldon/setup.sheldon.sh starship/setup.starship.sh wezterm/setup.wezterm.sh)

for file in "${FILES[@]}"; do
  sh "$SCRIPT_DIR/$file"
done

echo "finish dotfiles setup"