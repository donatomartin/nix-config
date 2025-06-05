{ pkgs, lib, ... }:
let
  scriptDir = ./scripts;
  scriptFiles = builtins.attrNames (builtins.readDir scriptDir);

  toApp =
    name:
    pkgs.writeShellApplication {
      name = lib.strings.removeSuffix ".sh" name;
      runtimeInputs = [ pkgs.coreutils ];
      text = builtins.readFile (scriptDir + "/${name}");
    };

  apps = map toApp scriptFiles;

in
{
  home.packages = apps;
}
