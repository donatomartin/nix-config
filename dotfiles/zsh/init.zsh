# Start profiling
# zmodload zsh/zprof

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export EDITOR=nvim
export PATH="$HOME/bin:$PATH"

setopt autocd
setopt NO_BEEP
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

source ~/.config/zsh/antidote.zsh
source ~/.config/zsh/vi.zsh
source ~/.config/zsh/fzf.zsh
source ~/.config/zsh/aliases.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Machine specific gitignored aliases
if [ -s "$HOME/.config/zsh/aliases.local.zsh" ]; then
  source ~/.config/zsh/aliases.local.zsh
fi

# Machine specific gitignored config
if [ -s "$HOME/.config/zsh/config.local.zsh" ]; then
  source ~/.config/zsh/config.local.zsh
fi

# Stop profiling
# zprof
