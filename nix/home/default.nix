{ pkgs, username, ... }:

{
  imports = [
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

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
