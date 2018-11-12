# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

complete -cf sudo

# Put your fun stuff here.

export TERMINAL=konsole

exitcolor()
{
    if [[ $? == 0 ]]; then
        echo -n "$(tput setaf 10)"
    else
        echo -n "$(tput setaf 1)"
    fi
}

export VCP_PREFIX=$'{yellow}\ue0a0'
export VCP_NAME=""
export VCP_BRANCH="{yellow}{value}{reset}"
export VCP_OPERATION="{yellow}({value}){reset}"
export VCP_BEHIND=$' {red}\uf175{value}'
export VCP_AHEAD=$' {blue}\uf176{value}'
export VCP_STAGED=$' {green}\ufa5b{value}'
export VCP_CONFLICTS=$' {red}\ue009{value}'
export VCP_CHANGED=$' {yellow}\ufa5b{value}'
export VCP_UNTRACKED=$' {yellow}({value})'
export VCP_CLEAN=$' {green}{bold}\u2714'
export VCP_SEPARATOR=""

RESET=$(tput sgr0)
DIR=$(tput setaf 4)
USER=$(tput setaf 6)
GENTOO=$(tput setaf 10)
export PS1=$'\[${GENTOO}\]\uf30d  \[${USER}\]\u \[${DIR}\]\w $(vcprompt)\n\[$(exitcolor)\]\ue234  \[${RESET}\]'


export PATH=/home/hashed/usr/bin:$PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
