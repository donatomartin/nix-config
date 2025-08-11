{
  programs.zellij = {
    enable = true;
    extraConfig = ''
      [keybinds]
      # Start copy mode with C-b v
      copy-mode = "C-b v"
      # Swap panes with Ctrl+b + H/L 
      swap-pane-left = "C-b H"
      swap-pane-right = "C-b L"

      [appearance]
      active-border-color = "#89B4FA"  # catppuccinMocha.blue
      inactive-border-color = "#191928"  # catppuccinMocha.bg2
    '';
  };
}
