{ lib, ... }:
{
  plugins.harpoon = {
    enable = true;
    enableTelescope = true;
  };
  keymaps =
    lib.mapAttrsToList
      (key: action: {
        mode = "n";
        inherit key;
        action.__raw = action;
      })
      {
        # add current file
        "<leader>a" = "function() require'harpoon':list():add() end";

        # open menu
        "<leader>e" = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";

        # navigation
        "<leader>h" = "function() require'harpoon':list():select(1) end";
        "<leader>j" = "function() require'harpoon':list():select(2) end";
        "<leader>k" = "function() require'harpoon':list():select(3) end";
        "<leader>l" = "function() require'harpoon':list():select(4) end";
        "<leader>ñ" = "function() require'harpoon':list():select(5) end";
      };
}
