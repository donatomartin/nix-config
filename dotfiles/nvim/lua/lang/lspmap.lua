return {
    ["lua_ls"] = {
      -- package = "lua-language-server",
      config = "my_lua_ls",
    },
    ["pyright"] = {
      -- package = "pyright",
      config = "pyright",
      -- dependencies = { "node", "python" },
    },
    ["vtsls"] = {
      -- package = "vtsls",
      config = "vtsls",
      -- dependencies = { "node" },
    },
    ["html"] = {
      -- package = "html-lsp",
      config = "html",
      -- dependencies = { "node" },
    },
    ["emmet-language-server"] = {
      -- package = "emmet-language-server",
      config = "emmet_language_server",
    },
    ["cssls"] = {
      -- package = "css-lsp",
      config = "cssls",
      -- dependencies = { "node" },
    },
    ["gopls"] = {
      -- package = "gopls",
      config = "gopls",
      -- dependencies = { "node" },
    },
    ["jdtls"] = {
      -- package = { "jdtls", "lombok-nightly", "java-debug-adapter" },
      -- dependencies = { "java" },
    },
    ["sonarlint"] = {
      -- package = "sonarlint-language-server",
    },
    ["bash"] = {
      -- package = { "bash-language-server" },
      config = { "bashls" },
    },
    ["ltex_plus"] = {
      -- package = "ltex-ls-plus",
      config = "ltex_plus",
    },
    ["nixd"] = {
      -- no package as it should be installed from the nixpkgs
      config = "my_nixd",
    },
    ["sql"] = {
      -- package = "sqlfluff",
    },
  }
