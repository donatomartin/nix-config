{
  config,
  pkgs,
  catppuccin,
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
    ./modules/rofi.nix
    ./modules/waybar.nix
    ./modules/btop.nix
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
    pkgs.vesktop
    pkgs.spotify
    pkgs.vlc
    unstable.anydesk

    # CLI
    pkgs.wl-clipboard # wayland clipboard manager
    pkgs.cliphist # clipboard history
    pkgs.acpi # battery status
    pkgs.unzip # unzip files
    pkgs.zoxide # zsh cd improvement
    pkgs.slurp # select screen area
    pkgs.grim # screenshot
    pkgs.ripgrep # search tool
    pkgs.cowsay # make a cow say something
    pkgs.glib # GNU C library
    pkgs.tldr # tldr pages
    pkgs.thefuck # fix command line mistakes

    # Toolchains
    pkgs.gcc
    pkgs.nodejs_22
    pkgs.openjdk21
    pkgs.go
    (pkgs.python313.withPackages (
      ps: with ps; [
      ]
    ))
  ];

  catppuccin.flavor = "mocha";

  # Declare session variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
