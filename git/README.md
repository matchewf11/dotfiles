# This is from CHATGPT (look into this stuff)

## Starters

Rebase by default
Default branch name
default editor

## Aliases

Don't set thru zsh

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm "commit -m"
git config --global alias.lg "log --oneline --graph --decorate --all"

## Default push behavior

Push only to your current branch (not all matching)

git config --global push.default current

## Color Output

git config --global push.default current

## Safer Force Push

git config --global push.autoSetupRemote true
git config --global alias.fp "push --force-with-lease"

## Look For others
