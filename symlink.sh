#!/bin/bash
## Create symlinks from the home directory

DIR=~/dotfiles
OLD_DIR=~/dotfiles.old
FILES="emacs.d/init.el
       ssh/config
       ssh/id_rsa.pub
       bash_profile
       gitignore
       gitconfig"

echo -n "Creating $OLD_DIR backup folder for any existing dotfiles..."
mkdir -p $OLD_DIR

cd $DIR
for file in $FILES; do
  if [ -f ~/.$file ]; then
	  echo "Moving existing ~/.$file to $OLD_DIR."
	  mv ~/.$file $OLD_DIR/$file
  fi
  echo "Creating symlink from ~/.$file to $DIR/$file."
  ln -s $DIR/$file ~/.$file
  done

MOTD=/etc/motd
ln -s $MOTD $DIR$MOTD
