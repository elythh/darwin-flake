{
  flake.modules.homeManager.neovim =
    { inputs, ... }:
    {
      nvim.enable = true;
    };
}
