# ls with color, human-readable size, indicator, with directory display first
alias ls='ls -hF --color=auto --group-directories-first'

# list subdirectories recursively
alias lr='ls -R'

# list all hidden file with long listing format
alias ll='ls -al'

# list all hidden file with long listing format without list implied . and ..
alias la='ll -A'

# list all hidden file with long listing format without list implied . and .., page through text one screenful at a time
alias lm='la | less'

alias l=ls
