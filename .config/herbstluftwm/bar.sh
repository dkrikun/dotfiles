#!/bin/bash

bottom=false
height=22
fifo=/tmp/lemonbar_${USER}
font=Iosevka-Term:style=Oblique:pixelsize=18
geometry=x${height}

hc pad 0 $height

script_dir=$HOME/.config/herbsluftwm

. $HOME/.cache/wal/colors.sh
bg=$background

# event generator
hc --idle |
while read _; do
    mapfile -t tags < \
        <(hc list_monitors | awk '{ print $5 }' | sed 's/"//g')

    mapfile -t focus < \
        <(hc list_monitors | awk '{ print $6 }' \
            | sed 's/\[FOCUS\]/%{F#ff8c00}/')

    mapfile -t unfocus < \
        <(hc list_monitors | awk '{ print $6 }' \
            | sed "s/\[FOCUS\]/%{F$foreground}/")

    toolbar="%{r}%{A:reload:}R%{A} %{A:quit:}Q%{A} "
    echo "%{S0}%{c}${focus[0]}- ${tags[0]} -${unfocus[0]}$toolbar"
done |
    lemonbar -p \
        -f "${font}" \
        -g "${geometry}" -B "$bg" -F "$foreground" -u 3 |
        while read line; do
            IFS=$'\t' read -ra cmd <<< $"line"
            case "${cmd[0]}" in
                quit) hc quit ;;
                reload) hc reload ;;
            esac
        done

