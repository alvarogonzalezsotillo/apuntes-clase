#!/bin/bash

git_repo(){
    git rev-parse --show-toplevel
}

git_repo_name(){
    basename $(git_repo)
}

absolute_filename(){
    local F="$1"
    readlink -f "$F"
}

filename_relative_to_git_repo(){
    local F=$(absolute_filename "$1")
    local REPO=$(git_repo)
    local LENGTHR=${#REPO}
    local RET=${F:$LENGTHR}
    echo $RET
}

for FILENAME in $*
do
    echo https://alvarogonzalezsotillo.github.io/$(git_repo_name)$( filename_relative_to_git_repo "$FILENAME")
done

