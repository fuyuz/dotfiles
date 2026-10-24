{ pkgs, ... }:

{
  environment.variables.DOTFILE_PROFILE = "personal";

  environment.systemPackages = with pkgs; [
    flyctl
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
