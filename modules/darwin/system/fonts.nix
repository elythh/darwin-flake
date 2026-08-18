_: {
  flake.modules.darwin.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.caskaydia-cove
        nerd-fonts.iosevka-term
        # sketchybar-app-font
      ];

      system.defaults.NSGlobalDomain.AppleFontSmoothing = 1;
    };
}
