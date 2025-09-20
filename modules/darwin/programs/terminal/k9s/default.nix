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
  cfg = config.programs.terminal.k9s;
in
{
  options.programs.terminal.k9s = with types; {
    enable = mkBoolOpt false "enable k9s";
  };

  config = mkIf cfg.enable {
    home.programs.k9s = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      sops
    ];

    sops.secrets.kubernetes = {
      path = "${config.users.users.${config.user.name}.home}/.kube/config";
      mode = "0700";
      owner = config.users.users.elyth.name;
    };

    home.file.".config/k9s/plugins/debug.yml".text = ''
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
