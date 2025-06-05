{ pkgs, ... }:
{
  home.packages = [
    pkgs.gcc
    pkgs.glib # GNU C library
  ];
}
