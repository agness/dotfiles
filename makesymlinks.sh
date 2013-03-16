#!/bin/bash

## This script creates symlinks from the home directory for each dotfile in ~/dotfiles

DIR=~/dotfiles
OLD_DIR=~/dotfiles.old #backup
FILES="emacs.d bash_profile"

echo -n "Creating $OLD_DIR backup of any existing dotfiles in home directory ... "
mkdir -p $OLD_DIR
echo "Done."

cd $DIR
for file in $FILES; do
    if [ -f ~/.$file ];
    then
	echo "Moving existing ~/.$file to $OLD_DIR."
	mv ~/.$file $OLD_DIR
    fi
    echo "Creating symlink from ~/.$file to $DIR/$file."
    ln -s $DIR/$file ~/.$file
    done
