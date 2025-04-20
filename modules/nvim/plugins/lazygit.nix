{
  programs.nixvim = {
    plugins.lazygit = {
      enable = true;
      keymaps = {
        "<leader>fg" = "lazygit";
      };
    };
  };
}
