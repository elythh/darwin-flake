{ inputs, ... }:
{
  flake.modules.homeManager.zen-browser =
    { pkgs, ... }:
    let
      firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [ inputs.zen-browser.homeModules.default ];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;

        profiles.gwen = {
          extensions.packages = with firefox-addons; [
            bitwarden
            ublock-origin
            refined-github
          ];

          search = {
            force = true;
            default = "Kagi";
            engines = {
              "Kagi" = {
                urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
                iconUpdateURL = "https://kagi.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@k" ];
              };
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages?channel=unstable&type=packages&query={searchTerms}";
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "GitHub" = {
                urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
                iconUpdateURL = "https://github.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@gh" ];
              };
              "struktur/kube MR" = {
                urls = [
                  {
                    template = "https://gitlab.dnm.radiofrance.fr/struktur/kubernetes/-/merge_requests/?sort=updated_desc&state=opened&search={searchTerms}&first_page_size=20";
                  }
                ];
                iconUpdateURL = "https://gitlab.dnm.radiofrance.fr/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@k8s" ];
              };
              "struktur/gitops MR" = {
                urls = [
                  {
                    template = "https://gitlab.dnm.radiofrance.fr/struktur/gitops/-/merge_requests/?sort=updated_desc&state=opened&search={searchTerms}&first_page_size=20";
                  }
                ];
                iconUpdateURL = "https://gitlab.dnm.radiofrance.fr/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@git" ];
              };
            };
          };
        };
      };
    };
}
