{ ... }:
{
  flake.modules.homeManager.atuin = {
    programs.atuin = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
        style = "compact";
        show_tabs = false;
        show_help = false;
        enter_accept = true;
      };
    };
  };
}
