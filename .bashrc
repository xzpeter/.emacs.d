# this is the .bashrc file for xzpeter

# need special care on Darwin systems
function is_darwin ()
{
	[ `uname -s` == "Darwin" ];
}

# some aliasing
if is_darwin; then
	alias ls='ls -G'
fi
alias l='ls -lha'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias tree='tree -C'
alias grep='grep --color'
alias work='ssh dev-spa'
alias cp_r='rsync --progress -ah'

# env modifications

if is_darwin; then
	EMACS_MAC_PATH_EXTRA=/Applications/Emacs.app/Contents/MacOS/bin
	export PATH=~/bin:~/bin/cyphy:/usr/local/bin:$EMACS_MAC_PATH:$PATH
	# TERM not right may lead to vi/etc. open fail
	export TERM=xterm
else
	export PATH=~/bin:~/bin/cyphy:/usr/local/bin:$PATH
fi

# change PS1 format
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export EDITOR='vim'
