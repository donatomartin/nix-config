{ pkgs, ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "Z";
      action = "<cmd>lua vim.api.nvim_feedkeys(':Z ', 'm', true)<CR>";
      options = {
        silent = true;
        desc = "Zoxide";
      };
    }
  ];

  extraPlugins = [
    pkgs.vimPlugins.zoxide-vim
  ];

}
