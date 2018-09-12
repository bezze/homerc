source /etc/profile.d/vte.sh

## functions
cheat() { curl cheat.sh/$1; }; export -f cheat
fd() { find . -name "*$1*"; }; export -f fd
magiccards () { xdg-open "https://magiccards.info/query?q=${@/ /%20}&v=card&s=cname"; }; export -f magiccards
searchcites () { xdg-open "https://duckduckgo.com/?t=palemoon&q=$(xclip -selection clipboard -o)&ia=web"; }; export -f searchcites
ddgo () { xdg-open "https://duckduckgo.com/?t=palemoon&q=${1}&ia=web"; }; export -f ddgo
viwitch () { vim "$( which $1 )"; }; export -f viwitch
capscape () { setxkbmap -option caps:escape; }; export -f capscape
archwiki () { xdg-open "https://wiki.archlinux.org/index.php?search=${1}&title=Special%3ASearch&go=Go"; }; export -f archwiki
extip () {  wget -qO- www.icanhazip.com; }; export -f extip
pyprof () { pycallgraph graphviz -- "${@}"; }; export -f pyprof
genlib () { xdg-open "http://gen.lib.rus.ec/scimag/index.php?s=""${@/ /%20}"; }; export -f genlib
luckylib () { xdg-open "http://libgen.io/scimag/ads.php?doi=${@/ /%20}&downloadname="; }; export -f luckylib
w3msearch () { w3m "https://duckduckgo.com/?q=${@/ /%20}"; }; export -f w3msearch
weather () { curl -s wttr.in/Buenos\ Aires?0?q?T; }; export -f weather
vpnctl () { systemctl $1 openvpn-client@${2};}; export -f vpnctl
#vpnserverctl () { systemctl $1 openvpn-server@argo;}; export -f vpnserverctl
rebash () { source ~/.bashrc; source ~/.profile; }; export -f rebash
gt () { cd $(xclip -o 2> /dev/null); }; export -f gt
mpvyt () { mpv --ytdl-raw-options=retries=infinite --ytdl-format=${1} "${2}"; }; export -f mpvyt
function aw () { lynx /usr/share/doc/arch-wiki/html/en/; }; export -f aw
function prfind () { ps aux | grep "${@}"; }; export -f prfind
xevcodes () { xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'; }; export -f xevcodes
im2eps () { convert ${1} eps2:${1%%.*}.eps;  }; export -f im2eps
rusti () { rustup run nightly-2016-08-01 ~/.cargo/bin/rusti; }; export -f rusti
spsyu () { sudo pacman -Syu; }; export -f spsyu
sps () { sudo pacman -S ${1}; }; export -f sps
pss () { pacman -Ss "${1}"; }; export -f pss

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
}; export -f ex
