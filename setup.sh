#!/bin/bash

# Variables
CWD="$(pwd)"

# Let's create symlinks
ln -sfn "$CWD/vimrc" ~/.vimrc
ln -sfn "$CWD/vim/" ~/.vim
