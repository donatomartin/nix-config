{ pkgs, ... }:

{
  home.packages = [
    pkgs.powerline
    pkgs.zsh-powerlevel10k
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
      l = "ls";
      la = "ls -a";
      ll = "ls -l";
      lla = "ls -la";

      # wayland
      wc = "wl-copy";
      wp = "wl-paste";

      # git
      g = "git";
      ga = "git add";
      gaa = "git add -A";
      gs = "git status";
      gd = "git diff";
      gc = "git commit";
      gl = "git log --oneline --graph --decorate --all";
      gcl = "git clone";

    };

    initContent = ''
      # Enable vi mode
      bindkey -v

      # Powerlevel10k setup
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Optional: source user config (p10k will prompt to create this on first launch)
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

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
    '';
  };

  home.file.".p10k.zsh".source = ./.p10k.zsh;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

}
