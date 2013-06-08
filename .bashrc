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
alias grep='grep --color'

# env modifications

if is_darwin; then
	EMACS_MAC_PATH_EXTRA=/Applications/Emacs.app/Contents/MacOS/bin
	export PATH=~/bin:/usr/local/bin:$EMACS_MAC_PATH:$PATH
else
	export PATH=~/bin:/usr/local/bin:$PATH
fi

# change PS1 format
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
