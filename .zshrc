# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="morph"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx ruby rvm brew bundler cap gem git-flow)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/Users/Driz/.rvm/gems/ruby-1.8.7-p330/bin:/Users/Driz/.rvm/gems/ruby-1.8.7-p330@global/bin:/Users/Driz/.rvm/rubies/ruby-1.8.7-p330/bin:/Users/Driz/.rvm/bin:/Users/Driz/.nvm/v0.4.7/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/sbin:/Users/Driz/SDKs/android-sdk-mac_x86/tools:/Users/Driz/SDKs/android-sdk-mac_x86/platform-tools
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PAGER=most

# Global Alias
alias rc="wrapped_redcar"
alias cheat="wrapped_cheat"
alias bcat="wrapped_bcat"
alias lunchy="wrapped_lunchy"
alias htty="wrapped_htty"
alias rush="wrapped_rush"
alias nginx-start="sudo nginx"
alias nginx-stop="sudo nginx -s stop"
alias nginx-restart="sudo nginx -s reload"
alias nginx-conf="sudo vim /usr/local/etc/nginx/nginx.conf"
alias hosts="sudo vim /etc/hosts"

# Project Alias
[[ -s "$HOME/.project_aliases" ]] && source "$HOME/.project_aliases"


# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
if [[ -f "$PWD/.rvmrc" ]]; then
  "$PWD/.rvmrc"
fi
