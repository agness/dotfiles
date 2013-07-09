Dotfiles
========
Personal config files for Terminal, Emacs, etc.  Expects to be on local disk path `~/dotfiles/`.  Includes setup script to automatically create symlinks from `~/dotfiles/` to expected config locations.

Installation
------------

``` bash
git clone git://github.com/kradeki/dotfiles ~/dotfiles
cd ~/dotfiles
./makesymlinks.sh
```

Emacs
------------
Check `user-init-file` variable contents with `C-h v`

  *  Expect OS X file to be `~/.emacs.d/init.el`
  *  Expect Ubunto file to be `~/.emacs`