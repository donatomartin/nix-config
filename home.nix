{
  pkgs,
  unstable,
  inputs,
  username,
  ...
}:
{

  # Home Manager imports
  imports = [

    inputs.nixvim.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin

    # Desktop Environment
    ./modules/de/hyprland
    ./modules/de/hyprpaper.nix
    ./modules/de/waybar.nix
    ./modules/de/wofi.nix
    ./modules/de/ghostty.nix
    ./modules/de/cursor.nix
    ./modules/de/gtk.nix

    # Programs
    ./modules/programs/zsh.nix
    ./modules/programs/git.nix
    ./modules/programs/gh.nix
    ./modules/programs/tmux.nix
    ./modules/programs/fastfetch.nix
    ./modules/programs/cava.nix
    ./modules/programs/peaclock.nix
    ./modules/programs/btop.nix
    ./modules/programs/ranger.nix
    ./modules/nvim/nixvim.nix

    # Programming Languages
    ./modules/programming-languages/python.nix
    ./modules/programming-languages/go.nix
    ./modules/programming-languages/nodejs.nix
    ./modules/programming-languages/java.nix
    ./modules/programming-languages/c.nix

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

    # TUI
    pkgs.asciiquarium-transparent # aquarium in terminal
    pkgs.cmatrix # matrix in terminal
    pkgs.posting # tui web agent

    # CLI
    pkgs.wl-clipboard # wayland clipboard manager
    pkgs.cliphist # clipboard history
    pkgs.acpi # battery status
    pkgs.zip # zip files
    pkgs.unzip # unzip files
    pkgs.zoxide # cd improvement
    pkgs.bat # cat improvement
    pkgs.slurp # select screen area
    pkgs.grim # screenshot
    pkgs.ripgrep # search tool
    pkgs.cowsay # make a cow say something
    pkgs.tldr # tldr pages
    pkgs.hyprpicker # pick colors from screen
    pkgs.hyprshade # shaders for hyprland
    pkgs.brightnessctl # control brightness
    pkgs.ffmpeg # video library
    pkgs.imagemagick # image library
    pkgs.wineWowPackages.full # wine packages for running windows applications
    pkgs.dos2unix # fix carriage return problems

    # Fonts
    pkgs.nerd-fonts.jetbrains-mono

  ];

  # Declare session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen";
    TERMINAL = "ghostty";
    TERM = "ghostty";
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
