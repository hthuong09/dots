case $(uname) in
  'Linux')   LS_OPTIONS='-hF --color=auto --group-directories-first' ;;
  'Darwin')  LS_OPTIONS='-hG' ;;
esac
# ls with color, human-readable size, indicator, with directory display first
alias ls='ls $LS_OPTIONS'

# list subdirectories recursively
alias lr='ls -R'

# list all hidden file with long listing format
alias ll='ls -al'

# list all hidden file with long listing format without list implied . and ..
alias la='ll -A'

# list all hidden file with long listing format without list implied . and .., page through text one screenful at a time
alias lm='la | less'

alias l=ls
