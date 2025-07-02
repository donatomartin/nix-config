{ pkgs, ... }:
{

  home.packages = [
    pkgs.libnotify
  ];

  services.mako = {
    enable = true;
    package = pkgs.mako;
    settings = {
      actions = true;
      anchor = "top-right";
      background-color = "#1A1A2E";
      border-color = "#BF9FEE";
      border-radius = 0;
      default-timeout = 0;
      font = "monospace 10";
      height = 100;
      width = 300;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 10;
      markup = true;

      "actionable=true" = {
        border-color = "#FF6F61";
      };
    };
  };

}
