local utils = require("utils")
local whichKey = require("which-key")

utils.enableMappings({
  { "<leader>?", function() whichKey.show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" },
})
