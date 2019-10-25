#!/bin/bash

# Variables
CWD="$(pwd)"

# Pull submodules
git submodule init
git submodule update

# Let's create symlinks
ln -sfn "$CWD/vimrc" ~/.vimrc
ln -sfn "$CWD/vim/" ~/.vim
