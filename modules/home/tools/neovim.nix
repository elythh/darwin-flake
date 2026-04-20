{
  flake.modules.homeManager.neovim =
    { inputs, pkgs, ... }:
    {
      home.packages = [ inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    };
}
