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
    ];

    programs.home-manager.enable = true;

    home = {
      file.".hushlogin".text = "";
      sessionVariables = {
        EDITOR = "nvim";
      };
    };
  };
}
