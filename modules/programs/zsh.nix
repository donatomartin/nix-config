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

        # Custom keybind to prepend sudo
        function prepend-sudo() {
          if [[ -n $BUFFER ]]; then
            BUFFER="sudo $BUFFER"
            CURSOR=$#BUFFER
          fi
        }
        zle -N prepend-sudo
        bindkey '^[^[' prepend-sudo  # ESC ESC

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
