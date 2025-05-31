{
  programs.nixvim = {
    keymaps = [
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
        key = "<leader>qq";
        action = "<cmd>Neotree close<CR><cmd>qa<CR>";
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
        mode = "n";
        key = "<M-n>";
        action = "<cmd>buffer #<CR>";
        options = {
          silent = true;
          desc = "Switch to last buffer";
        };
      }
      {
        mode = "i";
        key = "<C-h>";
        action = "<Left>";
      }
      {
        mode = "i";
        key = "<C-l>";
        action = "<Right>";
      }
      {
        mode = "i";
        key = "<C-j>";
        action = "<Down>";
      }
      {
        mode = "i";
        key = "<C-k>";
        action = "<Up>";
      }
    ];
  };
}
