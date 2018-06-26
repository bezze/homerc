#!/usr/bin/bash

function check_folder () {
    FILEPATH=${1}
    slash_nmbr=$(echo $FILEPATH | awk -F "/" '{print NF-1}')
    [[ ${FILEPATH:0:1} == "/" ]] && echo "No full path allowed, all relative to home" && exit;
    # if [[ $slash_nmbr -eq 0 ]]
    # then
    #     echo 0
    # else
    #     echo $slash_nmbr
    # fi
}

function handle_folder () {
    localfilepath=./"${FILEPATH%/*}"
    filename="${FILEPATH##*/}"
    [[ $slash_nmbr -gt 0 ]] && [[ ! -d $localfilepath ]] && mkdir -p $localfilepath
    cp ~/$FILEPATH $localfilepath/$filename
    git add $localfilepath/$filename
}

# function add_folder_recursively () { } 

list=(".vimrc" ".bashrc" ".profile" ".bash_profile" ".vim/custom_py.vim" ".config/qutebrowser"\
    ".config/i3" ".xinitrc" ".tmux.conf")

for rc in ${list[@]}
do
    echo "$rc"
    check_folder $rc
    if [[ -d $FILEPATH ]]
    then # It's a folder
        git add $FILEPATH/*
    elif [ "$slash_nmbr" != "0" ]
    then # It's _in_ a folder
        handle_folder # $rc
    else # It's in $HOME
        cp ~/$rc .
        git add "$rc"
    fi
done

git add $0

git commit -m "Auto commit, $(date)"
