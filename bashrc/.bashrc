# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export SHELL=/usr/bin/bash

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

function save_state() {
    export ps1prev=$?
}

function show_git_branch() {
    local branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' | sed s'/^ (//g' | sed s'/)$//g')"
    if [ -z "$branch" ]; then
        echo -ne "\033[0;35m(nogit)\\e[0m"
    else
        echo -ne "\033[0;35m[$branch]\\e[0m"
    fi
}

function show_prev_status() {
    if [ $1 == 0 ]; then
        echo -ne "\\e[0;92m"
    else
        echo -ne "\\e[0;91m"
    fi
    echo -ne "<$1>\\e[0m"
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]: \[\033[01;35m\]\t \d\[\033[00m\]: $(save_state; show_git_branch; echo ""; show_prev_status $ps1prev) \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

### Alias #############################################

# ls
alias ls='ls -la --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep
alias grep='grep --color=always'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# format / verbosity
alias which='which -a'
alias dmesg="dmesg -T --color=always"
alias ddmesg="dmesg -T --color=always | grep -v usb2"
alias objdump="objdump -M intel"

# pwn
alias strace="strace -v -s 90"
alias rp++="rp-lin-x86_64 --colors"
alias upwndbg="gdb -q -nx -ix $HOME/.gdbinit.pwn"
alias pwndbg="sudo gdb -q -nx -ix $HOME/.gdbinit.pwn"
alias gdb="sudo gdb -q -nx -ix $HOME/.gdbinit"

# stap
STAP_HOME=$HOME/systemtap/build/bin
alias stap="sudo $STAP_HOME/stap"
alias sstap="sudo strace $STAP_HOME/stap"

# ghidra
export GHIDRA_LATEST=ghidra_10.1.2_PUBLIC
export GHIDRA_INSTALL_DIR=/usr/local/$GHIDRA_LATEST
alias ghidra="sh $GHIDRA_INSTALL_DIR/ghidraRun"

# jython
export JYTHON_HOME=$HOME/jython
alias jython="java -jar $JYTHON_HOME/jython-standalone-2.7.2.jar"

# gcc
alias gcc="ccache gcc"
alias make='make CC="ccache gcc"'

# journalctl
alias jlog="journalctl -b --all --catalog --no-pager" # current boot only
alias jlogall="journalctl --all --catalog --merge --no-pager"
alias jlogf="journalctl -f"
alias jlogk="journalctl -b -k --no-pager"

# lttng
alias logng="babeltrace2"

# history share/unshare
alias s='export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"'
alias us='export PROMPT_COMMAND=""'

# nautilus
alias bd="nautilus --browser $(pwd)"
alias bp="nautilus --browser $HOME/Pictures"

# terminal
alias newterm="gnome-terminal --working-directory=$PWD"

# k8s
alias k="kubectl"
source <(kubectl completion bash)
alias ktx="kubectx"
alias kns="kubens"

# others
alias astudio="$HOME/android-studio/bin/studio.sh"
alias postman="$HOME/Postman/Postman"
alias tracecompass="$HOME/trace-compass/tracecompass"
alias xtop="xtop 2>~/xtop-error"
alias less="less -R"
alias x="xclip -sel clip"
alias pd="perldoc"
alias withenv="env \$(cat .env | xargs)"

### END Alias #############################################


### set up PATH and envvars ###############################

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# go
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Android
export ANDROID_SDK=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK/platform-tools

# jadx
export PATH=$PATH:$HOME/jadx/build/jadx/bin

# ccache
PATH=/usr/bin/ccache:$PATH
export USE_CCACHE=1
export CCACHE_DIR=$HOME/.ccache

# lysithea
export PATH=$PATH:$HOME/lysithea

# others
tmux="TERM=xterm-256color tmux"

### END set up PATH and envvars ###########################


### runscripts ############################################

# rbenv
eval "$(rbenv init -)"

# cargo
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

# Go
export PATH="$PATH:$(go env GOPATH)/bin"

# Perl
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

### END runscripts ########################################

### BASH  #################################################

set -o vi # run bash in vi mode

### END BASH ##############################################

### MISC ##################################################

# Fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# bash_completion for aliased commands
source $HOME/complete-alias/complete_alias

## Each completions follows:
  complete -F _complete_alias k
  complete -F _complete_alias kns
  complete -F _complete_alias ktx

### END MISC ##############################################

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


: ' ## Tips ##

# LESS

- enable escape-sequence: use `-R` option
    eg: less -R ./log

- specify command-line option after execution: use `-<option>`
    eg: -R (inside less)

# MISC

- disable alias and execute: use back-slash
    eg: \less

'

