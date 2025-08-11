{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.alpha-nvim ];
  extraConfigLua = ''
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = { "" }
    dashboard.section.buttons.val = {
      dashboard.button("p", "  Open Tmux Project", ":silent !tmux-sessionizer<CR>"),
    }
    dashboard.section.footer.val = { "" }
    dashboard.config.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 1 },
      dashboard.section.buttons,
    }

    alpha.setup(dashboard.config)
  '';
}
