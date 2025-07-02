{ pkgs, ... }:
{
  home.packages = [
    pkgs.eza
    pkgs.zsh-fzf-tab
  ];

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = {
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
    };

    initContent = ''
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

      # extract function for archive files
      extract() {
        if [ -f "$1" ]; then
          case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.tar.xz)    tar xJf "$1"   ;;
            *.tar.zst)   unzstd -c "$1" | tar xf - ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.xz)        unxz "$1"      ;;
            *.zst)       unzstd "$1"    ;;
            *.7z)        7z x "$1"      ;;
            *)           echo "'$1': unrecognized file extension" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }

      # loadenv function to load environment variables from a file
      loadenv() {
        if [ -f "$1" ]; then
          set -a
          source "$1"
          set +a
          echo "Environment variables loaded from $1"
        else
          echo "'$1' is not a valid file"
        fi
      }

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
}
