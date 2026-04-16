{ pkgs, ... }:
{
  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;
  };

  home.file.".jdks/temurin-25".source = pkgs.temurin-bin-25;
}
