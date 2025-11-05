{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.k9s;
in
{
  options.programs.terminal.tools.k9s = with types; {
    enable = mkBoolOpt false "enable k9s";
  };

  config = mkIf cfg.enable {
    programs.k9s = {
      enable = true;
      settings = {
        k9s = {
          ui = {
            skin = "default";
          };
        };
      };
      skins = {
        default = {
          k9s = {
            body = {
              bgColor = "default";
            };
            frame = {
              bgColor = "default";
            };
          };
        };
      };
    };
    home.packages = with pkgs; [
      sops

      colima
      kubectx
      kubectl
      kubecolor
      glab
      gh
    ];

    sops.secrets.kubernetes = {
      path = "${config.home.homeDirectory}/.kube/config";
      mode = "0700";
    };

    home.file."Libary/Application Support/k9s/plugins/debug.yml".text = ''
      plugins:
        #--- Create debug container for selected pod in current namespace
        # See https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/#ephemeral-container
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
