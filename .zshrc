HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

export PATH=~/.config/scripts:$PATH

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)
# ---- Eza (better ls) -----
eval "$(zoxide init --cmd cd zsh)"
# ---- Starship ----
eval "$(starship init zsh)"


# Aliases
alias ls="eza --icons=always"
alias l="ls -la"

alias nv="nvim"
alias nconfig="cd ~/.config/nvim"

if [ $OSTYPE = linux-gnu ]
then
  alias workspace='cd ~/../../mnt/c/Users/Tushya/Desktop/All\ Programs'
else
  alias workspace='cd ~/Desktop/Programs'
fi

alias n='newsboat'
alias jn='jupyter notebook'

alias smysql='brew services run mysql'
alias qmysql='brew services stop mysql'

alias c="clear"

alias enva="source venv/bin/activate"
alias envd="deactivate"

if [[ ! "$NVIM" ]]; then
  fastfetch -c ~/dotfiles/fastfetch_conf.jsonc
fi

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

