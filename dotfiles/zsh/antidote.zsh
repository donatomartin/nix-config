ANTIDOTE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"

if [[ ! -f "$ANTIDOTE_HOME/antidote.zsh" ]]; then
  git clone --depth=1 \
    https://github.com/mattmc3/antidote.git \
    "$ANTIDOTE_HOME"
fi

source "$ANTIDOTE_HOME/antidote.zsh"
antidote load ~/.config/zsh/zsh_plugins.txt
