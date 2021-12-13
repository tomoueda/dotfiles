. "$HOME/.cargo/env"

# End of lines added by compinstall
alias v="vim"
alias st="git status"
alias br="git branch"

autoload -U colors && colors
PS1="%{$fg[magenta]%}% %1d$ %{$reset_color%}%"
export GEVENT_SUPPORT=True

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tomo.ueda/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tomo.ueda/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tomo.ueda/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tomo.ueda/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
path+=('/Users/tomo.ueda/GitChildBranchHelpers/bin')
export PATH
