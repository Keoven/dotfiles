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
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
alias gpg-restart="gpgconf --kill gpg-agent && gpgconf --launch gpg-agent"

export GOPATH=$HOME/Workspace
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/sbin
export PATH=$HOME/local/bin:$PATH
if [ -d "$HOME/Library/Python/2.7/bin" ]; then
    export PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/python:$PATH

if [ -s "/opt/homebrew/bin/brew" ]; then
  if brew ls --versions libpq > /dev/null; then
    export PATH=$(brew --prefix libpq)/bin:$PATH
  fi
fi

export NODE_PATH=/usr/local/lib/node_modules
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PAGER=less

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# export POWERLINE_DIRECTORY=$(pip show powerline-status | grep Location | cut -d " " -f 2)
export BUNDLER_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

# Global Alias
alias synergy-start="synergys -f --config ~/.synergy.conf"
alias serve-directory="ruby -r webrick -e \"s = WEBrick::HTTPServer.new(:Port => 9090, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start\""

alias hosts="sudo vim /etc/hosts"
alias git-clean='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

function docker-clean {
  docker system prune --all --force
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

# AWS
[[ -s "$HOME/.awsrc" ]] && source "$HOME/.awsrc"

# Python
# eval "$(pyenv init -)"
[[ -s "/usr/local/share/python/virtualenvwrapper.sh" ]] && source /usr/local/share/python/virtualenvwrapper.sh

# ASDF
[[ -s "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh" 

cd .;

# Homebrew
[[ -s "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup Prompt
autoload -U promptinit; promptinit
[[ -s "/opt/homebrew/bin/brew" ]] && fpath+=("$(brew --prefix)/share/zsh/site-functions")
prompt pure

[[ -s "$HOME/.asdf/asdf.sh" ]] && fpath=(${ASDF_DIR}/completions $fpath) 
autoload -Uz compinit && compinit
[[ -s "$HOME/.asdf/asdf.sh" ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[[ -s "$HOME/.credentials/credentials.sh" ]] && source "$HOME/.credentials/credentials.sh" 

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# mise
if [ -f "$HOME/.local/bin/mise" ]; then eval "$($HOME/.local/bin/mise activate zsh)"; fi

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
export PATH="$HOME/.local/bin:$PATH"

# Tools
function enable-press-and-hold() {
    # Check if the first argument is missing
    if [ -z "$1" ]; then
        echo "Error: Missing application identifier."
        echo "Usage: enable-press-and-hold <bundle-id|app-name>"
        echo "Example: enable-press-and-hold com.microsoft.VSCode"
        return 1
    fi

    # Execute the defaults command
    defaults write -app "$1" ApplePressAndHoldEnabled -bool false

    echo "Press-and-hold disabled (Key Repeat enabled) for: $1"
}

# ClaudeCode
## Vertex Config
# export CLAUDE_CODE_USE_VERTEX=1
# export CLOUD_ML_REGION=us-east5
# export ANTHROPIC_VERTEX_PROJECT_ID={GCP_PROJECT_ID}

## Bifrost Config
export ANTHROPIC_BASE_URL=http://localhost:8080/anthropic
export ANTHROPIC_API_KEY=dummy-key

# LLM functions to execute the various tools
function bifrost() {
    npx -y @maximhq/bifrost "$@"
}

function claude-opus() {
    claude --model vertex/claude-opus-4-6
}

function claude-gemini-2-5-flash() {
    claude --model vertex/gemini-2.5-flash
}

function claude-sonnet-4-5() {
    if [[ -n "$1" ]]; then
        claude --model vertex/claude-sonnet-4-5 $1
    else
        claude --model vertex/claude-sonnet-4-5 
    fi
}

function claude-haiku() {
    claude --model vertex/claude-haiku-4-5@20251001
}

function claude-gemini-2-5-pro() {
    if [[ -n "$1" ]]; then
        claude --model vertex/gemini-2.5-pro $1
    else
        claude --model vertex/gemini-2.5-pro
    fi
}

function claude-gemini-3-1-pro-preview() {
    if [[ -n "$1" ]]; then
        claude --model vertex/gemini-3.1-pro-preview $1
    else
        claude --model vertex/gemini-3.1-pro-preview
    fi
}

function claude-gemini-3-pro-preview() {
    if [[ -n "$1" ]]; then
        claude --model vertex/gemini-3-pro-preview $1
    else
        claude --model vertex/gemini-3-pro-preview
    fi
}

function claude-gemini-3-1-flash-lite-preview() {
    if [[ -n "$1" ]]; then
        claude --model vertex/gemini-3.1-flash-lite-preview $1
    else
        claude --model vertex/gemini-3.1-flash-lite-preview
    fi
}

function claude-gemini-3-flash-preview() {
    if [[ -n "$1" ]]; then
        claude --model vertex/gemini-3-flash-preview $1
    else
        claude --model vertex/gemini-3-flash-preview
    fi
}
