-- Define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- UI
vim.o.statuscolumn = " %s%l%C "
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "t:ver25",
}
local function get_tab_name(tabnr)
  local win = vim.fn.tabpagewinnr(tabnr)
  local buflist = vim.fn.tabpagebuflist(tabnr)
  local bufnr = buflist[win]

  local name = vim.fn.bufname(bufnr)

  if name == "" then
    return "[No Name]"
  end

  return vim.fn.fnamemodify(name, ":t")
end

function _G.custom_tabline()
  local result = ""

  local current = vim.fn.tabpagenr()
  local total = vim.fn.tabpagenr("$")

  for i = 1, total do
    local active = i == current
    local name = get_tab_name(i)

    local fill = "%#TabLineFill#"
    local hl = active and "%#TabLineSel#" or "%#TabLine#"
    local shape = active and "%#ShapeSel#" or "%#Shape#"
    local sep_hl = active and "%#TabLineSel#" or "%#TabLine#"

    result = result
      .. fill
      .. shape
      .. ""
      .. hl
      .. "%" .. i .. "T"
      .. " 󰈙 "
      .. name
      .. " 󰅖 "
      .. shape
      .. ""
      .. sep_hl
  end

  return result .. "%#TabLineFill#%T"
end

vim.o.showtabline = 2
vim.o.tabline = "%!v:lua.custom_tabline()"

-- LSP
vim.diagnostic.config({
  signs = false,
  virtual_text = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Editing
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.wrap = false
vim.o.linebreak = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Misc
vim.o.mouse = "a"
vim.o.splitright = true
vim.o.splitbelow = true

vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- Set system clipboard
local is_ssh = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil
if is_ssh then
  vim.g.clipboard = {
    name = 'osc52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end

local is_wsl = vim.fn.has("wsl") == 1
if is_wsl then
  local win32yank = "win32yank.exe"
  if vim.fn.executable(win32yank) == 1 then
    vim.g.clipboard = {
      name = "win32yank (WSL)",
      copy = {
        ["+"] = { win32yank, "-i", "--crlf"},
        ["*"] = { win32yank, "-i", "--crlf"},
      },
      paste = {
        ["+"] = { win32yank, "-o", "--lf"},
        ["*"] = { win32yank, "-o", "--lf"},
      },
      cache_enabled = 0,
    }
  end
end
