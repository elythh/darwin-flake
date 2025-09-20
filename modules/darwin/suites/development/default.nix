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
    neovimEnable = mkBoolOpt true "enable neovim";
    dockerEnable = mkBoolOpt false "enable docker development";
    androidEnable = mkBoolOpt false "enable android development";
    aiEnable = mkBoolOpt false "enable ai development";
  };

  config = mkIf cfg.enable {

    programs.terminal = {
      mise-en-place.enable = true;
      k9s.enable = true;
      direnv.enable = true;
      opencode.enable = if cfg.aiEnable then true else false;
    };

    nvim = mkIf cfg.neovimEnable {
      enable = true;
    };

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

        kubectl
        kubectx
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
      casks = [
        "gitbutler"
        "yaak"
      ]
      ++ (
        if cfg.dockerEnable then
          [
            "orbstack"
          ]
        else
          [ ]
      )
      ++ (
        if cfg.androidEnable then
          [
            "android-platform-tools"
            "android-studio"
          ]
        else
          [ ]
      )
      ++ (
        if cfg.aiEnable then
          [
            "msty"
          ]
        else
          [ ]
      );

      masApps = mkIf config.tools.homebrew.masEnable {
      };

      brews =
        if cfg.aiEnable then
          [
            {
              name = "ollama";
              start_service = true;
            }

          ]
        else
          [ ];
    };
  };
}
