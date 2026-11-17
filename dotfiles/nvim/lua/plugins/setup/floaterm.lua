require("floaterm").setup(
  {
    mappings = {
      term = function(buf)
        vim.keymap.set({ "n", "t" }, "<M-p>", function()
          require("floaterm.api").cycle_term_bufs "prev"
        end, { buffer = buf })
        vim.keymap.set({ "n", "t" }, "<M-n>", function()
          require("floaterm.api").cycle_term_bufs "next"
        end, { buffer = buf })
        vim.keymap.set({ "n", "t" }, "<M-k>", function()
          require("floaterm.api").cycle_term_bufs "prev"
        end, { buffer = buf })
        vim.keymap.set({ "n", "t" }, "<M-j>", function()
          require("floaterm.api").cycle_term_bufs "next"
        end, { buffer = buf })
        vim.keymap.set({ "n", "t" }, "<M-a>", function()
          require("floaterm.api").new_term()
        end, { buffer = buf })
        vim.keymap.set({ "n", "t" }, "<M-e>", function()
          require("floaterm.api").edit_name(true)
        end, { buffer = buf })
        vim.keymap.set({ "n", "t" }, "<M-u>", function()
          require("floaterm.api").toggle_fullscreen()
        end, { buffer = buf })
        vim.keymap.set({ "n", "t" }, "<M-d>", function()
          require("floaterm.api").delete_term(require("floaterm.state").buf)
        end, { buffer = buf })
        vim.keymap.set({ "n" }, "<esc>", function()
          require("floaterm").toggle()
        end, { buffer = buf })
      end,
      sidebar = function(buf)
        vim.keymap.set({ "n" }, "<esc>", function()
          require("floaterm").toggle()
        end, { buffer = buf })
      end
    },
  }
)

require("utils").enableMappings({
  { "<M-i>", require("floaterm").toggle, desc = "Toggle floaterm", mode = { "n", "v", "t" } }
})
