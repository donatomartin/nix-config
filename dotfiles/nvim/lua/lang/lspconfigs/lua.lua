local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}

vim.lsp.config["my_lua_ls"] = {
  root_markers = root_files,
  filetypes = { "lua" },
  cmd = { "lua-language-server" },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    Lua = {
      runtime = {
        ersion = "LuaJIT", -- Neovim uses LuaJIT
      },
      diagnostics = {
        globals = { "vim", "hl" }, -- avoid "undefined global"
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
