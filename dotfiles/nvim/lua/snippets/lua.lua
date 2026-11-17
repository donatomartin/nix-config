local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- vim.pack.add({...})
  s(
    "vpack",
    fmt(
      [[
      vim.pack.add({{
        "{}",
      }})

      {}
      ]],
      {
        i(1, "https://github.com/user/repo"),
        i(0),
      }
    )
  ),

  -- Multiple vim.pack.add URLs
  s(
    "vpacks",
    fmt(
      [[
      vim.pack.add({{
        "{}",
        "{}",
        "{}",
      }})

      {}
      ]],
      {
        i(1, "https://github.com/user/plugin-a"),
        i(2, "https://github.com/user/plugin-b"),
        i(3, "https://github.com/user/plugin-c"),
        i(0),
      }
    )
  ),

  -- Add plugin and setup
  s(
    "vpsetup",
    fmt(
      [[
      vim.pack.add({{
        "{}",
      }})

      require("{}").setup({{
        {}
      }})
      ]],
      {
        i(1, "https://github.com/user/repo"),
        i(2, "plugin"),
        i(0),
      }
    )
  ),

  -- require(...).setup({...})
  s(
    "setup",
    fmt(
      [[
      require("{}").setup({{
        {}
      }})
      ]],
      {
        i(1, "plugin"),
        i(0),
      }
    )
  ),

  -- local plugin = require("plugin")
  s(
    "lreq",
    fmt([[local {} = require("{}")]], {
      f(function(args)
        local mod = args[1][1] or "mod"
        return mod:match("[^.]+$") or mod
      end, { 1 }),
      i(1, "module.name"),
    })
  ),

  -- vim.keymap.set(...)
  s(
    "map",
    fmt([[
    require("utils").enableMappings({{
      {{ {}, "{}", {} }},{}
    }})
    ]], {
      c(1, {
        t('"n"'),
        t('{ "n", "v" }')
      }),
      i(2, "<leader>x"),
      i(3),
      i(0)
    })
  ),

  s(
    "mapping",
    fmt([[
      {{ {}, "{}", {} }},
    ]], {
      c(1, {
        t('"n"'),
        t('{ "n", "v" }')
      }),
      i(2, "<leader>x"),
      i(0)
    })
  ),

  -- autocmd
  s(
    "autocmd",
    fmt(
      [[
      vim.api.nvim_create_autocmd("{}", {{
        pattern = "{}",
        callback = function()
          {}
        end,
      }})
      ]],
      {
        i(1, "BufWritePre"),
        i(2, "*"),
        i(0),
      }
    )
  ),

  -- augroup + autocmd
  s(
    "augroup",
    fmt(
      [[
      local {} = vim.api.nvim_create_augroup("{}", {{ clear = true }})

      vim.api.nvim_create_autocmd("{}", {{
        group = {},
        pattern = "{}",
        callback = function()
          {}
        end,
      }})
      ]],
      {
        i(1, "group"),
        i(2, "MyGroup"),
        i(3, "BufWritePre"),
        rep(1),
        i(4, "*"),
        i(0),
      }
    )
  ),

  -- user command
  s(
    "cmd",
    fmt(
      [[
      vim.api.nvim_create_user_command("{}", function(opts)
        {}
      end, {{
      nargs = "{}",
      desc = "{}",
    }})
    ]],
      {
        i(1, "CommandName"),
        i(2, "-- body"),
        c(3, {
          t("0"),
          t("?"),
          t("*"),
          t("+"),
          t("1"),
        }),
        i(4, "Description"),
      })
  ),

  -- buffer-local keymap
  s(
    "bufmap",
    fmt([[vim.keymap.set("{}", "{}", "{}", {{ buffer = {}, desc = "{}" }})]], {
      c(1, {
        t("n"),
        t("i"),
        t("v"),
      }),
      i(2, "K"),
      i(3, "vim.lsp.buf.hover"),
      i(4, "bufnr"),
      i(5, "Description"),
    })
  ),

  -- module table
  s(
    "mod",
    fmt(
      [[
      local M = {{}}

      {}

      return M
      ]],
      {
        i(0),
      }
    )
  ),

  -- function
  s(
    "fn",
    fmt(
      [[
      local function {}({})
      {}
    end
    ]],
      {
        i(1, "name"),
        i(2),
        i(0),
      }
    )
  ),

  -- method-style function
  s(
    "mfn",
    fmt(
      [[
        function {}.{}({})
        {}
      end
      ]],
      {
        i(1, "M"),
        i(2, "name"),
        i(3),
        i(0),
      }
    )
  ),

  -- if statement
  s(
    "if",
    fmt(
      [[
      if {} then
        {}
      end
      ]],
      {
        i(1, "condition"),
        i(0),
      }
    )
  ),

  -- if/else
  s(
    "ife",
    fmt(
      [[
      if {} then
        {}
      else
        {}
      end
      ]],
      {
        i(1, "condition"),
        i(2),
        i(0),
      }
    )
  ),

  -- for ipairs
  s(
    "fori",
    fmt(
      [[
      for {}, {} in ipairs({}) do
        {}
      end
      ]],
      {
        i(1, "_"),
        i(2, "item"),
        i(3, "items"),
        i(0),
      }
    )
  ),

  -- for pairs
  s(
    "forp",
    fmt(
      [[
      for {}, {} in pairs({}) do
        {}
      end
      ]],
      {
        i(1, "key"),
        i(2, "value"),
        i(3, "table"),
        i(0),
      }
    )
  ),

  -- protected require
  s(
    "preq",
    fmt(
      [[
      local ok, {} = pcall(require, "{}")
      if not ok then
        return
      end

      {}
      ]],
      {
        i(1, "mod"),
        i(2, "module"),
        i(0),
      }
    )
  ),

  -- print inspect
  s(
    "inspect",
    fmt([[print(vim.inspect({}))]], {
      i(1, "value"),
    })
  ),

  -- notify
  s(
    "notify",
    fmt([[vim.notify("{}", vim.log.levels.{})]], {
      i(1, "message"),
      c(2, {
        t("INFO"),
        t("WARN"),
        t("ERROR"),
        t("DEBUG"),
      }),
    })
  ),

}
