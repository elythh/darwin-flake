{
  config,
  lib,
  namespace,
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
  };

  config = mkIf cfg.enable {
    programs = {
      terminal = {
        tools = {
          mise-en-place.enable = true;
        };
      };
    };
  };
}
