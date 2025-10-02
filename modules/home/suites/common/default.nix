{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.suites.common;
in
{
  options.suites.common = with types; {
    enable = mkBoolOpt false "enable common suite";
  };

  config = mkIf cfg.enable {
    home = {
      file = {
        ".hushlogin".text = "";
      };
    };

    programs = {
      terminal = {
        emulators = {
          ghostty.enable = true;
        };
        
        shells.fish.enable = true;

        tools = {
          atuin.enable = true;
          direnv.enable = true;
          fastfetch.enable = true;
          git.enable = true;
          starship.enable = true;
          zellij.enable = true;
          k9s.enable = true;
          neovim.enable = true;
        };
      };
    };

    services = {
      karabiner.enable = true;
    };

    system.security.sops = {
      enable = true;
      defaultSopsFile = lib.snowfall.fs.get-file "secrets/core/secrets.yaml";
    };
  };
}
