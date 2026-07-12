{
  pkgs,
  username,
  inputs,
  ...
}:

{
  imports = [
    inputs.hunk.homeManagerModules.default
    ./shell/zsh.nix
    ./shell/starship.nix
    ./programs/cli-tools.nix
    ./programs/git.nix
    ./programs/neovim.nix
    ./files
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";
  };

  manual.manpages.enable = false;

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
