local kind_icons = {
  Text = '󰉿',
  Method = '󰊕',
  Function = '󰊕',
  Constructor = '󰒓',
  Field = '󰜢',
  Variable = '󰆦',
  Property = '󰖷',
  Class = "󰠱",
  Interface = "󰜰",
  Struct = "󰙅",
  Module = "󰏗",
  Unit = '󰪚',
  Value = "󰎠",
  Enum = "󰕘",
  EnumMember = "󰕘",
  Keyword = '󰻾',
  Constant = '󰏿',
  Snippet = '󰦨',
  Color = '󰏘',
  File = '󰈔',
  Reference = '󰬲',
  Folder = '󰉋',
  Event = "󰉁",
  Operator = "󰆕",
  TypeParameter = '󰬛',
}

local utils = require("utils")
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_lua").load({
  paths = {
    vim.fn.stdpath("config") .. "/lua/snippets",
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "path" },
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),

  sources = cmp.config.sources({
    { name = "cmdline" },
    { name = "path" },
  }),
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      max_height = 10,
      scrollbar = false,
      col_offset = 1,
      border = "rounded",
    },
    documentation = {
      scrollbar = false,
      border = "rounded",
    },
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
  }),
  formatting = {
    fields = { "abbr", "kind" },
    format = function(entry, item)
      item.kind = kind_icons[item.kind] or ""
      item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      })[entry.source.name]
      return item
    end,
  },

  mapping = cmp.mapping.preset.insert({

    ["<C-l>"] = cmp.mapping.complete(),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-y>"] = cmp.mapping.confirm({
      select = true,
    }),

    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
})

utils.enableMappings({
  { "<C-j>", function() if luasnip.choice_active() then luasnip.change_choice(1) end end,  mode = { "i", "s" }, desc = "LuaSnip Next Choice" },
  { "<C-k>", function() if luasnip.choice_active() then luasnip.change_choice(-1) end end, mode = { "i", "s" }, desc = "LuaSnip Previous Choice" },
})
