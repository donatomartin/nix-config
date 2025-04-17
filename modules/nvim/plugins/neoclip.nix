{
  programs.nixvim = {

    keymaps = [
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>Telescope neoclip<CR>";
        options = {
          desc = "Telescope neoclip";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fm";
        action = "<cmd>Telescope macroscope<CR>";
        options = {
          desc = "Telescope macroscope";
          silent = true;
        };
      }
    ];

    plugins.sqlite-lua.enable = true;
    plugins.neoclip = {
      enable = true;

      settings = {
        enable_persistent_history = true;
        enable_macro_history = true;
      };
    };
  };
}
