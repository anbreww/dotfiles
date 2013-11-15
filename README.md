# Andrew's dotfile repository.

Various personal scripts and helpers for my day-to-day linux adventures

## How to use

Init repo in your home

  cd ~
  git clone git@github.com:tunebird/dotfiles.git

Then symlink the required dotfiles from home

  ln -s ~/dotfiles/vimrc .vimrc
  ln -s ~/dotfiles/vim .vim

See `install.rb` which I haven't touched since I started the repo.
I'll probably write a quick python script when I have the time...

## Vim submodules

Vim packages are installed using vim-fugitive. They get installed into
`~/.vim/bundle/` and are autoloaded.

To make versioning easier, each bundle is a submodule. To auto-install
all previous bundles:

  cd ~/dotfiles
  git submodule init
  git submodule update

TODO : update install script to check for existing files, prompt to backup, and create symlinks if they don't already exist
