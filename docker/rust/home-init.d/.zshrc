echo -n "\033]0;${USER}@${HOST}\007"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="alanpeabody"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(ant bundler coffee gem git gradle knife rails rails3 rake rvm svn vim mvn pip python)
#plugins=(ant bower bundler colored-man command-not-found coffee gem git git-extras git-flow git-flow-avh gradle rake svn vim mvn npm pip python ruby rvm sbt)

setopt append_history
unsetopt share_history

source $ZSH/oh-my-zsh.sh

. ~/.profile
#[[ -s "/usr/local/rvm/scripts/rvm" ]] && . "/usr/local/rvm/scripts/rvm" # This loads RVM into a shell session.

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#PATH=$PATH:/usr/local/rvm/bin # Add RVM to PATH for scripting

