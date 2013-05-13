# some aliasing
alias ls='ls -G'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias l='ls -lha'
alias grep='grep --color'

# env modifications
export EMACS_MAC_PATH=/Applications/Emacs.app/Contents/MacOS/bin
export PATH=~/bin:/usr/local/bin:$EMACS_MAC_PATH:$PATH

# change PS1 format
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
