{
  programs.nixvim = {
    gitsigns = {
      enable = true;
      settings.signs = {
        add.text = "+";
        change.text = "~";
      };
    };
  };
}
