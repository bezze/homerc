# PS4='+ $(date "+%s.%N")\011 '
# exec 3>&2 2>/tmp/bashstart.$$.log
# set -x
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion


# Adds vim as default editor
export VISUAL=vim
export TERMCMD=termite
export EDITOR="$VISUAL"
export BROWSER="qutebrowser" #"chromium"
# export MPD_HOST=$(ip -o -4 addr | grep wlp0s2f1u8 | awk '{print $4}' | grep --color=never -o -E "\w*\.\w*\.\w*\.\w*")
# export MPD_PORT="6603"

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

alias ls='ls --color=auto -h'
alias l="ls -GghB --group-directories-first"
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less
alias links='links duckduckgo.com'
alias vmd='vmd -xyz'
alias trad=translate-shell
alias v='nvim '
alias vp='v PKGBUILD'
alias vs='v -S Session.vim'
alias vashrc='v ~/.bashrc'
alias vimedit='v ~/.config/nvim/init.vim'
alias vimi3='v ~/.config/i3/config'
alias sctl='systemctl '
alias rtv='rtv --enable-media'
alias sudo='sudo '
alias sdn='sudo shutdown now'
alias r='ranger'
alias ..='cd ..'
alias ...='cd ../..'
alias pdf='qpdfview'

alias chgrp="chgrp --preserve-root"
alias chmod="chmod --preserve-root"

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

source ~/.PS1-$USER
# if [[ ${EUID} == 0 ]] ; then
#     PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
# else
# export PS1="\[$(tput bold)\]\[$(tput setaf 4)\]┏[\[$(tput setaf 5)\]\w\[$(tput setaf 4)\]]\n┗╾{\[$(tput setaf 7)\]\u\[$(tput setaf 4)\]\[$(tput bold)\]}╼(\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
#     # PS1='\[\033[01;36m\][\[\033[01;34m\]\u@\h\[\033[01;37m\] \W\[\033[01;34m\]\[\033[01;36m\]]\$\[\033[00m\] '
# fi

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

SCRIPTDIR=/home/teseo/Scripts
export PATH=$PATH:$SCRIPTDIR
for folder in $(ls -d $SCRIPTDIR/*/)
do
    export PATH=$PATH:$folder
done

# [[ $DISPLAY ]] && capscape

#-------------------------------------------------------------------------------
# Mark/Jump functions
#-------------------------------------------------------------------------------
export MARKPATH=$HOME/.marks
jump ()
{
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
mark ()
{
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
unmark ()
{
    rm -i "$MARKPATH/$1"
}
marks ()
{
    \ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
alias j='jump'
_completemarks() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}
complete -F _completemarks jump unmark j
#-------------------------------------------------------------------------------
# Eternal bash history.
#-------------------------------------------------------------------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#-------------------------------------------------------------------------------

# Pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export RANGER_LOAD_DEFAULT_RC=FALSE

# source /opt/intel/composer_xe_2013.1.117/bin/compilervars.sh intel64
export PATH=$PATH:/opt/esp-open-sdk/xtensa-lx106-elf/bin

source ~/Scripts/termite_colorscheme_completion
