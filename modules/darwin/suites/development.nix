{ inputs, ... }:
{
  flake.modules.darwin.development =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bun
        deno
        gcc
        lima
        lua54Packages.lua
        nixd
        pnpm
        prettierd
        nixfmt
        tuios
        inputs.slk.packages.${pkgs.stdenv.hostPlatform.system}.default
        typescript
        zulu

        jujutsu
        lazyjj

        lmstudio
      ];

      homebrew.casks = [
        "orbstack"
      ];
    };
}
