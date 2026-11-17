vim.cmd.colorscheme "catppuccin-nvim"

local colors = require("catppuccin.palettes").get_palette("mocha")

vim.api.nvim_set_hl(0, "TabLineFill", {
  bg = "#141420",
})

vim.api.nvim_set_hl(0, "TabLine", {
  fg = colors.overlay1,
  bg = "#1a1a28",
})

vim.api.nvim_set_hl(0, "TabLineSel", {
  fg = colors.text,
  bg = "#1d1d2d",
  bold = true,
})

vim.api.nvim_set_hl(0, "ShapeSel", {
  fg = "#1d1d2d",
  bg = "#141420",
})

vim.api.nvim_set_hl(0, "Shape", {
  fg = "#1a1a28",
  bg = "#141420",
})
