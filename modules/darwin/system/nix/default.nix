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
  cfg = config.system.nix;
in
{
  options.system.nix = with types; {
    enable = mkBoolOpt false "enable nix configuration";
    package = mkOpt lib.types.package pkgs.nixVersions.latest "which nix package to use.";
  };

  config = mkIf cfg.enable {
    programs.terminal.nh = {
      enable = true;
    };

    documentation = {
      doc.enable = false;
      info.enable = false;
      man.enable = true;
    };

    nixpkgs = {
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
    };

    nix = {
      extraOptions = ''
        # bail early on missing cache hits
        connect-timeout = 10
        keep-going = true
      '';

      checkConfig = true;
      distributedBuilds = true;

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
  };
}
