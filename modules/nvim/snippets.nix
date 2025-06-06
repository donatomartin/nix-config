{

  extraConfigLua = ''
    vim.keymap.set({"i", "s"}, "<Tab>", function()
      return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
    end, {expr = true, silent = true})

    vim.keymap.set({"i", "s"}, "<S-Tab>", function()
      return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
    end, {expr = true, silent = true})
  '';

  plugins.luasnip = {
    enable = true;
    fromLua = [
      {
        paths = builtins.path {
          name = "neovim-snippets";
          path = ./snippets;
        };
      }
    ];

    settings = {
      delete_check_events = "TextChanged";
      history = true;
    };

  };

}
