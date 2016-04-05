#!/bin/bash

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ --> \1/'
}

gbranch () {
	local b=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/\* //')
	if [[ -n "$b" ]]; then
		echo -ne "\e[0;34m(\e[0;31m$b\e[0;34m)"
	else
		echo ""
	fi
}

parse_git-tag () {
    git describe --tags 2> /dev/null
}

parse_git_branch_or_tag () {
    local OUT="$(parse_git_branch)"
    if [ "$OUT" == " ((no branch))" ]; then
        OUT="($(parse_git_tag))";
    fi
    echo "$OUT "
}
