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

# Setup GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export LC_CTYPE=en_US.UTF-8 # For Cucumber Gherkin/JSON Compatibility Fix
# https://github.com/cucumber/gherkin/issues/192

if [ -e /proc/version ]
then # Linux
  export CC=gcc-4.8
else # Windows
  export CC=gcc-4.2
fi

export BUNDLER_EDITOR=mvim

export VISUAL=vim
export EDITOR=vim

# Global Alias
alias cheat="wrapped_cheat"
alias bcat="wrapped_bcat"
alias synergy-start="synergys -f --config ~/.synergy.conf"
alias gdoc="gem server"
alias serve-directory="ruby -r webrick -e \"s = WEBrick::HTTPServer.new(:Port => 9090, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start\""

case "$OSTYPE" in
  linux*)
    alias open="xdg-open"
    alias dark-terminal=". ~/.gnome-terminal-colors-solarized/set_dark.sh"
    alias light-terminal=". ~/.gnome-terminal-colors-solarized/set_light.sh" ;;
  darwin*)
    alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc' ;;
esac

alias hosts="sudo vim /etc/hosts"
alias git-clean='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

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

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export EDITOR=vim
export SHELL=zsh

# Project Alias
[[ -s "$HOME/.project_aliases" ]] && source "$HOME/.project_aliases"

# NVM
export NVM_DIR=$HOME/.nvm
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"

#echo "Last OSS Commit: $(curl -s "http://calendaraboutnothing.com/~keoven.json" | sed -E 's/.*"(.*)"].*/\1/')"
[[ -s "/usr/local/share/python/virtualenvwrapper.sh" ]] && source /usr/local/share/python/virtualenvwrapper.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# RVM
#unsetopt auto_name_dirs
#__rvm_project_rvmrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# startup virtualenv-burrito
if [ -f $HOME/.venvburrito/startup.sh ]; then
    . $HOME/.venvburrito/startup.sh
fi

if [ -e "$(which fasd)" ]; then
  fasd_cache="$HOME/.fasd-init-bash"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
cd .;
