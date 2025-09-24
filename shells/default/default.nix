{
  pkgs,
  mkShell,
  ...
}:

mkShell {
  packages = with pkgs; [
    nh
  ];
}
