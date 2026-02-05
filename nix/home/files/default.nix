{ config, ... }:

let
  dotfilesDir = "/Users/${config.home.username}/dotfiles";
in
{
  # XDG config files (symlinked to ~/.config/)
  xdg.configFile = {
    # WezTerm configuration
    "wezterm/wezterm.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/configs/wezterm/wezterm.lua";

    # gh-dash configuration
    "gh-dash/config.yml".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/configs/gh-dash/config.yml";

    # Claude Code settings
    "claude/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/configs/claude/settings.json";

    "claude/CLAUDE.md".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/configs/claude/CLAUDE.md";

    "zsh-abbr/user-abbreviations" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/configs/zsh-abbr/user-abbreviations";
      force = true;
    };
  };

  # Home directory files
  home.file = {
    # Hammerspoon configuration
    ".hammerspoon/init.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/configs/hammerspoon/init.lua";

    # IdeaVim configuration
    ".ideavimrc".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/configs/ideavim/.ideavimrc";
  };
}
