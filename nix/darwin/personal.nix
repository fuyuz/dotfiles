{ pkgs, ... }:

{
  environment.variables.DOTFILE_PROFILE = "personal";

  environment.systemPackages = with pkgs; [
    flyctl
    rustup
  ];

  homebrew.casks = [
    "blender"
    "discord"
    "orbstack"
    "steam"

    # Virtualization
    "parallels"
  ];
}
