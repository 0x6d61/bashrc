# ---- history -------------------------------------------------
#

HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
#
shopt -s histappend

# ---- shell behavior ------------------------------------------
#

# ** で再帰glob
shopt -s globstar

# cd typo補正
shopt -s cdspell

# completionで大文字小文字を無視
bind 'set completion-ignore-case on'


# ---- aliases -------------------------------------------------
#

alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'



# --- prompt 設定 -----------------------------------------------
set_prompt() {
    local rc=$1

    if (( rc == 0 )); then
        local status="\[\e[32m\]✔ "
    else
        local status="\[\e[31m\]✘ ${rc}"
    fi

    PS1="${status} \[\e[36m\]\u@\h \[\e[34m\]\w\[\e[0m\]\n↳ "
}

prompt_command() {
	local rc=$?

	# 複数terminalでも履歴をなるべく同期
	history -a
	history -n

	set_prompt "$rc"

}

PROMPT_COMMAND=prompt_command
