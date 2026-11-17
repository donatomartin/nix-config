local utils = require("utils")

utils.enableMappings({
  { "<C-h>", "<cmd> TmuxNavigateLeft<cr>",  noremap = true, desc = "Tmux Move Left" },
  { "<C-j>", "<cmd> TmuxNavigateDown<cr>",  noremap = true, desc = "Tmux Move Down" },
  { "<C-k>", "<cmd> TmuxNavigateUp<cr>",    noremap = true, desc = "Tmux Move Up" },
  { "<C-l>", "<cmd> TmuxNavigateRight<cr>", noremap = true, desc = "Tmux Move Right" },
})
