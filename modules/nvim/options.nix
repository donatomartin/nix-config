{
  programs.nixvim = {

    opts = {

      relativenumber = true;
      number = true;
      swapfile = false;
      mouse = "a";
      undofile = true;

      # Indenting
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
      softtabstop = 2;

    };
  };
}
