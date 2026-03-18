{ pkgs, inputs, username, ... }: {

  # Home Manager imports
  imports = [

    inputs.catppuccin.homeModules.catppuccin

    # Desktop Environment
    ./modules/programs/hyprland.nix
    ./modules/programs/waybar.nix
    ./modules/programs/rofi.nix
    ./modules/programs/mako.nix
    ./modules/programs/kitty.nix
    ./modules/programs/cursor.nix
    ./modules/programs/gtk.nix

    # Programs
    ./modules/programs/zsh.nix
    ./modules/programs/gh.nix
    ./modules/programs/cava.nix
    ./modules/programs/btop.nix
    ./modules/programs/ranger.nix
    ./modules/programs/eclipse.nix
    ./modules/programs/webapps.nix

    # Services
    ./modules/services/batsignal.nix
    ./modules/services/hypridle.nix

  ];

  catppuccin.flavor = "mocha";

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [

    # Fonts
    nerd-fonts.jetbrains-mono

    # CLI Tools
    docker # containerization sw
    git # version control system
    neovim # text editor
    tmux # terminal multiplexor
    file # file type detection

    pgcli # PostgreSQL CLI
    mongosh # MongoDB CLI
    tldr # tldr pages
    dust # disk usage analyzer
    httpie # HTTP client
    jq # JSON processor
    bat # cat improvement
    fd # find replacement
    ripgrep # search tool
    phase-cli # secrets manager CLI
    sqlite-utils # SQLite utilities
    dos2unix # fix carriage return problems
    wineWowPackages.full # wine packages for running windows applications
    imagemagick # image library
    ffmpeg # video library
    brightnessctl # control brightness
    hyprpicker # pick colors from screen
    gammastep # shaders for hyprland
    appimage-run # run appimages in nixos
    hyprshot # screenshot for hyprland
    acpi # battery status
    zip # zip files
    unzip # unzip files
    unrar # For unrar
    dialog # show dialogs in terminal
    freerdp # rdp client
    gcc # gnu compiler collection
    cargo # rust package manager and build tool
    wl-clipboard # wayland clipboard manager

    ollama # local LLM server

    asciinema # session recorder
    asciiquarium-transparent # aquarium in terminal
    cowsay # make a cow say something
    cmatrix # matrix in terminal
    fastfetch # system display

    # GUI Apps
    heroic # games launcher
    qbittorrent # torrent client
    file-roller # archive manager
    libreoffice # office suite
    onlyoffice-desktopeditors # alt office suite
    prismlauncher # minecraft launcher
    obs-studio # video recording sw
    vlc # media player
    anydesk # remote support tool
    vscode # IDE
    firefox # browser 1
    brave # browser 2
    inkscape # vector graphic design
    pavucontrol # audio GUI manager
    neovide # neovim frontend
    sqlite-web # SQLite web interface
    seahorse # secret manager
    copyq # clipboard history with integrated ui
    kdePackages.kdeconnect-kde # smartphone connection
    obsidian # note taking app
    bruno # http client
    dbeaver-bin # database UI
    texpresso # latex UI

    # Important Dependencies
    xfce.xfconf # Xfce config manager
    inkcut # Plotter communication sw
    glib # core library for gnome and gtk

    nixd # for nvim lsps 
    python3 # for nvim lsps
    tree-sitter # for nvim tree-sitter
    go # for nvim lsps
    nodejs_24 # for nvim lsps
    pnpm # for tooling
    temurin-bin-21 # for tooling
    maven # for tooling

    unstable.codex
  ];

  home.sessionVariables = { EDITOR = "nvim"; };

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
