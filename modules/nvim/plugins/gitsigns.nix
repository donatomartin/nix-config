{ ... }:
{

  keymaps = [
    {
      mode = "n";
      key = "<leader>gD";
      action = "<cmd>Gitsigns diffthis HEAD<CR>";
      options = {
        desc = "Gitsigns diff this";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = "<cmd>Gitsigns preview_hunk_inline<CR>";
      options = {
        desc = "Gitsigns preview hunk";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Gitsigns blame_line<CR>";
      options = {
        desc = "Gitsigns blame line";
        silent = true;
      };
    }

  ];

  plugins.gitsigns.enable = true;
}
