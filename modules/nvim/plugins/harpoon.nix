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
        "<leader>h" = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";

        # navigation
        "<leader>1" = "function() require'harpoon':list():select(1) end";
        "<leader>2" = "function() require'harpoon':list():select(2) end";
        "<leader>3" = "function() require'harpoon':list():select(3) end";
        "<leader>4" = "function() require'harpoon':list():select(4) end";
        "<leader>5" = "function() require'harpoon':list():select(5) end";
        "<leader>6" = "function() require'harpoon':list():select(6) end";
        "<leader>7" = "function() require'harpoon':list():select(7) end";
        "<leader>8" = "function() require'harpoon':list():select(8) end";
        "<leader>9" = "function() require'harpoon':list():select(9) end";
        "<leader>0" = "function() require'harpoon':list():select(10) end";

        # wrapped next/prev
        "<A-n>" = "function() require'harpoon':list():next({ ui_nav_wrap = true }) end";
        "<A-p>" = "function() require'harpoon':list():prev({ ui_nav_wrap = true }) end";
      };
}
