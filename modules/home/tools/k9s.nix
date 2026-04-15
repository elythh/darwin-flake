_: {
  flake.modules.homeManager.k9s =
    { pkgs, ... }:
    {
      programs.k9s = {
        enable = true;
        settings = {
          k9s.ui.skin = "default";
        };
        skins = {
          default = {
            k9s = {
              body.bgColor = "default";
              frame.bgColor = "default";
            };
          };
        };
      };

      home.packages = with pkgs; [
        colima
        devenv
        kubectx
        kubectl
        kubie
        istioctl
        kubecolor
        glab
        gh
        github-copilot-cli
      ];

      home.file."Library/Application Support/k9s/plugins/debug.yml".text = ''
        plugins:
          debug:
            shortCut: Shift-D
            description: Add debug container
            dangerous: true
            scopes:
              - containers
            command: bash
            background: false
            confirm: true
            args:
              - -c
              - "kubectl --kubeconfig=$KUBECONFIG debug -it --context $CONTEXT -n=$NAMESPACE $POD --target=$NAME --image=nicolaka/netshoot:v0.13 --share-processes -- bash"
      '';
    };
}
