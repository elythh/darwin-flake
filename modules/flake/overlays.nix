{ inputs, ... }:
{
  flake.overlays = {
    modifications = _final: _prev: { };

    stable-packages = final: _prev: {
      stable = import inputs.nixpkgs-stable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    };
  };
}
