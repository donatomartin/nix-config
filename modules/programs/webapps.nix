{ pkgs, ... }:
let
  google-calendar = pkgs.makeDesktopItem {
    name = "Google Calendar";
    desktopName = "Google Calendar";
    exec = "brave --app=https://calendar.google.com --ozone-platform-hint=wayland";
    terminal = false;
    type = "Application";
    icon = ../../assets/webapp-icons/calendar.png;
  };
  spotify = pkgs.makeDesktopItem {
    name = "Spotify";
    desktopName = "Spotify";
    exec = "brave --app=https://open.spotify.com --ozone-platform-hint=wayland";
    terminal = false;
    type = "Application";
    icon = ../../assets/webapp-icons/spotify.png;
  };
in
{
  home.packages = [
    google-calendar
    spotify
  ];
}
