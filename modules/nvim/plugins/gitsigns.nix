{ ... }:
{

  keymaps = [
    {
      mode = "n";
      key = "<leader>gdh";
      action = "<cmd>Gitsigns diffthis HEAD<CR>";
      options = {
        desc = "Gitsigns diff this";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gdd";
      action = "<cmd>Gitsigns preview_hunk_inline<CR>";
      options = {
        desc = "Gitsigns preview hunk";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gdD";
      action = "<cmd>Gitsigns diffthis<CR>";
      options = {
        desc = "Gitsigns diff this";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gds";
      action = "<cmd>Gitsigns diffthis --staged<CR>";
      options = {
        desc = "Gitsigns diff this";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gbl";
      action = "<cmd>Gitsigns blame_line<CR>";
      options = {
        desc = "Gitsigns blame line";
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
    {
      mode = "n";
      key = "<leader>gsh";
      action = "<cmd>Gitsigns stage_hunk<CR>";
      options = {
        desc = "Gitsigns stage hunk";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gsb";
      action = "<cmd>Gitsigns stage_buffer<CR>";
      options = {
        desc = "Gitsigns stage buffer";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gn";
      action = "<cmd>Gitsigns next_hunk<CR>";
      options = {
        desc = "Gitsigns next hunk";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = "<cmd>Gitsigns prev_hunk<CR>";
      options = {
        desc = "Gitsigns previous hunk";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>grh";
      action = "<cmd>Gitsigns reset_hunk<CR>";
      options = {
        desc = "Gitsigns reset hunk";
        silent = true;
      };
    }

  ];

  plugins.gitsigns.enable = true;
}
