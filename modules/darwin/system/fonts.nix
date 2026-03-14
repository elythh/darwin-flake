{ ... }:
{
  flake.modules.darwin.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.caskaydia-cove
        sketchybar-app-font
      ];

      system.defaults.NSGlobalDomain.AppleFontSmoothing = 1;
    };
}
