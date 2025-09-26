{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.user;
in
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/user/default.nix") ];

  config = {
    home = {
      username = mkDefault cfg.name;
      sessionVariables = {
          STRUKTUR_PATH="~/Documents/workspace/struktur/k8s";
      };
    };

    programs.home-manager = {
      enable = true;
    };
  };
}
