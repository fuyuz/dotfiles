{ pkgs, ... }:

{
  environment.variables.DOTFILE_PROFILE = "personal";

  environment.systemPackages = with pkgs; [
    elan
    flyctl
    rustup
  ];

  homebrew.casks = [
    "blender"
    "burp-suite"
    "discord"
    "orbstack"
    "steam"
  ];
}
