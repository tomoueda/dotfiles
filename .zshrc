. "$HOME/.cargo/env"

# End of lines added by compinstall
alias v="vim"
alias st="git status"
alias br="git branch"

autoload -U colors && colors
PS1="%{$fg[cyan]%}% %1d$ %{$reset_color%}%"
export GEVENT_SUPPORT=True

HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/histfile
HISTSIZE=10000
SAVEHIST=10000

setopt append_history # Append history, don't overwrite file
setopt share_history # Allow all terminal sessions to share the history
# setopt inc_append_history # Immediately append to history, i.e. don't wait for term to close
setopt hist_expire_dups_first # Remove non unique lines first when trimming history
setopt hist_ignore_space # Don't keep space led commands
#compdef clyde
_clyde() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _CLYDE_COMPLETE=complete-zsh  clyde)
}
if [[ "$(basename -- ${(%):-%x})" != "_clyde" ]]; then
  compdef _clyde clyde
fi
