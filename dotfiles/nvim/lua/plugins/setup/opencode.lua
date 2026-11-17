vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

local utils = require("utils")
-- local opencode = require("opencode")

utils.enableMappings({
  -- { "<leader>oa", function() opencode.ask() end,                      desc = "Ask OpenCode",             mode = { "n", "x" }, },
  -- { "<leader>os", function() opencode.select() end,                   desc = "Select OpenCode",          mode = { "n", "x" }, },
  -- { "go",         function() return opencode.operator("") end,        desc = "Append range to OpenCode", expr = true,         mode = { "n", "x" }, },
  -- { "goo",        function() return opencode.operator("") .. "_" end, desc = "Append line to OpenCode",  expr = true },
})
