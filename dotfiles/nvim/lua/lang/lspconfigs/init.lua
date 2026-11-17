local M = {}

function M.config(on_attach)
  vim.lsp.config("*", {
    root_markers = { ".git" },
    on_attach = on_attach,
  })

  require("lang.lspconfigs.lua")
  require("lang.lspconfigs.latex")
  require("lang.lspconfigs.bash")
  require("lang.lspconfigs.nix")
end

return M
