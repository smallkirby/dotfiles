if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

bindkey -v

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### Alias #############################################

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
alias gef="sudo GEF_RC=$HOME/.gef.rc gdb -q -nx -ix $HOME/.gdbinit-gef"
alias gdb="sudo gdb -q -nx -ix $HOME/.gdbinit"

# ghidra
export GHIDRA_LATEST=ghidra_10.1.2_PUBLIC
export GHIDRA_INSTALL_DIR=/usr/local/$GHIDRA_LATEST
alias ghidra="sh $GHIDRA_INSTALL_DIR/ghidraRun"

# jython
export JYTHON_HOME=$HOME/jython
alias jython="java -jar $JYTHON_HOME/jython-standalone-2.7.3.jar"

# gcc
alias cgcc="ccache gcc"
alias mmake='mold -run make CC="ccache gcc"'

# journalctl
alias jlog="journalctl -b --all --catalog --no-pager" # current boot only
alias jlogall="journalctl --all --catalog --merge --no-pager"
alias jlogf="journalctl -f"
alias jlogk="journalctl -b -k --no-pager"

# nautilus
alias bd="nautilus --browser $(pwd) >/dev/null 2>/dev/null &"
alias bp="nautilus --browser $HOME/Pictures >/dev/null 2>/dev/null &"

# k8s
alias k="kubectl"
source <(kubectl completion zsh)
alias ktx="kubectx"
alias kns="kubens"

# others
alias astudio="$HOME/android-studio/bin/studio.sh"
alias postman="$HOME/Postman/Postman"
alias tracecompass="$HOME/trace-compass/tracecompass"
alias xtop="xtop 2>~/xtop-error"
alias less="less -RN"
alias x="xclip -sel clip"
alias pd="perldoc"
alias withenv="env \$(cat .env | xargs)"
alias try="$HOME/try/try"

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

# gradle
export PATH=$PATH:/opt/gradle/gradle-7.6/bin

# others
tmux="TERM=xterm-256color tmux"

### runscripts ############################################

# rbenv
eval "$(rbenv init -)"

# cargo
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

### zplug  #############################################

source $HOME/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "mafredri/zsh-async"
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "junegunn/fzf", from:gh-r, as:command, rename-to:fzf

zplug load

### p10k  #############################################

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### fzf ###############################################

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

git-hist() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

source /usr/share/doc/fzf/examples/key-bindings.zsh # installed by apt
source /usr/share/doc/fzf/examples/completion.zsh # installed by apt

######################################################

: "Tips
- Ctrl + T: fuzzy tile content viewer (bat required)
"

