{ ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>q<CR>";
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = "<cmd>set rnu!<CR>";
      options = {
        silent = true;
        desc = "toggle relative number";
      };
    }
    {
      mode = "n";
      key = "<C-c>";
      action = "<cmd>%y+<CR>";
      options = {
        silent = true;
        desc = "copy whole file";
      };
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-N>";
      options = {
        silent = true;
        desc = "Escape terminal mode";
      };
    }
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>noh<CR>";
      options = {
        silent = true;
        desc = "Clear highlights";
      };
    }
    {
      mode = "n";
      key = ";";
      action = "<cmd>lua vim.api.nvim_feedkeys(':! ', 'm', true)<CR>";
      options = {
        silent = true;
        desc = "Execute terminal command";
      };
    }
    {
      mode = "i";
      key = "<C-h>";
      action = "<Left>";
      options = {
        silent = true;
        desc = "Move cursor left in insert mode";
      };
    }
    {
      mode = "i";
      key = "<C-l>";
      action = "<Right>";
      options = {
        silent = true;
        desc = "Move cursor right in insert mode";
      };
    }
    {
      mode = "i";
      key = "<C-j>";
      action = "<Down>";
      options = {
        silent = true;
        desc = "Move cursor down in insert mode";
      };
    }
    {
      mode = "i";
      key = "<C-k>";
      action = "<Up>";
      options = {
        silent = true;
        desc = "Move cursor up in insert mode";
      };
    }
  ];
}
