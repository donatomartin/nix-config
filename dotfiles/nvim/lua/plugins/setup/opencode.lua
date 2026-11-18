local utils = require("utils")
local opencode_cmd = "opencode"
local terminal_opts = {
  win = {
    position = "right",
    enter = false,
  },
}

utils.enableMappings({
  { "<leader>oa", function() require("opencode").ask("@this: ") end,                             desc = "Ask OpenCode",           mode = { "n", "x" } },
  { "<leader>os", function() require("opencode").select() end,                                   desc = "Select OpenCode",        mode = { "n", "x" } },
  { "go",         function() return require("opencode").operator("@this") end,                   desc = "Send range to OpenCode", expr = true,         mode = { "n", "x" }, },
  { "goo",        function() return require("opencode").operator("@this") .. "_" end,            desc = "Send line to OpenCode",  expr = true, },
  { "<C-.>",      function() require("snacks").terminal.toggle(opencode_cmd, terminal_opts) end, desc = "Toggle OpenCode",        mode = { "n", "t" }, },
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("OpenCodeTerminal", { clear = true }),
  pattern = "OpencodeEvent:session.execution.started",
  callback = function()
    local terminal = require("snacks").terminal.get(opencode_cmd, { create = false })
    if terminal then
      terminal:show()
    end
  end,
})
