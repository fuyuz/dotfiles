{ config, pkgs, ... }:

let
  dotfilesDir = "/Users/${config.home.username}/dotfiles";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # We use lazy.nvim for plugin management, so we don't need nix-managed plugins
    # Just ensure the binary is available and link our config

    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      nil # nix LSP

      # Formatters
      stylua
      nixfmt

      # Misc dependencies for telescope, etc.
      gcc
      gnumake
    ];
  };

  # Link the init.lua using mkOutOfStoreSymlink for easy editing
  xdg.configFile."nvim/init.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/configs/nvim/init.lua";
}
