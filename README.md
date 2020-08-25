```
# Alias dots command
alias dots='git --git-dir=$HOME/.gdots/ --work-tree=$HOME'

# Install from git repository
git clone --recursive --separate-git-dir=$HOME/.gdots https://github.com/hthuong09/dots /tmp/dots
# -r, --recursive             recurse into directories
# -v, --verbose               increase verbosity
# -l, --links                 When symlinks are encountered, recreate the symlink on the destination.
rsync -rvl --exclude ".git" /tmp/dots/ $HOME/
rm -rf /tmp/dots
dots submodule update --init --recursive $HOME/
```
