{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.neovim;
in
{
  options.programs.terminal.tools.neovim = with types; {
    enable = mkBoolOpt false "Enable neovim";
  };

  config = mkIf cfg.enable {
    nvim = {
      enable = true;
    };
  };
}
