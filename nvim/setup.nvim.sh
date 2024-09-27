#!/bin/sh

set -eu

echo "start neovim setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(init.lua
lua/basic_config.lua
lua/setup_plugin.lua
lua/plugins/colorscheme.lua
lua/plugins/completion.lua
lua/plugins/file_browse.lua
lua/plugins/nvim_tree.lua
lua/plugins/tig.lua
)
CONFIG_DIR="$HOME/.config/nvim"

mkdir -p CONFIG_DIR
for file in "${FILES[@]}"; do
  SOURCE="$SCRIPT_DIR/$file"
  TARGET="$CONFIG_DIR/$file"
  ln -sf "$SOURCE" "$TARGET"
done

echo "finish neovim setup"
