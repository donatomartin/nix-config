local lint = require("lint")

lint.linters.sqlfluff = {
  name = "sqlfluff",
  cmd = "sqlfluff",
  stdin = false,
  append_fname = true,
  args = {
    "lint",
    "--format",
    "json",
    "--dialect",
    "tsql",
  },
  parser = require("lint.linters.sqlfluff").parser,
}

lint.linters_by_ft = {
  sql = { "sqlfluff" },
}

vim.api.nvim_create_autocmd({
  "BufEnter",
  "BufWritePost",
}, {
  pattern = "*.sql",
  callback = function()
    lint.try_lint()
  end,
})
