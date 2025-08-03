{ pkgs, ... }:
{
  home.packages = [
    pkgs.go_1_23
    pkgs.air
    pkgs.delve
  ];
}
