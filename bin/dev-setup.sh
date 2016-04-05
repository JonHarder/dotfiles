#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "USAGE: dev-setup.sh HOST"
else
    rsync ~/.vimrc "$1":
    rsync ~/.bashrc "$1":
    rsync ~/.tmux.conf "$1":
    rsync -avz --del  ~/.vim "$1":
    rsync -v bin/git_branch.sh "$1":bin/
    ssh "$1" "git clone -q https://JonHarder:hard8637@github.com/telsasoft/legacy.git /home/jharder/server"
fi
