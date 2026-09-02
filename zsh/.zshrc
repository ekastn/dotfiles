
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:/usr/local/go/bin:$PATH

# Completion: substring + case-insensitive matching (was provided by oh-my-zsh)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$HOME/.cache/zsh"

# up/down-arrow history, completion (was provided by oh-my-zsh)
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# word navigation (was provided by oh-my-zsh)
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[3;5~' kill-word

# alt+backspace deletes a word (only emacs-mode default; viins has none)
bindkey '^[^?' backward-kill-word
bindkey '^[^H' backward-kill-word

# history persistence (was provided by oh-my-zsh)
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

set -o vi

source ~/.zsh_profile
source ~/.zsh_personal

autoload -U compinit
compinit -i

source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(task --completion zsh)"
eval "$(zoxide init zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
