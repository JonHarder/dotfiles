#!/bin/bash
raw=`amixer get Master | sed -n '5p'`
# Mono: Playback 47 [54%] [-30.00dB] [on]
muted=$(echo $raw | grep -ic "off")
vol=""
if [ $muted -eq 1 ]
then
    vol="mute"
else
    vol=`amixer get Master | sed -n '5p' | awk '{print $3}'`
fi
echo Vol: $vol
