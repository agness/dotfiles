Dotfiles
========
Personal config files for Terminal, Emacs, etc.  Expects to be on local disk path `~/dotfiles/`.  Includes setup script to automatically create symlinks from `~/dotfiles/` to expected config locations.

Installation
------------

``` bash
$ git clone git://github.com/kradeki/dotfiles ~/dotfiles
$ cd ~/dotfiles
$ sh setup.sh
$ git config --global core.excludesfile ~/.gitignore
# brew install bash-completion
```

Emacs
------------
Check `user-init-file` variable contents with `C-h v`

  *  Expect OS X file to be `~/.emacs.d/init.el`
  *  Expect Ubuntu file to be `~/.emacs`

Atom
------------
Install packages from list
``` bash
apm install --packages-file ~/.atom/package.list
```

Track installed packages
``` bash
apm list --installed --bare > ~/.atom/package.list
```
