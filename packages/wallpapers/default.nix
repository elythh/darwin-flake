{
  lib,
  stdenvNoCC,
  ...
}:
let
  stripExt = name: builtins.head (builtins.match "^(.+)\\.[^.]+$" name);
  images = builtins.attrNames (builtins.readDir ./assets);
  wallpapers = lib.foldl (
    acc: image:
    let
      name = stripExt image;
    in
    acc // { "${name}" = stdenvNoCC.mkDerivation { inherit name; src = ./assets + "/${image}"; dontUnpack = true; installPhase = "cp $src $out"; passthru.fileName = image; }; }
  ) { } images;
  installTarget = "$out/share/wallpapers";
in
stdenvNoCC.mkDerivation {
  name = "wallpapers";
  src = ./assets;

  installPhase = ''
    mkdir -p ${installTarget}
    find * -type f -mindepth 0 -maxdepth 0 -exec cp ./{} ${installTarget}/{} ';'
  '';

  passthru = { names = builtins.map stripExt images; } // wallpapers;
}
