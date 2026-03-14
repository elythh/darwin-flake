{ ... }:
{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      package = null;
      enableZshIntegration = true;

      settings = {
        shell-integration = "fish";
        shell-integration-features = "no-cursor";
        background-opacity = 0.85;
        background-blur = 255;
        font-size = 13;
        font-family = "JetBrainsMono Nerd Font Mono";
        font-thicken = true;
        cursor-style = "block";
        mouse-hide-while-typing = true;
        window-colorspace = "display-p3";
        adjust-cell-height = "30%";
        macos-titlebar-style = "hidden";
        macos-option-as-alt = "left";
        window-inherit-working-directory = false;
        window-padding-balance = true;
        window-padding-x = 15;
        window-padding-y = 15;
        quick-terminal-position = "right";
      };
    };
  };
}
