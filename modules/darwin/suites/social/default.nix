{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.suites.social;
in
{
  options.suites.social = with types; {
    enable = mkBoolOpt false "enable social suite";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [
      "ghostty"
      "discord"
      "protonvpn"
      "vesktop"
      "slack"
      "bitwarden"
      "microsoft-teams"
    ];
  };
}
