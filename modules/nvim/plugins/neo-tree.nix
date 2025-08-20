{
  keymaps = [
    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>Neotree toggle right reveal_force_cwd<CR>";
      options.silent = true;
    }
  ];

  plugins.neo-tree = {
    enable = true;

    filesystem = {
      hijackNetrwBehavior = "disabled";
      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = false;
      };
    };

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
}
