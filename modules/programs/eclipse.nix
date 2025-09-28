{ lib, pkgs, ... }:
{
  programs.eclipse = {
    enable = true;
    enableLombok = true;
    package = pkgs.eclipses.eclipse-java;
  };
}
