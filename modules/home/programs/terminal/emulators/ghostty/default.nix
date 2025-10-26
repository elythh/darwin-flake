{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.emulators.ghostty;
in
{
  options.programs.terminal.emulators.ghostty = with types; {
    enable = mkBoolOpt false "enable ghostty";
  };

  config = mkIf cfg.enable {
    programs.terminal.tools.starship.enable = true;
    programs.terminal.tools.zellij.enable = true;
    programs.terminal.shells.fish.enable = true;

    programs.ghostty = {
      enable = true;
      package = null;
      enableFishIntegration = true;

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
        # Quick Terminal
        # keybind = "clear";
        quick-terminal-position = "right";
      };
    };
  };
}
