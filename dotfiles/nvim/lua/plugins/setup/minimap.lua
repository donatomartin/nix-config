-- The following options are recommended when layout == "float"
vim.opt.wrap = false
vim.opt.sidescrolloff = 36 -- Set a large value

--- Put your configuration here
---@type Neominimap.UserConfig
vim.g.neominimap = {
    auto_enable = false,
}

vim.api.nvim_create_user_command("Map", function() vim.cmd("Neominimap Toggle") end, {})
