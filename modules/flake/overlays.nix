{ self, inputs, ... }:
{
  flake.overlays = {
    modifications = final: _prev: {
      helium = final.callPackage "${self}/packages/helium" { };
      sbarlua = final.callPackage "${self}/packages/sbarlua" { };
      wallpapers = final.callPackage "${self}/packages/wallpapers" { };
    };

    stable-packages = final: _prev: {
      stable = import inputs.nixpkgs-stable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    };
  };
}
