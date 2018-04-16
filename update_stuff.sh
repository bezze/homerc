
list=(".vimrc" ".bashrc" ".profile")

for rc in ${list[@]}
do
    echo "$rc"
    cp ~/"$rc" .
done
