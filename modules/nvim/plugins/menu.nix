{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.alpha-nvim ];
  extraConfigLua = ''
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = { "Donato Martín's NixVim" }
    dashboard.section.buttons.val = {
      dashboard.button("z", "  Open Tmux Project", "<cmd>Telescope zoxide list<CR>"),
      dashboard.button("f", "  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
    }
    dashboard.section.footer.val = { "" }
    dashboard.config.layout = {
      { type = "padding", val = math.floor(vim.o.lines * 0.3) }, -- vertical centering
      {
        type = "group",
        val = {
          dashboard.section.header,
          { type = "padding", val = 1 },
          dashboard.section.buttons,
          { type = "padding", val = 1 },
          dashboard.section.footer,
        },
        opts = { position = "center" }, -- horizontal centering
      },
    }

    alpha.setup(dashboard.config)
  '';
}
