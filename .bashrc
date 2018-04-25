#
# ~/.bashrc
#

shopt -s cdspell

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#wichi command
function wichi {
	command -v $1;
}


function h {
if [ "$1" ] ; then
	history 1000 | grep "$@"
else
	history 30;
fi
}

#PATHの長さによってPS1を変更する
function pwd_ps1 {
	if [ $(pwd | wc -c) -lt 30 ] ; then
		PS1='\[\e[0;31m\]\u@\[\e[0;33m\]\h\[\e[m\] \[\e[0;35m\]\t \[\e[m\]$(pwd)]\$ '
	else
		PS1='\[\e[0;31m\]\u@\[\e[0;33m\]\h\[\e[m\] \[\e[0;35m\]\t \[\e[m\]\W]\$ '
	fi	
}

function cd_pwd_ps1 {
	\pushd "$1" > /dev/null && ls &&pwd_ps1
}

function cdh {
	dirs -v -l | sort -k 2 | uniq -f 1 | sort -k 1 |head -n 10
	read -p "select number:" directory
	if [ -z $directory ]; then
		printf "\e[1;32m どこに移動するの？番号を指定して\e[m\n"
		cdh
	else
		cd $(echo ${DIRSTACK[$directory]}) 
	fi
}


uname_kernel=$(uname)

if [[ "$uname_kernel" == "Linux" ]]; then
	alias ls='ls --color=auto'
	alias ll='ls -l'
	alias la='ls -la'
	alias sl='ls --color=auto'
else
	alias ls='ls -GF'
	alias ll='ls -Gl'
	alias la='ls -Gla'
	alias sl='ls -GF'
fi

alias ..='cd ../'
alias ...='cd ../../'
alias wl='wc -l'
alias cd='cd_pwd_ps1'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias v='vim'
alias c='clear'
alias qday=$HOME/code/rust/projects/qday/target/debug/./qday

export EDITOR='vim'

HISTSIZE=50000
HISTFILESIZE=50000
HISTIGNORE=history
pwd_ps1
