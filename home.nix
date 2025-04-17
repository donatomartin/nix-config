{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./modules/hyprland.nix
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/tmux.nix
    ./modules/cursor.nix
    ./modules/wallpaper.nix
    ./modules/ghostty.nix
    ./modules/nvim/nixvim.nix
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
  home.packages = with pkgs; [
    wofi
    brave
    libreoffice
    beeper
    acpi
    unzip
    wl-clipboard
    neofetch
    zoxide
    slurp
    grim
    btop
    ripgrep

    gcc
    nodejs_22
    python313
    openjdk21
    go

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # Create symlinks for the .dotfiles
  home.file = {
  };

  # Declare session variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
