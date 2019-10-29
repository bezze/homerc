################################################################################
# Fancy comments
################################################################################

PHOME=set_me

# Sourcing API keys and private IDs
if [[ -n $PHOME ]]
then
    source $PHOME/../.env_keys
else
    source ../.env_keys
fi

METADIR=${PHOME%\/*}
export PATH=$PATH:$METADIR/pbin
export PATH=$PATH:$PHOME/pbin

# Auxiliary
venv () {
    # Creates a bash variable that holds the path to our virtualenv folder
    cd $PHOME
    VENV=$PHOME/../.venv
    cd -
}

venv

hash_and_rename () {
    local input="$1"
    local name="${input%%.*}"
    local ext="${input##*.}"
    hash=$(md5sum "${input}" | awk '{print $1}')
    finalname="${name}"-$hash-$(date +%s)."$ext"
    mv "${input}" "${finalname}"
    echo "${finalname}"
}

fancy_print () {
    # echo -e "\e[32m""${1}""\e[39m"
    case $1 in
        red)
            echo "$(tput bold)$(tput setaf 1)""${2}""$(tput sgr0)";;
        green|*)
            echo "$(tput bold)$(tput setaf 2)""${2}""$(tput sgr0)";;
    esac
}

git_head () {
    cat $PHOME/.git/HEAD | sed 's/.*\///'
}

new_PS1() {
    if [[ ! -n $PS1_old ]] 
    then
        export PS1_old="${PS1}"
    fi
    # export PS1="${PS1_old/∮/\$(git_head)\[$(tput setaf 4)\]\)\[$(tput setaf 7)\]∮}"
    export PS1=$(echo $PS1_old | sed 's/∮/\$(git_head)\\[$(tput setaf 4)\\]\)\\[$(tput setaf 7)\\]∮/')
}


new_PS1

# Maintenance
vfunc () {
    # Attempt to use preferred editor, otherwise, use nano.
    if [[ -z $EDITOR ]]
    then
        nano $PHOME/functions.bash
    else
        $EDITOR $PHOME/functions.bash
    fi

    resource
}

resource () {
    source $PHOME/functions.bash
}

# Movement
gh () {
    # Go project home
    cd $PHOME
}

gp () {
    # Go project home
    cd $PHOME/ottmsc
}

gl () {
    # Go lambdas
    local lambda="${1}"
    cd "$PHOME/ottmsc/lambdas/${lambda}"
}

gt () {
    # Go tests
    cd $PHOME/ottmsc/tests/
}

gf () {
    # Go formations
    cd $PHOME/ottmsc/formations/
}

gtu () {
    # Go tests units lambdas
    local lambda=$1
    cd $PHOME/ottmsc/tests/unit/ottmsc/lambdas/$lambda
}

gu () {
    cd $PHOME/utils/$1
}

gm () {
    cd $METADIR
}

tu () {
    # Runs unit test for given lambda, else, just runs pytest in place
    local lambda=$1
    As
    if [[ -z $lambda ]]
    then
        pytest -vv
    else
        pytest -vv $PHOME/ottmsc/tests/unit/ottmsc/lambdas/$lambda $2
    fi
    ds
}

tt () {
    # "test this" runs the corresponding unit test if we are in a lambda folder
    # local lambda=$(basename $PWD)
    local lambda=${PWD##*\/}
    As
    pytest -vv $PHOME/ottmsc/tests/unit/ottmsc/lambdas/$lambda
    ds
}

# Misc

get_logs () {
    local log_name="${1//\//_}"-"${2##*]}".log
    aws logs get-log-events --log-group-name "${1}" --log-stream-name "${2}" --output text > "$log_name"
    sed -i '/^\t.*/d' $log_name
    sed -i '/.*\[INFO\].*/d' $log_name
}

# Git update current branch
git_update () {
    git merge --ff-only origin/$(git_head)
}

tree () {
    git log --graph --oneline --all
}

# Git aliases
gcheck () {
    git checkout "${@}"
}

# Invoke lambda with python-lambda
invoke() {
    local lambda="$1"
    shift
    echo $@
    tox -e py36-lambda-"$lambda" -- invoke -v $@
}

# Glorious autocompletion
_lambdas()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local lambda_dir=$PHOME/ottmsc/lambdas/
    local lambda_list=$(ls -1 ${lambda_dir} | sed 's/^\/home.*lambdas\///' | xargs)
    COMPREPLY=( $(compgen -W "${lambda_list}" -- $cur) )
}

_test_lambdas()
{
    # Yes, until I figure out how to do this "right" I'm copy-pasting the above
    local cur=${COMP_WORDS[COMP_CWORD]}
    local lambda_dir=$PHOME/ottmsc/tests/unit/ottmsc/lambdas/$lambda
    local lambda_list=$(ls -1 ${lambda_dir} | sed 's/^\/home.*lambdas\///' | xargs)
    COMPREPLY=( $(compgen -W "${lambda_list}" -- $cur) )
}

# Glorious autocompletion
_utils()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local utils_dir=$PHOME/utils/
    local utils_list=$(ls -1 -d ${utils_dir}*/| sed 's/\/$//' | sed 's/^\/home.*\///' | xargs);
    COMPREPLY=( $(compgen -W "${utils_list}" -- $cur) )
}

complete -F _lambdas gl invoke
complete -F _test_lambdas gtu tu
complete -F _utils gu
