{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      confirm-close-surface = false;
      mouse-hide-while-typing = true;
      cursor-color = "#CDD6F4";
      cursor-opacity = 0.5;
      font-size = 16;
      term = "xterm-256color";

      # Alt+number → ESC+number
      "keybind" = [
        "alt+1=esc:1"
        "alt+2=esc:2"
        "alt+3=esc:3"
        "alt+4=esc:4"
        "alt+5=esc:5"
        "alt+6=esc:6"
        "alt+7=esc:7"
        "alt+8=esc:8"
        "alt+9=esc:9"
        "alt+0=esc:0"
      ];
    };
  };
}
