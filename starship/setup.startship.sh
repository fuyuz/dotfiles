#!/bin/sh

set -eu

echo "start starship setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(starship.toml)
CONFIG_DIR="$HOME/.config/starship"

mkdir -p CONFIG_DIR
for file in "${FILES[@]}"; do
  SOURCE="$SCRIPT_DIR/$file"
  TARGET="$CONFIG_DIR/$file"
  ln -sf "$SOURCE" "$TARGET"
done

echo "finish starship setup"
