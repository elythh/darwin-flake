{ ... }:
{
  flake.modules.darwin.nix-config = {
    documentation = {
      doc.enable = false;
      info.enable = false;
      man.enable = false;
    };

    nix = {
      enable = false;
      extraOptions = ''
        connect-timeout = 10
        keep-going = true
      '';
      checkConfig = true;
      distributedBuilds = true;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://cache.nixos.org?priority=10"
          "https://cache.garnix.io"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
  };
}
