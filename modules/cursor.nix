{ config, pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    name = "Bibata-Modern-Classic";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  home.packages = [ pkgs.bibata-cursors ];

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
  };
}
