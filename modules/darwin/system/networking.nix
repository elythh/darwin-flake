{ ... }:
{
  flake.modules.darwin.networking = {
    services.tailscale.enable = true;

    networking = {
      knownNetworkServices = [
        "Wi-Fi"
        "Thunderbolt Ethernet"
        "Bluetooth PAN"
      ];
      dns = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];
    };
  };
}
