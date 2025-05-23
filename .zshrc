# Aliases - Source as many as possible from ~/.aliases, add here *only* those that are specific to Zsh
source ~/.aliases

# Command history: https://unix.stackexchange.com/questions/389881/history-isnt-preserved-in-zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME

# Quick directory navigation: https://opensource.com/article/18/9/tips-productivity-zsh
setopt autocd autopushd pushdignoredups

# Notify status of background jobs immediately
setopt notify

# Vim command line editing
bindkey -v

# Enable Zsh completions, including advanced tab completion
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

# Enable menu-highlighting when tab through possible completions/options
zstyle ':completion:*' menu select

# Use pure-prompt: https://github.com/sindresorhus/pure#getting-started
autoload -U promptinit
promptinit
prompt pure

# Show git stash status
zstyle :prompt:pure:git:stash show yes

# colorls tab completion for flags: https://github.com/athityakumar/colorls#installation
source $(dirname $(gem which colorls))/tab_complete.sh

# Allow the use of the z plugin to easily navigate directories
source /opt/homebrew/etc/profile.d/z.sh

# Zsh auto-suggestions: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zsh syntax highlighting: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
