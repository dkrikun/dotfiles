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

#export PROMPT_COMMAND=_set_ps1


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


function sea() {
    local line
    line=$(ag --nogroup "$@" | cut -d':' -f1,2 | \
        fzf --preview-window=60% --preview='~/.local/bin/xxview {}')

    if [ $line ]; then
        nvim ${line%:*} +${line#*:}
    fi
}


export EDITOR=nvim
export VISUAL=nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


function hc {
    herbstclient "$@"
}


ETH=enp60s0

function arpw() {
    sudo watch -n0.9 arp-scan --interface=$ETH 192.168.1.0/24
}

function arpu() {
    sudo watch -n0.9 arp-scan --interface=wlp61s0 192.168.1.0/24
}

function git-sc() {
    git log --oneline | fzf | awk '{ print $1 }' | xargs git show
}

source /usr/share/bash-completion/completions/herbstclient-completion
alias hc=herbstclient

complete -F _herbstclient_complete -o nospace hc

alias theme_light='wal -l --theme base16-mexico'
alias theme_dark='wal --theme base16-atelier-estuary'

spawn_with_rules() {(
    # this rule also requires, that the client
    # sets the _NET_WM_PID property
    herbstclient rule once pid=$BASHPID maxage=10 "${RULES[@]}"
    exec "$@"
    ) &
}

findout() {
    curr=$(which "$@")
    if [ "$?" == 0 ]; then
        while true
        do
            next=$(readlink $curr)
            if [ "$?" != 0 ]; then
                echo $curr
                break
            else
                curr=$(which $next)
            fi
        done
    fi
}

lsserial() {
    ls -lA /dev/serial/by-id 2>/dev/null
}

scr() {
    screen "$@" 115200
}

export PATH="$PATH:$HOME/.vim/plugged/vim-superman/bin"
complete -o default -o nospace -F _man vman
