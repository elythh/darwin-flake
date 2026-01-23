{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.shells.zsh;
in
{
  options.programs.terminal.shells.zsh = with types; {
    enable = mkBoolOpt false "enable zsh";
  };

  config = mkIf cfg.enable {
    programs.terminal.tools.git = {
      enable = true;
    };
    programs.terminal.tools.nh.enable = true;

    home.packages = with pkgs; [
      statix
      fzf
    ];

    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";
      shellAliases = with pkgs; {
        v = "nvim";
        ":q" = "exit";
        cat = "${bat}/bin/bat";
        du = "${dust}/bin/dust";
        g = "${git}/bin/git";
        la = "ll -a";
        ll = "ls -l --time-style long-iso --icons";
        ls = "${eza}/bin/eza";

        tg = "TERRAGRUNT_PROVIDER_CACHE=1 TERRAGRUNT_PROVIDER_CACHE_DIR=~/.terraform.d/plugin-cache/ TERRAGRUNT_TFPATH=terraform terragrunt";
        tginfo = "TERRAGRUNT_PROVIDER_CACHE=1 TERRAGRUNT_PROVIDER_CACHE_DIR=~/.terraform.d/plugin-cache/ TERRAGRUNT_TFPATH=terraform terragrunt --terragrunt-debug";
        tgdebug = "TERRAGRUNT_PROVIDER_CACHE=1 TERRAGRUNT_PROVIDER_CACHE_DIR=~/.terraform.d/plugin-cache/ TERRAGRUNT_TFPATH=terraform TF_LOG=DEBUG terragrunt --terragrunt-debug";
        w = "wanda";

        k9s = "k9s --readonly";
        kns = "kubens";
        kcx = "kubectx";
        kubectl = "kubecolor";
        k = "kubectl";
        kg = "kubectl get";
        kd = "kubectl describe";
        kgp = "kubectl get pods";
        kgns = "kubectl get namespaces";
        kgi = "kubectl get ingress";
        kgall = "kubectl get ingress,service,deployment,pod,statefulset";
        kuc = "kubectl config use-context";
        kgc = "kubectl config get-contexts";
        kex = "kubectl exec -it";
        kl = "kubectl logs";
        kwatch = "kubectl get pods -w --all-namespaces";

        vim = "nvim";
        ctrl-l = "clear";
        C-l = "ctrl-l";
        control-l = "clear";
        clean = "clear";
      };
      initContent = ''
        ZSH_DISABLE_COMPFIX=true
        export EDITOR=nvim
        if [ -n "$TTY" ]; then
          export GPG_TTY=$(tty)
        else
          export GPG_TTY="$TTY"
        fi

        export BUN_INSTALL=$HOME/.bun
        export PATH="$HOME/go/bin:$BUN_INSTALL/bin:$PATH"

        # SSH_AUTH_SOCK set to GPG to enable using gpgagent as the ssh agent.
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        gpgconf --launch gpg-agent

        bindkey -e

        # disable sort when completing `git checkout`
        zstyle ':completion:*:git-checkout:*' sort false

        # set descriptions format to enable group support
        # NOTE: don't use escape sequences here, fzf-tab will ignore them
        zstyle ':completion:*:descriptions' format '[%d]'

        # set list-colors to enable filename colorizing
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

        # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
        zstyle ':completion:*' menu no

        # preview directory's content with eza when completing cd
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
        zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'

        # switch group using `<` and `>`
        zstyle ':fzf-tab:*' switch-group '<' '>'

        # Keybindings
        bindkey -e
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
        bindkey '^[w' kill-region

        zle_highlight+=(paste:none)

        setopt appendhistory
        setopt sharehistory
        setopt hist_ignore_space
        setopt hist_ignore_all_dups
        setopt hist_save_no_dups
        setopt hist_ignore_dups
        setopt hist_find_no_dups

        autoload -Uz edit-command-line
        zle -N edit-command-line
        bindkey '^x^e' edit-command-line

        alias -g NE='2>/dev/null'
        alias -g ND='>/dev/null'
        alias -g NUL='>/dev/null 2>1'
        alias -g JQ='| jq'
        alias -g C='| wl-copy'
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "docker"
          "golang"
          "kubectl"
          "kubectx"
          "rust"
          "command-not-found"
          "pass"
          "helm"
        ];
      };
      plugins = [
        #{
        # will source zsh-autosuggestions.plugin.zsh
        #name = "zsh-autosuggestions";
        #src = pkgs.zsh-autosuggestions;
        #file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        #}
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
          file = "share/zsh-completions/zsh-completions.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
    };
  };
}
