{
  pkgs,
  ...
}:
{

  # Home Manager imports
  imports = [

    # Desktop Environment
    ./modules/de/hyprland.nix
    ./modules/de/hyprpaper.nix
    ./modules/de/waybar.nix
    ./modules/de/wofi.nix
    ./modules/de/ghostty.nix
    ./modules/de/cursor.nix

    # Programs
    ./modules/programs/zsh.nix
    ./modules/programs/git.nix
    ./modules/programs/gh.nix
    ./modules/programs/tmux.nix
    ./modules/programs/fastfetch.nix
    ./modules/programs/cava.nix
    ./modules/programs/peaclock.nix
    ./modules/programs/btop.nix
    ./modules/nvim/nixvim.nix

    # Programming Languages
    ./modules/programming-languages/python.nix
    ./modules/programming-languages/go.nix
    ./modules/programming-languages/nodejs.nix
    ./modules/programming-languages/java.nix
    ./modules/programming-languages/c.nix

  ];

  catppuccin.flavor = "mocha";

  home.username = "donato";
  home.homeDirectory = "/home/donato";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = [

    # CLI
    pkgs.wl-clipboard # wayland clipboard manager
    pkgs.cliphist # clipboard history
    pkgs.acpi # battery status
    pkgs.unzip # unzip files
    pkgs.zoxide # cd improvement
    pkgs.bat # cat improvement
    pkgs.slurp # select screen area
    pkgs.grim # screenshot
    pkgs.ripgrep # search tool
    pkgs.cowsay # make a cow say something
    pkgs.glib # GNU C library
    pkgs.tldr # tldr pages
    pkgs.hyprpicker # pick colors from screen
    pkgs.asciiquarium-transparent # aquarium in terminal
    pkgs.cmatrix # matrix in terminal
    pkgs.brightnessctl # control brightness

    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

  ];

  # Declare session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
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
