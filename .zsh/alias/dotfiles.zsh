alias dotsinit='git init --bare $HOME/.gdots'
alias dots='git --git-dir=$HOME/.gdots/ --work-tree=$HOME'
alias dots-load-submodules='dots submodule update --init --recursive $HOME/'
dots config status.showUntrackedFiles no


