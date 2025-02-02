typeset -A __PJL
__PJL[ITALIC_ON]=$'\e[3m'
__PJL[ITALIC_OFF]=$'\e[23m'

setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:*' formats '%F{08}[%b%m%c%u%F{08}]'
zstyle ':vcs_info:*' stagedstr "%F{green}•" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{yellow}•" # default 'U'
zstyle ':vcs_info:git*:*' actionformats '%F{08}[%b|%F{yellow}%a%F{08}]'
zstyle ':vcs_info:git+set-message:*' hooks git-untracked

function +vi-git-untracked() {
emulate -L zsh
if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
  hook_com[unstaged]+="%F{red}•%f"
fi
}

function rprompt_path() {
  local last_dir="/${PWD##*/}"
  local rpath="${PWD%$last_dir}"
  local rdir="${rpath/$HOME/~}"
  echo ${rdir}
}

function shell_level() {
  local level_char="❯"
  local level_start=1
  local level_string=""

  test -n "$TMUX" && level_start=2

  for i in {$level_start..$SHLVL}; do
    level_string+="$level_char"
  done

  echo ${level_string}
}

function get_hostname() {
  local HOST
  if [[ -n $SSH_TTY ]]
  then
    echo "$(hostname):"
  else
    echo ""
  fi
}

local HOST=$(get_hostname)
local RPATH='$(rprompt_path)'
export PS_SHLVL='$(shell_level)'
export RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}${RPATH}%f"
export RPROMPT=$RPROMPT_BASE
export PS1="%F{green}\${VENV_INFO}%F{yellow}$(get_hostname)%F{blue}%1~%F{red} ${PS_SHLVL}%f "


# Set up shell hooks for prompt
#
autoload -U add-zsh-hook

# Elapsed time
#

typeset -F SECONDS
function -record-start-time() {
  emulate -L zsh
  ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}
add-zsh-hook preexec -record-start-time

function -report-start-time() {
emulate -L zsh
if [ $ZSH_START_TIME ]; then
  local DELTA=$(($SECONDS - $ZSH_START_TIME))
  local DAYS=$(( ~~($DELTA / 86400) ))
  local HOURS=$(( ~~(($DELTA - $DAYS * 86400) / 3600) ))
  local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60) ))
  local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60 ))
  local ELAPSED=''
  test "$DAYS" != '0' && ELAPSED="${DAYS}d"
  test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
  test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
  if [ "$ELAPSED" = '' ]; then
    SECS="$(print -f "%.2f" $SECS)s"
  elif [ "$DAYS" != '0' ]; then
    SECS=''
  else
    SECS="$((~~$SECS))s"
  fi
  ELAPSED="${ELAPSED}${SECS}"
  export RPROMPT="%F{blue}%{$__PJL[ITALIC_ON]%}${ELAPSED}%{$__PJL[ITALIC_OFF]%}%f $RPROMPT_BASE"
  unset ZSH_START_TIME
else
  export RPROMPT="$RPROMPT_BASE"
fi
}
add-zsh-hook precmd -report-start-time

# Remember each command we run.
function -record-command() {
  __PJL[LAST_COMMAND]="$2"
}
add-zsh-hook preexec -record-command

# Update vcs_info (slow) after any command that probably changed it.
#
function -maybe-show-vcs-info() {
  local LAST="$__PJL[LAST_COMMAND]"

  # In case user just hit enter, overwrite LAST_COMMAND, because preexec
  # wont run and it will otherwise linger.
  __PJL[LAST_COMMAND]="<unset>"

  # Check first word; via:
  # http://tim.vanwerkhoven.org/post/2012/10/28/ZSH/Bash-string-manipulation
  case "$LAST[(w)1]" in
    git|rm|touch|mv|cp)
      vcs_info
      ;;
    *)
      ;;
  esac
}
add-zsh-hook precmd -maybe-show-vcs-info

# If entering directory in a git repo, show vcs info for that repo
add-zsh-hook chpwd -show-vcs-info-when-entering-git-dir() {
        git rev-parse --is-inside-work-tree && vcs_info
    }
add-zsh-hook chpwd -show-vcs-info-when-entering-git-dir()

# Call vcs_info when sourcing this file so we update git status after starting
# a new shell
vcs_info
