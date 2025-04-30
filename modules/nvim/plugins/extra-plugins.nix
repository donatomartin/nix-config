{
  lib,
  pkgs,
  unstable,
  ...
}:
{
  programs.nixvim = {

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
      unstable.vimPlugins.nvim-java
    ];

    extraConfigLua = lib.mkMerge [
      (lib.mkBefore ''
        require("java").setup({
          jdk = {
            auto_install = false,
          },
          spring_boot_tools = {
            enable = false,
          },
        })
      '')
      (lib.mkAfter ''
        require("lspconfig").jdtls.setup({})
      '')
    ];
  };

}
