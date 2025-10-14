{
  pkgs,
  self,
  system,
  inputs,
  username,
  ...
}:
{

  # Home Manager imports
  imports = [

    inputs.catppuccin.homeModules.catppuccin

    # Desktop Environment
    ./modules/programs/hyprland.nix
    ./modules/programs/hyprpaper.nix
    ./modules/programs/waybar.nix
    ./modules/programs/rofi.nix
    ./modules/programs/mako.nix
    ./modules/programs/ghostty.nix
    ./modules/programs/cursor.nix
    ./modules/programs/gtk.nix

    # Programs
    ./modules/programs/zsh.nix
    ./modules/programs/gh.nix
    ./modules/programs/tmux.nix
    ./modules/programs/cava.nix
    ./modules/programs/btop.nix
    ./modules/programs/ranger.nix
    ./modules/programs/eclipse.nix
    ./modules/programs/webapps.nix


    # Services
    ./modules/services/batsignal.nix

    # System Programming Languages
    ./modules/programming-languages/python.nix
    ./modules/programming-languages/go.nix
    ./modules/programming-languages/nodejs.nix
    ./modules/programming-languages/java.nix

  ];

  catppuccin.flavor = "mocha";

  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = [

    pkgs.dialog
    pkgs.freerdp

    pkgs.wl-clipboard # wayland clipboard manager
    pkgs.copyq # clipboard history with integrated ui

    pkgs.acpi # battery status
    pkgs.zip # zip files
    pkgs.unzip # unzip files

    pkgs.bat # cat improvement
    pkgs.fd # find replacement
    pkgs.ripgrep # search tool
    pkgs.tldr # tldr pages
    pkgs.dust # disk usage analyzer
    pkgs.httpie # HTTP client
    pkgs.jq # JSON processor
    pkgs.atool # archive manager
    pkgs.dotenvx # dotenv file support
    pkgs.manix # nixos manuals

    pkgs.hyprshot # screenshot for hyprland

    pkgs.appimage-run

    pkgs.asciinema # session recorder
    pkgs.asciiquarium-transparent # aquarium in terminal
    pkgs.cowsay # make a cow say something
    pkgs.cmatrix # matrix in terminal

    pkgs.hyprpicker # pick colors from screen
    pkgs.gammastep # shaders for hyprland
    pkgs.brightnessctl # control brightness
    pkgs.ffmpeg # video library
    pkgs.imagemagick # image library
    pkgs.wineWowPackages.full # wine packages for running windows applications
    pkgs.dos2unix # fix carriage return problems
    pkgs.file # file type detection

    pkgs.ollama # local LLM server

    pkgs.pgcli # PostgreSQL CLI
    pkgs.mongosh # MongoDB CLI
    pkgs.sqlite-utils # SQLite utilities
    pkgs.sqlite-web # SQLite web interface

    pkgs.unrar # For unrar

    # Fonts
    pkgs.nerd-fonts.jetbrains-mono

    # CLI
    pkgs.docker
    pkgs.git
    pkgs.neovim
    pkgs.vim

    # GUI
    pkgs.qbittorrent
    pkgs.xfce.thunar
    pkgs.libreoffice
    pkgs.prismlauncher
    pkgs.obs-studio
    pkgs.vesktop
    pkgs.vlc
    pkgs.anydesk
    pkgs.vscode
    pkgs.firefox
    pkgs.brave
    pkgs.android-studio
    pkgs.networkmanagerapplet
    pkgs.jetbrains.webstorm
    pkgs.audacity

    pkgs.inkscape
    pkgs.inkcut

    pkgs.phase-cli
    pkgs.pavucontrol

  ];

  home.sessionVariables = {
  	EDITOR = "nvim";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # File Manager
      "inode/directory" = [ "thunar.desktop" ];
      "x-scheme-handler/file" = [ "thunar.desktop" ];

      # Web-related defaults → Firefox only

      "text/html" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/ftp" = [ "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ]; # Prevents Chrome/Brave takeover
    };
    associations.added = {
      # Reinforce file manager association
      "inode/directory" = [ "thunar.desktop" ];
      
      # Explicitly associate all web content types with Firefox
      "text/html" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/ftp" = [ "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

}
