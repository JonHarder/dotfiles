#!/bin/bash

# used by xmobar to write current song:artist into the
# top bar. Since we're just reading from a file, return
# nothing when pianobar is off.
RESULT=`pgrep pianobar`
if [ "${RESULT:-null}" = null ]; then
	echo -n ''
else
	cat ~/pianosong
fi
