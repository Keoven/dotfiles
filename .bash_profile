# PATH Additions
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/SDKs/android-sdk-mac_x86/tools
export PATH=$PATH:$HOME/SDKs/android-sdk-mac_x86/platform-tools

# Terminal Settings
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1="\e[1;30m\][\e[\e[1;30m\]\e[1;33m\] \u@\H \[\e[1;32m\]\w\[\e[0m\] \e[1;30m\]]\n[\[ \e[1;31m\]\T\[\e[0m\]\e[1;30m\] ] > \e[0;37m"
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

# NVM
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
if [[ -f "$PWD/.rvmrc" ]]; then
  . "$PWD/.rvmrc"
fi
