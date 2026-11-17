local utils = require("utils")
require("bruno").setup({
  picker = "snacks",
  default_view = "body",
  collection_paths = {
    {
      name = "opencollection",
      path = vim.fn.glob(vim.fn.getcwd() .. "/**/opencollection"),
    },
  },
})

utils.enableMappings({
  { "<leader>br", "<cmd>BrunoRun<cr>", desc = "Bruno Run" },
  { "<leader>by", "<cmd>BrunoCopy<cr>", desc = "Bruno Copy" },
  { "<leader>be", "<cmd>BrunoEnv<cr>", desc = "Bruno Env" }
})
