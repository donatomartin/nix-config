local utils = require "utils"
local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add = { text = "│", hl = "GitSignsAdd" },
    change = { text = "│", hl = "GitSignsChange" },
    delete = { text = "󰍵", hl = "GitSignsDelete" },
    topdelete = { text = "󰍵", hl = "GitSignsDelete" },
    changedelete = { text = "󰍵", hl = "GitSignsChange" },
    untracked = { text = "│", hl = "GitSignsAdd" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,

  current_line_blame_formatter = "  <author>, <author_time:%R> • <summary>",
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 300,
  },
})

--- CUSTOM FUNCTIONS

local diffAgainsCommit = function()
  local commit = vim.fn.input("Commit/ref: ")
  if commit == nil or commit == "" then
    return
  end
  vim.cmd("Gitsigns diffthis " .. commit .. " HEAD")
  vim.defer_fn(function() vim.cmd("wincmd h") end, 50)
end

local diffChanges = function()
  vim.cmd("Gitsigns diffthis")
  vim.cmd("wincmd h");
end

local diffAgainstHead = function()
  vim.cmd("Gitsigns diffthis HEAD")
  vim.cmd("wincmd h");
end

local diffStaged = function()
  vim.cmd("Gitsigns diffthis --staged")
  vim.cmd("wincmd h");
end

local stageSelection = function()
  gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end

local nav_hunk_next = function()
  gitsigns.nav_hunk('next')
end

local nav_hunk_prev = function()
  gitsigns.nav_hunk('prev')
end

--- ENABLE MAPPINGS

utils.enableMappings(
  {
    { "<leader>gdd", diffChanges,                  desc = "Git Diff Changes" },
    { "<leader>gdh", diffAgainstHead,              desc = "Git Diff Agains HEAD" },
    { "<leader>gds", diffStaged,                   desc = "Git Diff Staged Changes" },
    { "<leader>gdc", diffAgainsCommit,             desc = "Git Diff Agains Commit" },
    { "<leader>ghs", stageSelection,               desc = "Git Stage Selection",    mode = "v" },
    { "<leader>ghd", gitsigns.preview_hunk_inline, desc = "Git Preview Hunk Inline" },
    { "<leader>ghs", gitsigns.stage_hunk,          desc = "Git Stage Hunk" },
    { "<leader>ghv", gitsigns.select_hunk,         desc = "Git Select Hunk" },
    { "<leader>ghr", gitsigns.reset_hunk,          desc = "Git Reset Hunk" },
    { "<leader>ghn", nav_hunk_next,                desc = "Git Go to Next Hunk" },
    { "<leader>ghN", nav_hunk_prev,                desc = "Git Go to Prev Hunk" },
    { "<leader>ghp", nav_hunk_prev,                desc = "Git Go to Prev Hunk" },
    { "<leader>glb", gitsigns.blame_line,          desc = "Git Blame Line" },
    { "<leader>gbr", gitsigns.reset_buffer,        desc = "Git Reset Buffer" },
    { "<leader>gbs", gitsigns.stage_buffer,        desc = "Git Stage Buffer" },
  }
)
