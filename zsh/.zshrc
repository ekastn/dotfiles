# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:/usr/local/go/bin:$PATH

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git nix-shell)

source $ZSH/oh-my-zsh.sh

set -o vi

autoload -U compinit
compinit -i

source <(fzf --zsh)
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(task --completion zsh)"
eval "$(zoxide init zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
autoload -Uz compinit && compinit -C

source ~/.zsh_profile
source ~/.zsh_personal
