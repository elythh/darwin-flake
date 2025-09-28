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
  cfg = config.suites.development;
in
{
  options.suites.development = with types; {
    enable = mkBoolOpt false "enable development suite";
    dockerEnable = mkBoolOpt false "enable docker development";
    androidEnable = mkBoolOpt false "enable android development";
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        bun
        deno
        gcc
        lima
        lua54Packages.lua
        nixd
        pnpm
        prettierd
        nixfmt-rfc-style
        typescript
        zulu
      ]
      ++ (
        if cfg.dockerEnable then
          [
            docker
            docker-compose
          ]
        else
          [ ]
      );

    homebrew = {
      casks =
        if cfg.dockerEnable then
          [
            "orbstack"
          ]
        else
          [ ]
      ++ (
        if cfg.androidEnable then
          [
            "android-platform-tools"
            "android-studio"
          ]
        else
          [ ]
      );
    };
  };
}
