local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
--local c = ls.choice_node
local f = ls.function_node
--local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

local function jira_ticket()
  local branch = vim.fn.system("git branch --show-current"):gsub("%s+", "")
  return branch:match("([A-Z]+%-%d+)") or "NO-JIRA"
end

local function jira_prefix_snippet(trigger)
  return s(trigger, fmt("[{}] ", f(jira_ticket)))
end

local function commit_snippet(trigger, kind, scope)
  scope = scope or false

  if scope then
    return s(trigger, fmt("{}({}): {}", {
      t(kind),
      i(1, "scope"),
      i(2, "message"),
    }))
  end

  return s(trigger, fmt("{}: {}", {
    t(kind),
    i(1, "message"),
  }))
end

return {

  jira_prefix_snippet("ji"),

  commit_snippet("ft", "feat"),
  commit_snippet("fx", "fix"),
  commit_snippet("cr", "core"),
  commit_snippet("ref", "refactor"),
  commit_snippet("doc", "docs"),
  commit_snippet("t", "test"),
  commit_snippet("ch", "chore"),
  commit_snippet("pf", "perf"),

  commit_snippet("fts", "feat", true),
  commit_snippet("fxs", "fix", true),
  commit_snippet("crs", "core", true),
  commit_snippet("refs", "refactor", true),
  commit_snippet("docs", "docs", true),
  commit_snippet("ts", "test", true),
  commit_snippet("chs", "chore", true),
  commit_snippet("pfs", "perf", true),
}
