# this is the .bashrc file for xzpeter

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# need special care on Darwin systems
system_name=$(uname -s)
# some aliasing
case $system_name in
    Darwin|FreeBSD)
        alias ls='ls -G'
        export VERSIONER_PYTHON_PREFER_32_BIT=yes
        export PATH=~/bin:~/bin/rh:/usr/local/bin:$EMACS_MAC_PATH:$PATH
        # TERM not right may lead to vi/etc. open fail
        export TERM=xterm
        ;;
    Linux)
        alias ls='ls --color'
        export PATH=~/bin:~/bin/rh:/usr/local/bin:~/git/git-tools:$PATH
        ;;
esac

alias l='ls -lha'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias tree='tree -C'
alias grep='grep --color'
alias work='ssh dev2'
alias work2='ssh dev-ub'
alias cp_r='rsync --progress -ah'

function __ps1_git_prefix()
{
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ $? == 0 ]]; then
        echo -e "\033[01;32m [${branch}]"
    fi
}

# change PS1 format
PS1='\[\033[01;31m\]\h\[\033[00m\]:\[\033[01;34m\]\W$(__ps1_git_prefix)\[\033[00m\]\$ '
# with create-frame, window could be focused automatically
export EDITOR='emacsclient'
export ALTERNATE_EDITOR='vim'

# enable VI mode for command lines
set -o vi
# enable clear-screen
bind -x $'"\C-l":clear;'
