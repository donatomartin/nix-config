{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      confirm-close-surface = false;
      mouse-hide-while-typing = true;
      background-opacity = 0.8;
      background-blur = true;
    };
  };
}
