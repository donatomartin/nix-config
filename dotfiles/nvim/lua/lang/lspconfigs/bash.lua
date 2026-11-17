vim.lsp.config('bashls', {
  filetypes = {
    "zsh", "sh", "bash"
  },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
    }
  },
})
