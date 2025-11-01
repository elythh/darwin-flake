list attr_name:
    nix eval --raw --expr 'builtins.concatStringsSep "\n" (builtins.attrNames (builtins.getFlake (toString ./.)).modules.{{attr_name}})' --impure
