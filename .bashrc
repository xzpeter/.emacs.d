# this is the .bashrc file for xzpeter

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
        export PATH=~/bin:~/bin/rh:/usr/local/bin:$PATH
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

# change PS1 format
PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
export EDITOR='vim'
