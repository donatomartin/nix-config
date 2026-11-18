###system
alias c="clear"

###vim
alias nv="nvim";
alias v="nvim";
alias vim="nvim";

###tmux
alias t="tmux"
alias ta="tmux a"

###git
alias g="git"
alias ga="git add"
alias gf="git fetch --all --prune"
alias gA="git add -A"
alias gs="git status"
alias gcm="git commit -m"
alias gc="git commit"
alias gd="git diff"
alias gds="git diff --staged"
alias gdh="git diff HEAD"
alias gl="git log --oneline --graph --decorate"
alias gla="git log --oneline --graph --decorate --all --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(auto)%h%d %s %C(brightblack)(%an, %ad) [%cd]'"
alias gpsh="git push"
alias gsw="git switch"

###list
alias l="eza --group-directories-first"
alias ll="eza -l --group-directories-first"
alias lo="eza --oneline --group-directories-first"
alias lt="eza --tree"
alias la="eza -a"
alias lla="eza -la --group-directories-first"

###nix
alias ns="sudo nixos-rebuild switch --flake ~/nix-config"
alias nt="ALLOW_DIRTY=1 sudo -E nixos-rebuild test --impure --flake ~/nix-config"
alias ngc="sudo nix-collect-garbage -d"
alias ndg="sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && nix-env --delete-generations old"

###other
alias neofetch="fastfetch"
alias oc="opencode"
alias ocs="opencode service status"
