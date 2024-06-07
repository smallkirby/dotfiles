### Completion ########################################

# Use Git completion script
zstyle ':completion:*:*:git:*' script $HOME/.zsh/git-completion.bash
# Use menu style completion
zstyle ':completion:*' menu select=2
# Complete also dot files
setopt globdots

### History ###########################################

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history
setopt histignorealldups sharehistory

### User configuration ################################

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
# Compilation flags
export ARCHFLAGS="-arch x86_64"

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

# fly
export PATH="$HOME/.fly/bin:$PATH"

# pipx
export PATH="$PATH:/home/wataru/.local/bin"
eval "$(register-python-argcomplete pipx)"

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

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# others
tmux="TERM=xterm-256color tmux"

### runscripts ############################################

# rbenv
eval "$(rbenv init -)"

# cargo
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

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

### completion #######################################

fpath=($HOME/.zsh $HOME/pure $fpath)

### navi ###############################################

eval "$(navi widget zsh)"

### inputrc ###############################################

set editing-mode vi

### Added by Zinit's installer ########################
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit ice depth"1" 
zinit light romkatv/powerlevel10k
source $HOME/.p10k.zsh
zinit light zsh-users/zsh-completions
#zinit light jeffreytse/zsh-vi-mode

######################################################

: "Tips
- Ctrl + T: fuzzy tile content viewer (bat required)
"


