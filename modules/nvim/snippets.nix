{

  keymaps = [
    {
      mode = [
        "i"
        "s"
      ];
      action =
        # sh
        ''
          function()
            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
          end
        '';
      key = "<Tab>";
      lua = true;
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "i"
        "s"
      ];
      action =
        # lua
        ''
          function()
            return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
          end
        '';
      key = "<S-Tab>";
      lua = true;
      options = {
        expr = true;
        silent = true;
      };
    }
  ];

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
