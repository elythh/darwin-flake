{ config, ... }:
{
  flake.modules.homeManager.common = {
    imports = with config.flake.modules.homeManager; [
      ghostty
      kitty
      fish
      atuin
      direnv
      fastfetch
      git
      starship
      tmux
      k9s
      karabiner
      neovim
      nh
      zen-browser
    ];

    programs.home-manager.enable = true;

    home = {
      sessionVariables = {
        EDITOR = "nvim";
        GITLAB_URL = "https://gitlab.dnm.radiofrance.fr/";
      };
    };
  };
}
