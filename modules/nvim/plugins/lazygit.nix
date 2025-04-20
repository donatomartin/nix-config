{
  programs.nixvim = {

    keymaps = [
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>LazyGit<CR>";
        options = {
          desc = "LazyGit";
          silent = true;
        };
      }
    ];
    plugins.lazygit = {
      enable = true;
    };
  };
}
