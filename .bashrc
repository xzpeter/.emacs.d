# this is the .bashrc file for xzpeter

# need special care on Darwin systems
function is_unix ()
{
	[ `uname -s` == "Darwin" -o `uname -s` == "FreeBSD" ];
}

# some aliasing
if is_unix; then
	alias ls='ls -G'
fi
alias l='ls -lha'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias tree='tree -C'
alias grep='grep --color'
alias work='ssh dev'
alias cp_r='rsync --progress -ah'

# env modifications

if is_unix; then
	EMACS_MAC_PATH_EXTRA=/Applications/Emacs.app/Contents/MacOS/bin
	export VERSIONER_PYTHON_PREFER_32_BIT=yes
	export PATH=~/bin:~/bin/cyphy:/usr/local/bin:$EMACS_MAC_PATH:$PATH
	# TERM not right may lead to vi/etc. open fail
	export TERM=xterm
else
	export PATH=~/bin:~/bin/cyphy:/usr/local/bin:$PATH
fi

# change PS1 format
PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
export EDITOR='vim'
