{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<A-i>";
        action = "<cmd>FloatermToggle<CR>";
        options = {
          silent = true;
          desc = "Open floating terminal";
        };
      }
    ];

    plugins.floaterm = {
      enable = true;
    };
  };
}
