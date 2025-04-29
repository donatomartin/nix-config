{ ... }:
{
  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      icon-theme = "Papirus"; # asegúrate de tenerlo instalado
      font = "JetBrainsMono Nerd Font 12";
      display-drun = "  Apps: ";
      drun-display-format = "{icon} {name}";
    };
  };

  catppuccin.rofi.enable = true;
}
