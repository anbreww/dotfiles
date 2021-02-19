# Andrew's dotfile repository.

Various personal scripts and helpers for my day-to-day linux adventures

## How to use

Init repo in your home and run the install script

    cd ~
    git clone git@github.com:tunebird/dotfiles.git
    ./install

Or alternatively, manually symlink the required dotfiles from home

    ln -s ~/dotfiles/vimrc .vimrc
    ln -s ~/dotfiles/vim .vim


## Vim submodules

(note: this is now handled by dotbot. It will init and update all git
submodules when invoked)

Vim packages are installed using vim-fugitive. They get installed into
`~/.vim/bundle/` and are autoloaded.

To make versioning easier, each bundle is a submodule. To auto-install
all previous bundles:

    cd ~/dotfiles
    git submodule init
    git submodule update


To add a submodule for a vim bundle :

    cd ~/dotfiles
    git submodule add https://github.com/user/repo.git vim/bundle/name

## Terminal

A few things need to be adjusted for everything to look good.

### Encoding

The terminal must be set to UTF-8 and 256 color. In PuTTY,

    Translation > Remote Charset > UTF-8
    Colours > Allow terminal to use xterm 256-colour mode
    Connection Data > terminal-type string > "xterm-256color"

In addition, the host OS must be set to a UTF-8 locale ( `en_US.UTF-8` ).
GNU Screen must have been compiled with 256 colour support.

### Font

The `vim-powerline` add-on requires a patched font to display special symbols.
Install one from the [powerline-fonts][1] repository and set PuTTY to use it.

## Mac OS setup

### Install homebrew

run `brew_once.sh` to install homebrew and oh_my_zsh.

### Other programs

run brew bundle to install homebrew packages specified in the Brewfile


[1]: https://github.com/Lokaltog/powerline-fonts
