{ pkgs, ... }:
{

  imports = [
    ./neo-tree.nix
    ./telescope.nix
    ./flash.nix
    ./persistence.nix
    ./conform.nix
    ./undotree.nix
    ./treesitter.nix
    ./mini.nix
    ./neoclip.nix
    ./noice.nix
    ./vimux.nix
  ];

  programs.nixvim = {
    colorschemes.catppuccin.enable = true;

    plugins = {

      lz-n.enable = true; # Lazy Loading
      web-devicons.enable = true; # Icons
      nvim-autopairs.enable = true; # Autopairing
      nvim-surround.enable = true; # Surround
      which-key.enable = true; # Bind hints
      flash.enable = true; # Move fast
      tmux-navigator.enable = true; # Tmux integration
      markview.enable = true; # Markdown viewer
      lualine.enable = true; # Nicer bar
      gitblame.enable = true; # See inline git blames

      colorizer = {
        enable = true;
        settings.user_default_options.names = false;
      };

      oil = {
        enable = true;
        lazyLoad.settings.cmd = "Oil";
      };

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "neo-tree"
            "TelescopePrompt"
          ];
        };
      };

    };
  };
}
