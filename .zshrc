export ZLE_RPROMPT_INDENT=0

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
export GOPATH=$HOME/Workspace
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/sbin
export PATH=$HOME/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=/usr/local/Cellar/ruby/1.9.3-p125/bin:$PATH
export NODE_PATH=/usr/local/lib/node_modules
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PAGER=less

if [ -s "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Setup GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
alias gpg-restart="gpgconf --kill gpg-agent && gpgconf --launch gpg-agent"

export CC=gcc

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export BUNDLER_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

# Global Alias
alias serve-directory="ruby -r webrick -e \"s = WEBrick::HTTPServer.new(:Port => 9090, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start\""
alias gpg-restart="gpgconf --kill gpg-agent && gpgconf --launch gpg-agent"
alias hosts="sudo vim /etc/hosts"
alias git-clean='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'
alias pyc-clean="sudo find . -name '*.pyc' -delete"
alias redis-start='redis-server /home/linuxbrew/.linuxbrew/etc/redis.conf --daemonize yes'
alias redis-stop='redis-cli shutdown'
alias pg-start='sudo -u postgres pg_ctlcluster 10 main start'
alias pg-stop='sudo -u postgres pg_ctlcluster 10 main stop'
alias pg-user='sudo -i -u postgres'
alias go='grc go'
alias make='grc make'

function docker-clean {
  docker rmi $(docker images -f dangling=true -q)
  docker rm $(docker ps -a -f status=exited -q)
  docker volume rm $(docker volume ls -f dangling=true -q)
}

function docker-run {
  container_name=$1
  image=$2
  env_file=$3

  if [ -z "$container_name" ] || [ -z $image ] || [ -z $env_file ]
  then
    echo "Missing arguements!"
    echo "Example usage: docker-run container_name image path/to/env.list"
    echo
    echo "env.list should contain the following:"
    echo
    echo "ENVIRONMENT_VARIABLE=XXX"
    echo
    return 1
  fi

  echo
  echo "Container Name: $container_name"
  echo "Image: $image"
  echo "Environment File: $env_file"
  echo "================================================================="
  echo "docker run -d --rm \
    --security-opt=seccomp:unconfined \
    --name $container_name \
    --env-file $env_file \
    -v $(pwd):/app \
    $image tail -f /dev/null
  "
  echo

  docker run -d --rm \
    --security-opt=seccomp:unconfined \
    --name $container_name \
    --env-file $env_file \
    -v $(pwd):/app \
    $image tail -f /dev/null
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

alias fix-term="stty sane"

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export EDITOR=vim
export SHELL=zsh

# Project Alias
[[ -s "$HOME/.project_aliases" ]] && source "$HOME/.project_aliases"


# ASDF
[[ -s "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh" 

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
cd .;

# ZSH Completions
fpath=(/home/linuxbrew/.linuxbrew/share/zsh-completions $fpath)
fpath+=('$HOME/.nvm/versions/node/v10.16.0/lib/node_modules/pure-prompt/functions')
