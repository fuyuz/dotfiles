#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="${PROFILE:-personal}"

echo "=== dotfiles setup ==="

# Check if Nix is installed
if command -v nix &>/dev/null; then
    echo "Nix detected. Using nix-darwin + home-manager..."
    echo "Profile: ${PROFILE}"
else
    echo "Nix not detected. Using traditional symlink setup..."
    echo "To use Nix, install Determinate Nix first:"
    echo "  https://install.determinate.systems/determinate-pkg/stable/Universal"
fi
