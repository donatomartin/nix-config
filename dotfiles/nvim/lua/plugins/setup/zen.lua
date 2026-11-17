local zen = require("zen-mode")
zen.setup()

require("utils").enableMappings({
  { "<leader>z", zen.toggle, desc = "Toggle Zen mode"}
})
