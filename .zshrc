export ZLE_RPROMPT_INDENT=0

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

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
export GOPATH=$HOME/Workspace
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/sbin
export PATH=$HOME/local/bin:$PATH
if [ -d "$HOME/Library/Python/2.7/bin" ]; then
    export PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=/usr/local/Cellar/ruby/1.9.3-p125/bin:$PATH
export NODE_PATH=/usr/local/lib/node_modules
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PAGER=less

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export BUNDLER_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

# Global Alias
alias cheat="wrapped_cheat"
alias bcat="wrapped_bcat"
alias synergy-start="synergys -f --config ~/.synergy.conf"
alias gdoc="gem server"
alias serve-directory="ruby -r webrick -e \"s = WEBrick::HTTPServer.new(:Port => 9090, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start\""

alias hosts="sudo vim /etc/hosts"
alias git-clean='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

function docker-clean {
  docker rmi $(docker images -f dangling=true -q)
  docker rm $(docker ps -a -f status=exited -q)
  docker volume rm $(docker volume ls -f dangling=true -q)
}

# Database Aliases and Functions
alias psql-start="pg_ctl -D /usr/local/var/postgres start"
alias redis-start="redis-server /usr/local/etc/redis.conf --daemonize yes"
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
export NVM_DIR=$HOME/.nvm
[[ -s "/usr/local/opt/nvm/nvm.sh" ]] && source "/usr/local/opt/nvm/nvm.sh"

eval "$(pyenv init -)"
[[ -s "/usr/local/share/python/virtualenvwrapper.sh" ]] && source /usr/local/share/python/virtualenvwrapper.sh


# RVM
#unsetopt auto_name_dirs
#__rvm_project_rvmrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
cd .;

# Setup Prompt
autoload -U promptinit; promptinit
prompt pure
