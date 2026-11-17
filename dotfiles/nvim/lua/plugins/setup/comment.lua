local cb = require("comment-box")

-- ╭────────────────────────────────────────────────────────╮
-- │ CUSTOM FORMATTER FRIENDLY FORMAT
-- ╰────────────────────────────────────────────────────────╯

cb.setup({
  comment_style = "line",
  box_width = 59,
  doc_width = 80,

  borders = {
    top = "─",
    bottom = "─",
    left = "│",
    right = "",
    top_left = "╭",
    top_right = "╮",
    bottom_left = "╰",
    bottom_right = "╯",
  },

  outer_blank_lines_above = false,
  outer_blank_lines_below = false,
  inner_blank_lines = false,
})

-- :CB works in Normal and Visual mode
vim.api.nvim_create_user_command("CB", function()
  cb.llbox()
end, { range = true })

vim.api.nvim_create_user_command("CL", function()
  cb.ccline()
end, { range = true })
