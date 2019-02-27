# prompt before every removal and explain what is being done
alias rm="rm -vi"

# print disk usage with human-readable size format
alias df='df -h'

# print estimate file space usage with human-readable size format and total size
alias du='du -c -h'

# print memory information with human-readable size
alias free='free -m'

# create parent directory if needed, show being created directory
alias mkdir='mkdir -p -v'

# less is better than more
alias more='less'

# ping 5 times and stop
alias ping='ping -c 5'

# fast clear screen
alias c='clear'

# sudo pacman
alias pacman='sudo pacman'

# show colour list
showcolours() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
    $reset
}

# Goes up many dirs as the number passed as argument, if none goes up by 1 by default
up() {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [[ -z "$d" ]]; then
        d=..
    fi
    cd $d
}

alias weather='curl wttr.in/Thu%20Duc'

# Get directory size
dirsize () {
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    \rm -rf /tmp/list # ignore alias, don't let it show removed file
}

# Automatic show directory content when changed directory to
_current_shell=$(ps | grep `echo $$` | awk '{ print $4 }')
if [ "$_current_shell" = "zsh" ]; then
    function chpwd() {
        emulate -L zsh
        ls -a
    }
elif; then
    cd() {
        builtin cd "$@" && ls -a
    }
fi

# Backup a file
backup() { cp -r "$1"{,.bak};}

# Create new folder and change working directory to new created directory
mkcd() {
    mkdir -p "$1";
    \cd "$1"
}

# # FIND A FILE WITH A PATTERN IN NAME {{{
# ff() { find . -type f -iname '*'$*'*' -ls ; }
# # FIND A FILE WITH PATTERN $1 IN NAME AND EXECUTE $2 ON IT {{{
# fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
# # copy with progress bar
#alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
