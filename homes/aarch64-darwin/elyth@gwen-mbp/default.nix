{ pkgs, ... }:
{
  suites.common.enable = true;
  suites.development.enable = true;

  theme.tokyonight-moon.enable = true;

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    prismlauncher
    silverbullet
  ];
}
