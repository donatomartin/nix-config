local opts = {
  fast_wrap = {},
  disable_filetype = { "vim", "snacks_picker_input" },
}

local autopairs = require("nvim-autopairs")

autopairs.setup(opts)

local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

autopairs.add_rules({ rule("<", ">", { "java" }):with_move(cond.after_regex("<")) })
