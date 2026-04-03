_: {
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
        typescript
        zulu
      ];

      homebrew.casks = [
        "orbstack"
      ];
    };
}
