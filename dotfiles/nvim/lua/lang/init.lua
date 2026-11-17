local M = {}

local function getLspMap()
  return require("lang.lspmap")
end

local function processMapByType(property)
  local t = {}
  for _, value in pairs(getLspMap()) do
    local element = value[property]

    -- in case the element is an array
    if type(element) == "table" then
      for _, innerValue in pairs(element) do
        t[#t + 1] = innerValue
      end
    else
      t[#t + 1] = element
    end
  end
  return t
end

function M.getCustomLspConfigs()
  return processMapByType("config")
end

function M.getDeclaredMasonPackages()
  return processMapByType("package")
end

function M.on_attach(_, bufnr)
  require("utils").enableMappings({
    { "<C-s>",      vim.lsp.buf.signature_help,                         buffer = bufnr, mode = "n" },
    { "K",          vim.lsp.buf.hover,                                  buffer = bufnr, mode = "n" },
    { "<leader>rn", vim.lsp.buf.rename,                                 buffer = bufnr, mode = "n" },
    { "<leader>ca", vim.lsp.buf.code_action,                            buffer = bufnr, mode = { "n", "x" } },
    { "<leader>cd", vim.diagnostic.open_float,                          buffer = bufnr, mode = "n" },
    { "<leader>cw", vim.lsp.buf.workspace_diagnostics,                  buffer = bufnr, mode = "n" },
    { "<leader>cl", vim.diagnostic.setloclist,                          buffer = bufnr, mode = "n" },
    { "<leader>lf", vim.lsp.buf.format,                                 buffer = bufnr, mode = "n" },
    { "<leader>cn", function() vim.diagnostic.jump({ count = 1 }) end,  buffer = bufnr, mode = "n" },
    { "<leader>cp", function() vim.diagnostic.jump({ count = -1 }) end, buffer = bufnr, mode = "n" },
    {
      "<leader>yd",
      function()
        local diag = vim.diagnostic.get(0, {
          lnum = vim.fn.line(".") - 1,
        })[1]

        if diag then
          vim.fn.setreg("+", diag.message)
        end
      end,
      desc = "Yank cursor diagnostics",
      buffer = bufnr,
      mode = "n",
    },
    {
      "<leader>yD",
      function()
        local diags = vim.diagnostic.get(0, {
          lnum = vim.fn.line(".") - 1,
        })

        if #diags == 0 then
          return
        end

        local text = table.concat(
          vim.tbl_map(function(d)
            return d.message
          end, diags),
          "\n"
        )

        vim.fn.setreg("+", text)
      end,
      desc = "Yank line diagnostics",
      buffer = bufnr,
      mode = "n",
    },
  })
end

function M.start()
  require("lang.lspconfigs").config(M.on_attach)
  vim.lsp.enable(M.getCustomLspConfigs())
end

return M
