#!/bin/sh

urxvt_pid=$(pgrep urxvt | grep $(xdotool getwindowfocus getwindowpid))
if [ $? -eq 0 ]; then
    child_pid=$(pgrep -P $urxvt_pid | head -1)
    exec urxvt -cd /proc/$child_pid/cwd "$@"
else
    exec urxvt "$@"
fi

