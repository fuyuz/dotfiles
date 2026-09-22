{ ... }:

{
  environment.variables.DOTFILE_PROFILE = "personal";

  homebrew.casks = [
    "blender"
    "discord"
    "steam"

    # Virtualization
    "parallels"
  ];
}
