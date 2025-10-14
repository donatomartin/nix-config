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

      # vim
      nv = "nvim";
      v = "vim";

      # list
      ls = "eza --icons --group-directories-first --color=always";
      l = "eza --icons --group-directories-first --color=always";
      la = "eza --icons --group-directories-first --color=always -a";
      ll = "eza --icons --group-directories-first --color=always -l";
      lla = "eza --icons --group-directories-first --color=always -la";
      lt = "eza --icons --group-directories-first --color=always --tree";

      # cat
      cat = "bat";

      # wayland
      wc = "wl-copy";
      wp = "wl-paste";

      # git
      g = "git";
      ga = "git add";
      gap = "git add -p";
      gA = "git add -A";
      gs = "git status";
      gd = "git diff";
      gds = "git diff --staged";
      gdh = "git diff HEAD";
      gc = "git commit";
      gcm = "git commit -m";
      gpsh = "git push";
      gpll = "git pull";
      gl = "git log --oneline --graph --decorate --all --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(auto)%h%d %s %C(brightblack)(%an, %ad) [%cd]'";
      gp = "wl-paste | git apply";

      # nix
      ns = "sudo nixos-rebuild switch --flake ~/nix-config";
      nt = "sudo nixos-rebuild test --flake ~/nix-config";
      ngc = "sudo nix-collect-garbage -d";
      ndg = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && nix-env --delete-generations old";

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

        setopt menucomplete
        setopt autolist

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
