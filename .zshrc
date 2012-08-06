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
plugins=()

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/sbin
export PATH=$HOME/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=/usr/local/Cellar/ruby/1.9.3-p125/bin:$PATH
export NODE_PATH=/usr/local/lib/node_modules
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PAGER=less
export CC=gcc-4.2
export BUNDLER_EDITOR=mvim

# Global Alias
alias cheat="wrapped_cheat"
alias bcat="wrapped_bcat"
alias synergy-start="synergys -f --config ~/.synergy.conf"
alias gdoc="gem server"

alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'

#alias foreman="wrapped_foreman"
#alias lunchy="wrapped_lunchy"
#alias htty="wrapped_htty"
#alias nginx-start="sudo nginx"
#alias nginx-stop="sudo nginx -s stop"
#alias nginx-restart="sudo nginx -s reload"
#alias nginx-conf="sudo vim /usr/local/etc/nginx/nginx.conf"
#alias hosts="sudo vim /etc/hosts"

function redis-reset {
  redis-cli keys  "*" | while read LINE ; do TTL=$(redis-cli ttl $LINE); if [ $TTL -eq -1 ]; then echo "Del $LINE"; RES=$(redis-cli del $LINE); fi; done;
}

function alert-on-finish {
  if [ "$?" -eq "0" ]
  then
    say -v Trinoid “Task Done”
  else
    say -v Trinoid “Task Error”
  fi
}

# Project Alias
[[ -s "$HOME/.project_aliases" ]] && source "$HOME/.project_aliases"

# NVM
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"

# RVM
unsetopt auto_name_dirs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
__rvm_project_rvmrc

#echo "Last OSS Commit: $(curl -s "http://calendaraboutnothing.com/~keoven.json" | sed -E 's/.*"(.*)"].*/\1/')"
[[ -s "/usr/local/share/python/virtualenvwrapper.sh" ]] && source /usr/local/share/python/virtualenvwrapper.sh

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
