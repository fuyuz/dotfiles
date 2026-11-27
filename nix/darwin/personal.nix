{ pkgs, ... }:

{
  environment.variables.DOTFILE_PROFILE = "personal";

  environment.systemPackages = with pkgs; [
    elan
    flyctl
    opencode
    rustup
  ];

  homebrew.casks = [
    "blender"
    "caido"
    "discord"
    "orbstack"
    "steam"
  ];
}
