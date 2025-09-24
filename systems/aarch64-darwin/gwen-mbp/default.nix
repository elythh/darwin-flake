{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ openvpn ];

  suites.common.enable = true;

  suites.social.enable = true;

  suites.development = {
    enable = true;
    dockerEnable = true;
  };

  suites.desktop.enable = true;

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = 5;

  nix.enable = false;
}
