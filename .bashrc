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
        eval "$(/opt/homebrew/bin/brew shellenv)"
        # for macos bash completion
        comp_dir=/opt/homebrew/etc/bash_completion.d
        completions="git-completion.bash"
        if [[ -d $comp_dir ]]; then
            for f in $completions; do
                source $comp_dir/$f
		    done
	    fi
        ;;
    Linux)
        alias ls='ls --color'
        PATH="/home/xz/perl5/bin${PATH:+:${PATH}}"; export PATH;
        PERL5LIB="/home/xz/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
        PERL_LOCAL_LIB_ROOT="/home/xz/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
        PERL_MB_OPT="--install_base \"/home/xz/perl5\""; export PERL_MB_OPT;
        PERL_MM_OPT="INSTALL_BASE=/home/xz/perl5"; export PERL_MM_OPT;
        export PATH="/usr/local/musl/bin:$PATH"
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
alias run='cargo run'
alias build='cargo build'

function __ps1_git_prefix()
{
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ $? == 0 ]]; then
        echo "[${branch}]"
    fi
}

# let's have this to workaround an issue with tmux on Fedora 31
PS0=""
# change PS1 format
PS1='\[\033[01;33m\]\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] \[\033[01;32m\]$(__ps1_git_prefix)\[\033[00m\]\$ '
# with create-frame, window could be focused automatically
export EDITOR='emacsclient'
export ALTERNATE_EDITOR='vim'

# enable VI mode for command lines
set -o vi
# enable clear-screen
bind -x $'"\C-l":clear;'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH=~/bin:~/bin/rh:/usr/local/bin:~/git/git-tools:$PATH

# for distcc
export DISTCC_POTENTIAL_HOSTS='localhost b1'
