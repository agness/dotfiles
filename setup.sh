#!/bin/bash

## This script creates symlinks or copies

DIR=~/dotfiles
OLD_DIR=~/dotfiles.old #backup
LN_FILES="emacs.d/init.el gitignore atom/config.cson atom/package.list"
CP_FILES="ssh/config zshrc gitconfig"

echo -n "Creating $OLD_DIR backup of any existing dotfiles in home directory ... "
mkdir -p $OLD_DIR
echo "Done."

cd $DIR
for file in $LN_FILES; do
    if [ -f ~/.$file ];
    then
	echo "Moving existing ~/.$file to $OLD_DIR."
	mv ~/.$file $OLD_DIR
    fi
    echo "Creating symlink from ~/.$file to $DIR/$file.\n"
    ln -s $DIR/$file ~/.$file
    done

for file in $CP_FILES; do
    if [ -f ~/.$file ];
    then
	echo "Moving existing ~/.$file to $OLD_DIR."
	mv ~/.$file $OLD_DIR
    fi
    echo "Copying file from $DIR/$file to ~/.$file.\n"
    cp $DIR/$file ~/.$file
    done
