{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dolphin
    filelight
    qt5.qttools # For qt5ct
    libsForQt5.qt5ct # Qt5 configuration utility
    libsForQt5.kio
    libsForQt5.breeze-icons
    libsForQt5.kiconthemes
    papirus-icon-theme
  ];

  # Make Qt apps respect your chosen style
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  catppuccin.gtk.enable = true;
  catppuccin.gtk.icon.enable = true;

  # Optional: Dolphin config tweaks
  xdg.configFile."dolphinrc".text = ''
    [General]
    ShowFullPath=true

    [IconsMode]
    IconSize=64
    PreviewSize=128
  '';
}
