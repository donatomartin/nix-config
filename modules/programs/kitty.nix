{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";  # (without .conf suffix) :contentReference[oaicite:1]{index=1}
    # other settings
    settings = {
      font_size = 16;
      cursor_color = "#CDD6F4";
      cursor_opacity = 0.5;           # note that this may need to be a string
      mouse_hide_while_typing = true;
      confirm_os_window_close = 0;
    };
  };

}
