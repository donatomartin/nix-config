{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
    };
  };
}
