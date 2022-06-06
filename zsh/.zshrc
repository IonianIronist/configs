export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

export NVM_LAZY_LOAD=true

plugins=(git zsh-nvm)

source $ZSH/oh-my-zsh.sh
export PATH=$PATH:~/.local/bin/
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

alias c="clear"
alias celar="clear"
alias vim="nvim"
alias cat="bat"
