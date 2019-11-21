" Get ready for awesome stuff
set nocompatible

" ================ General Config ====================

set number                      "Line numbers are good
set expandtab                   "Use spaces instead of tabs
set smarttab                    "Be smart when using tabs ;)
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set nowrap                      "Don't wrap lines
set linebreak                   "Wrap lines at convenient points
set encoding=utf-8              "Yes, we can
set spell spelllang=en_us       "Finding misspelled words

" ================ Remap keys ========================
inoremap jk <ESC>
let mapleader = " "

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" =============== Vim Plug Initialization ===============
call plug#begin()

" Hybrid color scheme
Plug 'w0ng/vim-hybrid'

Plug 'tpope/vim-sensible'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

call plug#end()

" ================ Colors ============================
set background=dark
colorscheme hybrid

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
