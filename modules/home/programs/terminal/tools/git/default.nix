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
  cfg = config.programs.terminal.tools.git;
in
{
  options.programs.terminal.tools.git = with types; {
    enable = mkBoolOpt false "enable git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = "gwen@omg.lol";
      userName = "elyth";

      ignores = [
        "*.log"
        ".envrc"
        "shell.nix"
      ];

      extraConfig = {
        url = {
          "ssh://git@gitlab.dnm.radiofrance.fr:" = {
            insteadOf = "https://gitlab.dnm.radiofrance.fr/";
          };
        };
        # Sign all commits using ssh key
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_default.pub";
        core = {
          editor = "nvim";
          excludesfile = "~/.config/git/ignore";
          pager = "${getExe pkgs.diff-so-fancy}";
        };
        pager = {
          diff = "${getExe pkgs.diff-so-fancy}";
          log = "delta";
          reflog = "delta";
          show = "delta";
        };

        credential = {
          helper = "store";
        };

        push = {
          autoSetupRemote = true;
        };

        rerere.enable = true;

        color = {
          ui = true;
          pager = true;
          diff = "auto";
          branch = {
            current = "green bold";
            local = "yellow dim";
            remove = "blue";
          };

          showBranch = "auto";
          interactive = "auto";
          grep = "auto";
          status = {
            added = "green";
            changed = "yellow";
            untracked = "red dim";
            branch = "cyan";
            header = "dim white";
            nobranch = "white";
          };
        };
      };

      aliases = {
        st = "status ";
        ci = "commit ";
        br = "branch ";
        co = "checkout ";
        df = "diff ";
        dc = "diff - -cached ";
        lg = "log - p ";
        pr = "pull - -rebase ";
        p = "push ";
        ppr = "push - -set-upstream origin ";
        lol = "log - -graph - -decorate - -pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        latest = "for-each-ref --sort=-taggerdate --format='%(refname:short)' --count=1";
        undo = "git reset --soft HEAD^";
        brd = "branch -D";
      };
    };

    # sops.secrets.GITPRIVATETOKEN = {
    #   path = "${config.home.homeDirectory}/.gitcreds";
    # };

    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          nerdFontsVersion = 3;
          showDivergenceFromBaseBranch = "onlyArrow";
          filterMode = "fuzzy";
          # border = "hidden";
          spinner = {
            # The frames of the spinner animation.
            frames = [
              "⠋"
              "⠙"
              "⠩"
              "⠸"
              "⠼"
              "⠴"
              "⠦"
              "⠧"
            ];
            rate = 60;
          };
        };
        git = {
          parseEmoji = true;
          overrideGpg = true;
          paging = {
            externalDiffCommand = "${lib.getExe pkgs.difftastic} --color=always --syntax-highlight=on --display=inline";
            colorArg = "never";
            # pager = "${lib.getExe pkgs.ydiff} -p cat -s --wrap --width={{columnWidth}}";
          };
          commit = {
            signoff = true;
          };
        };
        customCommands = [
          {
            key = "E";
            command = "${lib.getExe pkgs.gitmoji-cli} commit";
            description = "commit with gitmoji";
            context = "files";
            loadingText = "opening gitmoji commit tool";
            output = "terminal";
          }
          {
            key = "C";
            command = "wanda git commit";
            description = "commit with cz";
            context = "files";
            loadingText = "opening cz commit tool";
            output = "terminal";
          }
          {
            key = "c";
            command = "git commit";
            description = "commit";
            context = "files";
            loadingText = "opening vim";
            output = "terminal";
          }
        ];
      };
    };

    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
      extensions = with pkgs; [
        gh-dash
      ];
    };

    programs.gh-dash = {
      enable = true;
      settings = { };
    };
  };
}
