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


[1]: https://github.com/Lokaltog/powerline-fonts
