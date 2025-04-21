# https://www.gnu.org/software/bash/manual/bash.html

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm*|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# show git branch after current path
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

timer_now() {
  date +%s%N
}

timer_start() {
  timer_start=${timer_start:-$(timer_now)}
}

function timer_stop {
  [[ -z $timer_start ]] && return
  local delta_us=$((($(timer_now) - ${timer_start}) / 1000))
  local us=$((delta_us % 1000))
  local ms=$(((delta_us / 1000) % 1000))
  local s=$(((delta_us / 1000000) % 60))
  local m=$(((delta_us / 60000000) % 60))
  local h=$((delta_us / 3600000000))
  # Goal: always show around 3 digits of accuracy
  if   [[ h -gt 0 ]];    then timer_show=${h}h${m}m
  elif [[ m -gt 0 ]];    then timer_show=${m}m${s}s
  elif [[ s -ge 10 ]];   then timer_show=${s}.$((ms / 100))s
  elif [[ s -gt 0 ]];    then timer_show=${s}.$(printf %03d $ms)s
  elif [[ ms -ge 100 ]]; then timer_show=${ms}ms
  elif [[ ms -gt 0 ]];   then timer_show=${ms}.$((us / 100))ms
  else                        timer_show=${us}us
  fi
  unset timer_start
}

set_prompt() {
  Last_Command=$? # Must come first!
  timer_stop

  if [ "$color_prompt" = yes ]; then
    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    Green='\[\e[01;32m\]'
    Yellow='\[\e[01;33m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'
  else
    Blue=''
    White=''
    Red=''
    Green=''
    Reset=''
    FancyX=''
    Checkmark=''
  fi

  PS1="${debian_chroot:+($debian_chroot)}$Green\u@\h$Reset:$Blue\w"

  PS1+="$Yellow\$(parse_git_branch)$Reset"

  if [ $Last_Command -eq 0 ]; then
    PS1+=" $Green($Checkmark ${timer_show})"
  else
    PS1+=" $Red($FancyX ${timer_show})"
  fi

  PS1+="$Reset $ "
}

set_prompt
trap 'timer_start' DEBUG
PROMPT_COMMAND='set_prompt'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Aliases for quicker path reduction in terminal
alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enabling syntax "... | xclip" to copy output of first
# statement to clipboard
alias clip="xclip -selection clipboard"

set -o vi

# Disable XOFF from Software flow control
# (cause of issues when using with vim)
stty -ixon

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -U -g ""'

# Local config exports
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
. "/home/keyg/.deno/env"