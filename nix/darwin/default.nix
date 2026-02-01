{ pkgs, username, ... }:

{
  imports = [
    ./homebrew.nix
  ];

  # Allow unfree packages (e.g., claude-code)
  nixpkgs.config.allowUnfree = true;

  # Nix configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    # Garbage collection
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };

  # System configuration
  system = {
    # Used for backwards compatibility
    stateVersion = 5;

    # Keyboard settings
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    # macOS default settings
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleInterfaceStyle = "Dark";
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      dock = {
        autohide = true;
        show-recents = false;
        tilesize = 48;
        orientation = "bottom";
      };
      finder = {
        AppleShowAllFiles = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        FXPreferredViewStyle = "Nlsv";
      };
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  # Primary user for system.defaults and services
  system.primaryUser = username;

  # User configuration
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # Allow TouchID for sudo (new API)
  security.pam.services.sudo_local.touchIdAuth = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Programs
  programs.zsh.enable = true;
}
