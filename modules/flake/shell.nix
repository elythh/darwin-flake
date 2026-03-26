{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          git
          just
          nh
        ];

        buildInputs = [ ];

        shellHook = ''
          ${config.pre-commit.settings.shellHook}
        '';
      };
    };
}
