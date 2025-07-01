{
  pkgs,
  ...
}:
let
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
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "xterm-256color";

    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";

    extraConfig = ''
      set -s escape-time 10 
      set-option -g renumber-windows on

      # Copy mode bindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Swap panes with Ctrl+b + H/L 
      bind H swap-pane -U
      bind L swap-pane -D

      # Pane borders
      set-option -g pane-active-border-style "fg=${catppuccinMocha.blue}"
      set-option -g pane-border-style "fg=${catppuccinMocha.bg2}"

      # Start copy mode with C-b v
      unbind [
      bind v copy-mode

      # Window navigation
      bind -n S-Left  previous-window
      bind -n S-Right next-window
      bind -n M-H previous-window
      bind -n M-L next-window

      # Resize panes with Alt + h/j/k/l
      bind -n M-h resize-pane -L 5
      bind -n M-j resize-pane -D 5
      bind -n M-k resize-pane -U 5
      bind -n M-l resize-pane -R 5

      # New panes inherit current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      ###### STATUS BAR ######
      set -g status on
      set -g status-position top
      set-option -g status-style "bg=${catppuccinMocha.bg0},fg=${catppuccinMocha.fg}"

      set -g status-left " #[bg=${catppuccinMocha.bg0},fg=${catppuccinMocha.blue}]#[bg=${catppuccinMocha.blue},fg=${catppuccinMocha.bg0},bold] 󱄅 #S #[fg=${catppuccinMocha.blue},bg=${catppuccinMocha.bg0},nobold]"

      set-window-option -g window-status-format "#[fg=${catppuccinMocha.grey},bg=${catppuccinMocha.bg0}]   #I:#W  "
      set-window-option -g window-status-style bg=${catppuccinMocha.bg0},fg=${catppuccinMocha.grey}
      set-window-option -g window-status-current-format "#[fg=${catppuccinMocha.fg},bg=${catppuccinMocha.bg0}] #[fg=${catppuccinMocha.bg0},bg=${catppuccinMocha.fg},bold] #I:#W #[fg=${catppuccinMocha.fg},bg=${catppuccinMocha.bg0}]"
      set-window-option -g window-status-current-style bg=${catppuccinMocha.blue},fg=${catppuccinMocha.bg0}

      set -g status-right ""
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
