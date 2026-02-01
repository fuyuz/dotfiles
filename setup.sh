#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOSTNAME=$(hostname -s)

echo "=== dotfiles setup ==="

# Check if Nix is installed
if command -v nix &> /dev/null; then
    echo "Nix detected. Using nix-darwin + home-manager..."

    # Check if darwin-rebuild is available
    if command -v darwin-rebuild &> /dev/null; then
        echo "Running darwin-rebuild switch..."
        sudo darwin-rebuild switch --flake "$SCRIPT_DIR#$HOSTNAME"
    else
        echo "darwin-rebuild not found. Running initial nix-darwin installation..."

        # First build the system
        nix build "$SCRIPT_DIR#darwinConfigurations.$HOSTNAME.system" --extra-experimental-features "nix-command flakes"

        # Install nix-darwin (requires sudo for system activation)
        sudo ./result/sw/bin/darwin-rebuild switch --flake "$SCRIPT_DIR#$HOSTNAME"
    fi

    echo "=== Nix setup complete ==="
else
    echo "Nix not detected. Using traditional symlink setup..."
    echo "To use Nix, install it first:"
    echo "  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install"
    echo ""
    echo "Running legacy setup scripts..."

    FILES=(
        homebrew/setup.homebrew.sh
        sheldon/setup.sheldon.sh
        starship/setup.starship.sh
        wezterm/setup.wezterm.sh
        nvim/setup.nvim.sh
        zsh/setup.zsh.sh
        ideavim/setup.ideavim.sh
        claude/setup.claude.sh
        gh-dash/setup.gh-dash.sh
    )

    for file in "${FILES[@]}"; do
        if [ -f "$SCRIPT_DIR/$file" ]; then
            sh "$SCRIPT_DIR/$file"
        fi
    done

    echo "=== Legacy setup complete ==="
fi
