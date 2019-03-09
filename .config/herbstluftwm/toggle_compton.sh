#!/bin/bash

pgrep -x compton > /dev/null
if [[ $? -eq 0 ]]; then
    pkill -x compton > /dev/null
else
    compton -b
fi
