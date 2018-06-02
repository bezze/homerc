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
# export PYTHONSTARTUP=$HOME/.config/python3/pythonstartup
#/usr/bin/firefox

# xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

alias ls='ls --color=auto -h'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='vim PKGBUILD'
alias more=less
alias links='links duckduckgo.com'
alias vmd='vmd -xyz'
alias trad=translate-shell
alias ncmpcpp-local='ncmpcpp -h 192.168.1.4 -p 6604'
alias mpc-local='mpc -h 192.168.1.4 -p 6604'
alias vashrc='vim ~/.bashrc'
alias vimedit='vim ~/.vimrc'
alias vimi3='vim ~/.config/i3/config'
alias sctl='systemctl'
alias rtv='rtv --enable-media'
alias sudo='sudo '
alias sdn='sudo shutdown now'
alias r='ranger'
alias ..='cd ..'
alias ...='cd ../..'
alias pdf='qpdfview'

alias chgrp="chgrp --preserve-root"
alias chmod="chmod --preserve-root"

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

use_color=true #false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == $'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;36m\][\[\033[01;34m\]\u@\h\[\033[01;37m\] \W\[\033[01;34m\]\[\033[01;36m\]]\$\[\033[00m\] '
	fi

else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		#PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode    
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color

SCRIPTDIR=/home/teseo/Scripts
export PATH=$PATH:$SCRIPTDIR
for folder in $(ls -d $SCRIPTDIR/*/)
do
    export PATH=$PATH:$folder
done

# [[ $DISPLAY ]] && capscape

# Mark/Jump functions
# ---------------------
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
# ---------------------

# Eternal bash history.
# ---------------------
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
# ---------------------

# Pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export RANGER_LOAD_DEFAULT_RC=FALSE

# source /opt/intel/composer_xe_2013.1.117/bin/compilervars.sh intel64
