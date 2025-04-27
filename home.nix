{
  config,
  pkgs,
  nix-colors,
  unstable,
  ...
}:
{
  imports = [

    ./modules/hyprland.nix
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/gh.nix
    ./modules/tmux.nix
    ./modules/cursor.nix
    ./modules/hyprpaper.nix
    ./modules/ghostty.nix
    ./modules/nvim/nixvim.nix
    ./modules/fastfetch.nix
    ./modules/cava.nix
    ./modules/peaclock.nix
    ./modules/wofi.nix

    nix-colors.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "donato";
  home.homeDirectory = "/home/donato";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    # GUI
    pkgs.brave
    pkgs.libreoffice
    pkgs.beeper
    pkgs.prismlauncher
    pkgs.obs-studio
    pkgs.discord
    pkgs.spotify
    pkgs.vlc

    # TUI
    pkgs.ranger

    # CLI
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.acpi
    pkgs.unzip
    pkgs.zoxide
    pkgs.slurp
    pkgs.grim
    pkgs.ripgrep
    pkgs.cowsay
    pkgs.glib
    pkgs.tldr
    pkgs.thefuck

    # Toolchains
    pkgs.gcc
    pkgs.nodejs_22
    pkgs.openjdk21
    pkgs.go
    (pkgs.python313.withPackages (
      ps: with ps; [
      ]
    ))

    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # base00: "#1e1e2e" # base
  # base01: "#181825" # mantle
  # base02: "#313244" # surface0
  # base03: "#45475a" # surface1
  # base04: "#585b70" # surface2
  # base05: "#cdd6f4" # text
  # base06: "#f5e0dc" # rosewater
  # base07: "#b4befe" # lavender
  # base08: "#f38ba8" # red
  # base09: "#fab387" # peach
  # base0A: "#f9e2af" # yellow
  # base0B: "#a6e3a1" # green
  # base0C: "#94e2d5" # teal
  # base0D: "#89b4fa" # blue
  # base0E: "#cba6f7" # mauve
  # base0F: "#f2cdcd" # flamingo
  # https://github.com/tinted-theming/base16-schemes/blob/main/catppuccin-mocha.yaml
  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;

  # Declare session variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
