{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap"; # Remove unlisted packages
    };

    global = {
      brewfile = true;
    };

    taps = [ ];

    # CLI tools that are better installed via Homebrew (not in nixpkgs or issues)
    brews = [ ];

    # GUI applications (common to all configurations)
    casks = [
      # Android
      "android-platform-tools"

      # Browsers
      "arc"
      "google-chrome"
      "zen"

      # Communication
      "slack"

      # Productivity
      "1password"
      "raycast"
      "jetbrains-toolbox"

      # Utilities
      "hammerspoon"
      "logi-options+"
    ];

    # Mac App Store apps (requires `mas` CLI)
    masApps = {
      # Add Mac App Store apps here
      # "App Name" = app_id;
      # Example:
      # "Xcode" = 497799835;
    };
  };
}
