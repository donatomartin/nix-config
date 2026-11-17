require("lualine").setup({
  sections = {
    lualine_a = { 'filename' },
    lualine_b = { 'branch', 'diagnostics' },
    lualine_c = { 'lsp_status' },
    lualine_x = { 'encoding', 'fileformat', },
    lualine_y = { 'filesize', 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = { 'diagnostics' },
    lualine_c = { 'lsp_status' },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  }
})
