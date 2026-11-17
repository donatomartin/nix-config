local M = {}

function M.config()
  vim.lsp.config("*", {
    root_markers = { ".git" },
  })

  require("lang.lspconfigs.lua")
  require("lang.lspconfigs.latex")
  require("lang.lspconfigs.bash")
  require("lang.lspconfigs.nix")
end

return M
