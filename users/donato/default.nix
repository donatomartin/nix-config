{ pkgs, username, ... }: {

  # Home Manager imports
  imports = [

    # Desktop Environment
    ../../modules/home/programs/waybar.nix
    ../../modules/home/programs/kitty.nix
    ../../modules/home/programs/cursor.nix
    ../../modules/home/programs/gtk.nix

    # Programs
    ../../modules/home/programs/gh.nix
    ../../modules/home/programs/ranger.nix

    # Services
    ../../modules/home/services/batsignal.nix
    ../../modules/home/services/mako.nix
    ../../modules/home/services/pueue.nix

  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [

    # Fonts
    nerd-fonts.lilex
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono

    # Icons
    papirus-icon-theme

    # CLI Tools
    just # project commands manager
    pueue # shell command manager
    git # version control system
    tmux # terminal multiplexor
    file # file type detection
    wireguard-tools # wireguard
    age # encryption tool
    sops # secret manager
    lsof # list open files
    nmap # network discovery
    mermaid-cli # Mermaid CLI
    openssl # OpenSSL
    tldr # tldr pages
    dust # disk usage analyzer
    httpie # HTTP client
    jq # JSON processor
    bat # cat improvement
    fd # find replacement
    fzf # fuzzy finder
    zoxide # fast cd command
    starship # customizable prompt
    ripgrep # search tool
    dos2unix # fix carriage return problems
    wineWow64Packages.full # wine packages for running windows applications
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
    wl-clipboard # wayland clipboard manager
    ollama # local LLM server
    sox # audio converter
    fastfetch # system display

    # TUI Apps
    unstable.opencode # code agent
    opencode-claude-auth # opencode plugin
    unstable.claude-code # anthropic's code agent
    unstable.codex # openai's code agent
    unstable.neovim # text editor
    lazysql # DB management tool
    lazygit # UI for git
    lazydocker # UI for docker
    cmatrix # matrix in terminal
    cowsay # make a cow say something
    asciinema # session recorder
    asciiquarium-transparent # aquarium in terminal

    # GUI Apps
    nwg-displays
    freecad # 3D Modeler
    inkscape # Vector graphics editor
    davinci-resolve # Video Editor 
    rofi # GUI menu
    vesktop # discord client
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
    brave # browser 1
    firefox # browser 2
    pavucontrol # audio GUI manager
    neovide # neovim frontend
    sqlite-web # SQLite web interface
    seahorse # secret manager
    copyq # clipboard history with integrated ui
    obsidian # note taking app
    bruno # http client
    dbeaver-bin # database UI
    texpresso # latex UI
    texliveFull # latex environment

    # Important Dependencies
    xfconf # Xfce config manager
    glib # core library for gnome and gtk

    # Programming Basics
    go # golang
    air # live reload for go
    delve # debugger for go

    nodejs # typescript, javascript
    pnpm # efficient package manager for javascript

    temurin-bin-21 # java
    maven # java projects build automation tool

    python313 # python
    python313Packages.debugpy # debugger for python

    rustc # rust compiler
    cargo # rust package manager and build tool

    gcc # gnu compiler collection

    nixd # nix language server 
    nixfmt # nix formatter

  ];

  home.file.".jdks/temurin-25".source = pkgs.temurin-bin-25;

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
