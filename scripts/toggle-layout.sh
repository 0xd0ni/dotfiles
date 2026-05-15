#!/bin/bash
current=$(setxkbmap -query | grep layout | awk '{print $2}')
if [ "$current" = "us" ]; then
    setxkbmap -layout pt
else
    setxkbmap -layout us
fi
