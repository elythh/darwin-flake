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
  cfg = config.wms.aerospace;
in
{
  options.wms.aerospace = with types; {
    enable = mkBoolOpt false "enable aerospace wm";
  };

  config = mkIf cfg.enable {
    services.aerospace = {
      enable = true;
      package = pkgs.aerospace;

      settings = {
        after-login-command = [ ];
        after-startup-command = [ ];

        key-mapping.preset = "qwerty";

        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;

        accordion-padding = 0;

        default-root-container-layout = "tiles";
        default-root-container-orientation = "horizontal";

        # exec-on-workspace-change = [
        #   "/bin/zsh"
        #   "-c"
        #   "${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
        # ];
        #
        # on-focus-changed = [
        #   "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_focus_change"
        # ];

        gaps = {
          outer = {
            top = 16;
            bottom = 16;
            left = 16;
            right = 16;
          };
          inner = {
            horizontal = 16;
            vertical = 16;
          };
        };

        on-window-detected = [
          ####### Floating Windows #######
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.apple.finder";
            };
            run = [
              "layout floating"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "dev.kdrag0n.MacVirt";
            };
            run = [
              "layout floating"
            ];
          }
          ####### Specific spaces for apps #######
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "app.zen-browser.zen";
            };
            run = [
              "move-node-to-workspace 1"
            ];
          }

          {
            check-further-callbacks = false;
            "if" = {
              app-id = "net.imput.helium";
            };
            run = [
              "move-node-to-workspace 1"
            ];
          }

          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.vscodium";
            };
            run = [
              "move-node-to-workspace 2"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.mitchellh.ghostty";
            };
            run = [
              "move-node-to-workspace 2"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "md.obsidian";
            };
            run = [
              "move-node-to-workspace 2"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.spotify.client";
            };
            run = [
              "move-node-to-workspace 3"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "dev.vencord.vesktop";
            };
            run = [
              "move-node-to-workspace 3"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.spikehd.dorion";
            };
            run = [
              "move-node-to-workspace 3"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.tinyspeck.slackmacgap";
            };
            run = [
              "move-node-to-workspace 4"
            ];
          }
        ];

        mode.main.binding = {

          alt-tab = "workspace-back-and-forth";

          cmd-alt-h = "focus left";
          cmd-alt-j = "focus down";
          cmd-alt-k = "focus up";
          cmd-alt-l = "focus right";

          ctrl-cmd-shift-h = "move left";
          ctrl-cmd-shift-j = "move down";
          ctrl-cmd-shift-k = "move up";
          ctrl-cmd-shift-l = "move right";

          ctrl-cmd-shift-0 = "balance-sizes";

          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";

          alt-shift-1 = [
            "move-node-to-workspace 1"
            "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger space_windows_change"
          ];
          alt-shift-2 = [
            "move-node-to-workspace 2"
            "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger space_windows_change"
          ];
          alt-shift-3 = [
            "move-node-to-workspace 3"
            "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger space_windows_change"
          ];
          alt-shift-4 = [
            "move-node-to-workspace 4"
            "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger space_windows_change"
          ];

          ctrl-cmd-shift-space = "layout floating tiling";
          ctrl-cmd-shift-minus = "resize smart -50";
          ctrl-cmd-shift-equal = "resize smart +50";

          alt-leftSquareBracket = "join-with left";
          alt-rightSquareBracket = "join-with right";

          alt-slash = "layout horizontal vertical";

          ctrl-cmd-shift-r = "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --reload && aerospace reload-config";

          alt-enter = "exec-and-forget open -a Ghostty.app";
          # alt-e = ''exec-and-forget open -a "Zen.app"'';
          # alt-f = ''exec-and-forget open -a "Helium.app"'';
        };
      };
    };
  };
}
