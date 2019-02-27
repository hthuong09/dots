# Check if current distro is not Arch Linux
which pacman &>/dev/null || return 1
which yaourt &>/dev/null || return 1

# Sync db
alias psync='sudo pacman -Sy'
#
## Sync db and pgrade pacman package
alias pupgrade='sudo pacman -Syu'
#
## Upgrade yaourt package
alias yupgrade='yaourt -Syua --noconfirm'
#
## Upgrade both pacman and yaourt
alias fupgrade='pupgrade && yupgrade'

# Automatic detect and choose to use pacman or yaourt to install
pi() {
    # Print usage when no parameter was given
    if [[ -z $1 ]]; then
        echo "Usage: pinstall <package name>"
        return 1
    fi

    # If user install multiple package at once, then use yaourt instead
    if [[ $# -gt 1 ]]; then
        yaourt -S $*
        return 1
    fi

    # If user install one package. Check if it exist in official repository and user pacman, else user yaourt
    if [[ $(pacman -Sqs "$1" | grep -P "^${1}$") ]]; then
        sudo pacman -S $1
    else
        yaourt -S $1
    fi
}

# Remove package
alias pr='sudo pacman -R'

# Remove package and its unneeded dependencies
alias pu='sudo pacman -Rsnc'
