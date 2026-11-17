local neotab = require("neotab")

neotab.setup({
  tabkey = "<Tab>",
  reverse_key = "<S-Tab>",
  act_as_tab = true,
  behavior = "nested",
  pairs = {
    { open = "(", close = ")" },
    { open = "[", close = "]" },
    { open = "{", close = "}" },
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = "`", close = "`" },
    { open = "<", close = ">" },
  },
  exclude = {},
  smart_punctuators = {
    enabled = false,
    semicolon = {
      enabled = false,
      ft = { "cs", "c", "cpp", "java" },
    },
    escape = {
      enabled = false,
      triggers = {},
    },
  },
})
