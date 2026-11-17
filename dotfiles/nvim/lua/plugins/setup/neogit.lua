local utils = require("utils")
local neogit = require("neogit")

neogit.setup({
  kind = "replace",
})

utils.enableMappings({
  { "<leader>gg", neogit.open, desc = "Neogit open" }
})
