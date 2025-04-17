{
  config,
  pkgs,
  ...
}: let
  catppuccinMocha = {
    bg0 = "#1E1E2E";
    bg1 = "#1D1D2C";
    bg2 = "#191928";
    fg = "#CDD6F4";
    blue = "#89B4FA";
    green = "#A6E3A1";
    yellow = "#F9E2AF";
    red = "#F38BA8";
    grey = "#A6ADC8";
  };
in {
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "xterm-256color";

    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";

    extraConfig = ''

      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g renumber-windows on

      # Copy mode bindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Pane navigation (vim style)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Pane borders
      set-option -g pane-active-border-style "fg=${catppuccinMocha.blue}"
      set-option -g pane-border-style "fg=${catppuccinMocha.bg2}"

      # Swap panes with Ctrl + arrow
      bind -n C-Up swap-pane -U
      bind -n C-Down swap-pane -D

      # Start copy mode with C-b v
      unbind [
      bind v copy-mode

      # Window navigation
      bind -n S-Left  previous-window
      bind -n S-Right next-window
      bind -n M-H previous-window
      bind -n M-L next-window

      # New panes inherit current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      ###### STATUS BAR ######
      set -g status on
      set -g status-position top
      set-option -g status-style "bg=${catppuccinMocha.bg0},fg=${catppuccinMocha.fg}"

      set -g status-left " #[bg=${catppuccinMocha.bg0},fg=${catppuccinMocha.blue}]#[bg=${catppuccinMocha.blue},fg=${catppuccinMocha.bg0},bold] 󱄅 #S #[fg=${catppuccinMocha.blue},bg=${catppuccinMocha.bg0},nobold]"

      set-window-option -g window-status-format "#[fg=${catppuccinMocha.grey},bg=${catppuccinMocha.bg0}] #I:#W "
      set-window-option -g window-status-current-format "#[fg=${catppuccinMocha.bg0},bg=${catppuccinMocha.fg}]#[fg=${catppuccinMocha.bg0},bg=${catppuccinMocha.fg},bold] #I:#W #[fg=${catppuccinMocha.fg},bg=${catppuccinMocha.bg0}]"
      set-window-option -g window-status-current-style bg=${catppuccinMocha.blue},fg=${catppuccinMocha.bg0}
      set-window-option -g window-status-style bg=${catppuccinMocha.bg0},fg=${catppuccinMocha.grey}

      set -g status-right "#[fg=${catppuccinMocha.green},bg=${catppuccinMocha.bg0}]#[fg=${catppuccinMocha.bg0},bg=${catppuccinMocha.green},bold]  %H:%M#[fg=${catppuccinMocha.green}]#[fg=${catppuccinMocha.bg0},bg=${catppuccinMocha.yellow},bold] %Y-%m-%d#[fg=${catppuccinMocha.yellow}]#[fg=${catppuccinMocha.bg0},bg=${catppuccinMocha.red},bold] 󰂄 #(acpi -b | awk '{print $4}' | tr -d ',')#[fg=${catppuccinMocha.red}]"
    '';

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.sensible;
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
  };
}
