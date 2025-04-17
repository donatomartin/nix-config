{ config, pkgs, ... }:

let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "kde";
    rev = "main"; # You can pin a specific commit too
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with real hash
  };
in
{
  home.packages = with pkgs; [
    dolphin
    filelight
    qt5.qttools # For qt5ct
    qt5ct # Qt5 configuration utility
    libsForQt5.kio-fuse
    libsForQt5.kio
    libsForQt5.breeze-icons
    libsForQt5.kiconthemes
    papirus-icon-theme
  ];

  # Make Qt apps respect your chosen style
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  # Set GTK/Qt themes (Catppuccin flavor: Mocha in this case)
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Copy Catppuccin KDE theme manually (if not using full KDE Plasma)
  home.file.".local/share/color-schemes/CatppuccinMocha.colors".source =
    "${catppuccin}/themes/Catppuccin-Mocha/colors/CatppuccinMocha.colors";

  # Optional: Dolphin config tweaks
  xdg.configFile."dolphinrc".text = ''
    [General]
    ShowFullPath=true

    [IconsMode]
    IconSize=64
    PreviewSize=128
  '';
}
