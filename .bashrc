#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

function _set_ps1() {
    rv=$?
    if [[ rv -eq 0 ]]; then
        PS1="\w> "
    else
        PS1="\w\[$(tput setaf 2)\]$rv\[$(tput sgr 0)\]> "
    fi
}

export PROMPT_COMMAND=_set_ps1


# fd - cd to selected directory
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# this binds Ctrl-O to ranger-cd:
bind '"\C-o":"ranger-cd\C-m"'
bind '"\C-w":"pwd\C-m"'

. /usr/share/fzf/key-bindings.bash
. /usr/share/fzf/completion.bash

alias yamd=yadm

function backup_rcs() {
    yadm add -u && yadm commit -m "Update" && yadm push
}

function sea() {
    local line
    line=$(ag --nogroup "$@" | cut -d':' -f1,2 | \
        fzf --preview-window=60% --preview='xxview {}')
    if [ $line ]; then
        vim ${line%:*} +${line#*:}
    fi
}

export PATH="$HOME/rcd:$HOME/.local/bin:$PATH"
export ETH=enp0s31f6

alias vi=nvim
alias sudo='sudo '
