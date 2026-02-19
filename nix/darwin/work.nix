{ pkgs, ... }:

{
  homebrew.brews = [
    "needle"
    "pngpaste"
  ];

  homebrew.casks = [
    # Development
    "docker-desktop"

    # Design
    "figma"
  ];

  # Create symlink for needle in /opt/homebrew/bin
  system.activationScripts.postActivation.text = ''
    if command -v needle &> /dev/null; then
      ${pkgs.coreutils}/bin/mkdir -p /opt/homebrew/bin
      ${pkgs.coreutils}/bin/ln -sf "$(command -v needle)" /opt/homebrew/bin/needle
    fi
  '';
}
