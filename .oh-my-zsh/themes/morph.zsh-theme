#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell:
#   * One line.
#   * VCS info on the right prompt.
#   * Only shows the path on the left prompt by default.
#   * Crops the path to a defined length and only shows the path relative to
#     the current VCS repository root.
#   * Wears a different color wether the last command succeeded/failed.
#   * Shows user@hostname if connected through SSH.
#   * Shows if logged in as root or not.
# ------------------------------------------------------------------------------

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END=❯
PROMPT_ROOT_END=❯❯❯
PROMPT_SUCCESS_COLOR="%{$fg[green]%}"
PROMPT_FAILURE_COLOR="%{$fg[red]%}"
PROMPT_VCS_INFO_COLOR="%{$fg[gray]%}"

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r ❖ %b %u (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%r ❖ %b %u"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# Define prompts.

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚$FG[071] "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}✹$FG[071] "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖$FG[071] "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}➜$FG[071] "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}═$FG[071] "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}✭$FG[071] "

PROMPT="$PROMPT_SUCCESS_COLOR${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'☁ ${vcs_info_msg_0_%%.} $(git_prompt_status)'"%<<
%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} "
RPROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"
