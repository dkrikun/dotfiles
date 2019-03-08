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
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
