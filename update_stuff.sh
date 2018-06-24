#!/usr/bin/bash

function check_folder ()
{
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

function handle_folder ()
{
    localfilepath=./"${FILEPATH%/*}"
    filename="${FILEPATH##*/}"
    [[ $slash_nmbr -gt 0 ]] && [[ ! -d $localfilepath ]] && mkdir -p $localfilepath
    cp ~/$FILEPATH $localfilepath/$filename
    git add $localfilepath/$filename
}

list=(".vimrc" ".bashrc" ".profile" ".bash_profile" ".vim/custom_py.vim" ".config/qutebrowser/config.py"\
    ".config/i3/*")

for rc in ${list[@]}
do
    echo "$rc"
    check_folder $rc
    if [ "$slash_nmbr" != "0" ]
    then
        handle_folder # $rc
    else
        cp ~/$rc .
        git add "$rc"
    fi
done

git add $0

git commit -m "Auto commit, $(date)"
