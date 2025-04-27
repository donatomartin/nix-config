{
  lib,
  pkgs,
  unstable,
  ...
}:
{
  programs.nixvim = {

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
