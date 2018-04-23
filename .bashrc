#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#wichi command
function wichi {
	command -v $1;
}

function h30 {
	history 30;
}

function pwd_ps1 {
	if [ $(pwd | wc -c) -lt 30 ] ; then
		PS1='\[\e[0;31m\]\u@\[\e[0;33m\]\h\[\e[m\] \[\e[0;35m\]\t \[\e[m\]$(pwd)]\$ '
	else
		PS1='\[\e[0;31m\]\u@\[\e[0;33m\]\h\[\e[m\] \[\e[0;35m\]\t \[\e[m\]\W]\$ '
	fi	
}

function cd_pwd_ps1() {
	\cd "$@" && ls &&pwd_ps1
}

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias sl='ls --color=auto'
alias ..='cd ../'
alias ...='cd ../../'
alias cd='cd_pwd_ps1'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias v='vim'
alias qday=$HOME/code/rust/projects/qday/target/debug/./qday

export EDITOR='vim'

HISTSIZE=50000
HISTFILESIZE=50000

pwd_ps1
