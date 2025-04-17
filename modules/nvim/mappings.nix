{
  programs.nixvim = {

    keymaps = [
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

        mode = [
          "n"
          "i"
        ];
        key = "<C-s>";
        action = "<cmd>w<CR>";
        options = {
          desc = "file save";
        };

      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>set nu!<CR>";
        options = {
          silent = true;
          desc = "toggle line number";
        };
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
        key = "<leader>qq";
        action = "<cmd>Neotree close<CR><cmd>q<CR>";
        options = {
          silent = true;
          desc = "Clear highlights";
        };
      }
    ];
  };
}
