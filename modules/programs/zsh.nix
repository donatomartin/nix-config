{ pkgs, ... }:
{
  home.packages = [
    pkgs.eza
    pkgs.zsh-fzf-tab
    pkgs.oscclip
  ];

  programs.zsh = {
    enable = true;
    shellAliases.copy = "osc-copy";
    shellAliases.paste = "osc-paste";
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = {

      # system
      c = "clear";

      # nix
      hs = "home-manager switch --flake ~/nix-config";
      ns = "sudo nixos-rebuild switch --flake ~/nix-config";

      # vim
      vim = "nvim";
      nv = "nvim";
      vi = "nvim";
      v = "nvim";

      # list
      ls = "eza --icons --group-directories-first --color=always";
      l = "eza --icons --group-directories-first --color=always";
      la = "eza --icons --group-directories-first --color=always -a";
      ll = "eza --icons --group-directories-first --color=always -l";
      lla = "eza --icons --group-directories-first --color=always -la";
      lt = "eza --icons --group-directories-first --color=always --tree";

      # cat
      cat = "bat --style=plain --color=always";

      # wayland
      wc = "wl-copy";
      wp = "wl-paste";

      # git
      g = "git";
      ga = "git add";
      gA = "git add -A";
      gs = "git status";
      gd = "git diff";
      gc = "git commit";
      gcm = "git commit -m";
      gpsh = "git push";
      gl = "git log --oneline --graph --decorate --all";
      gcl = "git clone";
      gp = "wl-paste | git apply";

      # tmux
      t = "tmux";
      ta = "tmux a";

      # direnv
      da = "direnv allow";

      # dotenvx
      dx = "dotenvx";
      e = "dotenvx run --";
    };

    initContent =
      # sh
      ''
        # Enable vi mode
        bindkey -v

        # --- vi yank -> system clipboard via OSC52 (works over SSH/tmux) ---
        _clip() {
          # If inside tmux, use passthrough so the outer terminal receives OSC52
          if [[ -n "$TMUX" ]]; then
            printf '\ePtmux;\e\e]52;c;%s\a\e\\' "$(printf %s "$1" | base64 | tr -d '\n')"
          else
            printf '\e]52;c;%s\a' "$(printf %s "$1" | base64 | tr -d '\n')"
          fi
        }

        vi_yank_and_clip() { zle vi-yank; _clip "$CUTBUFFER"; }
        zle -N vi_yank_and_clip
        bindkey -M vicmd 'y'  vi_yank_and_clip
        bindkey -M vicmd 'Y'  vi_yank_and_clip
        bindkey -M vicmd 'yy' vi_yank_and_clip

        # zsh completion setup
        autoload -U compinit && compinit
        zmodload -i zsh/complist

        # Use fzf-tab from nixpkgs
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

        # Optional: some basic config
        zstyle ':completion:*' menu select
      '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

}
