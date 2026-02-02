{ lib, ... }:

{
  homebrew.casks = lib.mkForce [
    # Browsers
    "arc"
    "google-chrome"

    # Communication
    "slack"

    # Productivity
    "1password"
    "raycast"
    "jetbrains-toolbox"

    # Development
    "docker-desktop"

    # Design
    "figma"

    # Utilities
    "hammerspoon"
  ];
}
