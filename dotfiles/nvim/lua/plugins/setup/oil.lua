local oil = require("oil")

oil.setup({
  lsp_file_methods = {
    timeout_ms = 2000,
    autosave_changes = false,
  },
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,

  view_options = {
    show_hidden = true,
    natural_order = true,

    is_always_hidden = function(name, _)
      return name == ".git" or name == ".."
    end,
  },

  keymaps = {
    ["+"] = "actions.select",

    ["q"] = "actions.close",
    ["<leader>e"] = "actions.close",
    ["<leader>o"] = "actions.close",

    ["<C-l>"] = false,
    ["<C-h>"] = false,
    ["<C-t>"] = false,
    ["<C-p>"] = false,

    ["<C-r>"] = "actions.refresh",
    ["<M-h>"] = "actions.toggle_hidden",
    ["<M-t>"] = "actions.toggle_trash",
  },

  win_options = {
    wrap = false,
    signcolumn = "yes",
    cursorcolumn = true,
  },
})

require("utils").enableMappings({
  {
    "<leader>oo",
    function()
      oil.open()
    end,
    desc = "Oil Open",
  },
})

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(args)
    if args.data.err then
      return
    end

    for _, action in ipairs(args.data.actions) do
      if action.type == "move" then
        local old_path = action.src_url:match("^oil://(.*)$")

        if old_path then
          vim.defer_fn(function()
            local bufnr = vim.fn.bufnr(old_path)

            if bufnr ~= -1 and vim.api.nvim_buf_is_valid(bufnr) then
              vim.api.nvim_buf_delete(bufnr, { force = true })
            end
          end, 2000)
        end
      end
    end
  end,
})
