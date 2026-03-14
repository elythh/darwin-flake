{ ... }:
{
  flake.modules.darwin.social = {
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
