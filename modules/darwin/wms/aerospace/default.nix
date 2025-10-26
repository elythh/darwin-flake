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

        gaps = {
          outer = {
            top = 0;
            bottom = 0;
            left = 0;
            right = 0;
          };
          inner = {
            horizontal = 0;
            vertical = 0;
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
              "move-node-to-workspace zen"
            ];
          }

          {
            check-further-callbacks = false;
            "if" = {
              app-id = "net.imput.helium";
            };
            run = [
              "move-node-to-workspace zen"
            ];
          }

          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.vscodium";
            };
            run = [
              "move-node-to-workspace terminal"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.mitchellh.ghostty";
            };
            run = [
              "move-node-to-workspace terminal"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "md.obsidian";
            };
            run = [
              "move-node-to-workspace o"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.tinyspeck.slackmacgap";
            };
            run = [
              "move-node-to-workspace slack"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.spotify.client";
            };
            run = [
              "move-node-to-workspace music"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "dev.vencord.vesktop";
            };
            run = [
              "move-node-to-workspace discord"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.hnc.Discord";
            };
            run = [
              "move-node-to-workspace discord"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.spikehd.dorion";
            };
            run = [
              "move-node-to-workspace discord"
            ];
          }
          {
            check-further-callbacks = false;
            "if" = {
              app-id = "com.tinyspeck.slackmacgap";
            };
            run = [
              "move-node-to-workspace slack"
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

          alt-z = "workspace zen";
          alt-t = "workspace terminal";
          alt-d = "workspace discord";
          alt-m = "workspace music";
          alt-o = "workspace o";
          alt-s = "workspace slack";

          alt-shift-z = [
            "move-node-to-workspace zen"
            "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger space_windows_change"
          ];
          alt-shift-t = [
            "move-node-to-workspace terminal"
            "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger space_windows_change"
          ];
          alt-shift-d = [
            "move-node-to-workspace discord"
            "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger space_windows_change"
          ];
          alt-shift-m = [
            "move-node-to-workspace music"
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

        workspace-to-monitor-force-assignment = {
          "1" = [
            "1"
            "2"
          ];
          "2" = [
            "1"
            "2"
          ];
          "3" = [
            "1"
            "2"
          ];
          "4" = [
            "2"
          ];
          "5" = [
            "1"
            "2"
          ];
        };
      };
    };
  };
}
