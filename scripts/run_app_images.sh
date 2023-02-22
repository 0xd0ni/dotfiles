#!/bin/bash 

filename="$HOME/Downloads/Obsidian-1.1.9.AppImage"

if [[ -f "$filename" ]]; then
    $filename;
else 
    echo "file @ $filename not found";
fi