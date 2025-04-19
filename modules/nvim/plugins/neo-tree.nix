{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>Neotree toggle current reveal_force_cwd<CR>";
        options.silent = true;
      }
    ];

    plugins.neo-tree = {
      enable = true;

      filesystem.hijackNetrwBehavior = "open_current";
      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
        mappings = {
          "l" = {
            command = "open";
            nowait = false;
          };
          "h" = {
            command = "close_node";
            nowait = false;
          };
        };
      };
    };
  };
}
