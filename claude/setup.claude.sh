#!/bin/bash

set -eu

echo "start claude setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS_FILE="$SCRIPT_DIR/settings.json"

if [ ! -d "$HOME/.claude" ]; then
  mkdir -p "$HOME/.claude"
  echo "created ~/.claude directory"
fi

if [ -f "$SETTINGS_FILE" ]; then
  cp "$SETTINGS_FILE" "$HOME/.claude/settings.json"
  echo "copied settings.json to ~/.claude/"
else
  echo "settings.json not found in $SCRIPT_DIR"
  exit 1
fi

# Setup CLAUDE.md
CLAUDE_MD_FILE="$SCRIPT_DIR/CLAUDE.md"
CLAUDE_MD_LINK="$HOME/.claude/CLAUDE.md"

if [ -f "$CLAUDE_MD_FILE" ]; then
  # Remove existing file or symlink
  if [ -e "$CLAUDE_MD_LINK" ] || [ -L "$CLAUDE_MD_LINK" ]; then
    rm -f "$CLAUDE_MD_LINK"
  fi
  
  # Create symlink
  ln -s "$CLAUDE_MD_FILE" "$CLAUDE_MD_LINK"
  echo "created symlink for CLAUDE.md"
else
  echo "CLAUDE.md not found in $SCRIPT_DIR"
fi

echo "finish claude setup"