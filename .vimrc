" Get ready for awesome stuff
set nocompatible

" ================ General Config ====================

set number                      " Line numbers are good
:set expandtab                   " Use spaces instead of tabs
set smarttab                    " Be smart when using tabs ;)
set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                " Store lots of :cmdline history
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set gcr=a:blinkon0              " Disable cursor blink
set visualbell                  " No sounds
set autoread                    " Reload files changed outside vim
set nowrap                      " Don't wrap lines
set linebreak                   " Wrap lines at convenient points
set encoding=utf-8              " Yes, we can
set spell spelllang=en_us       " Finding misspelled words
set scrolloff=5                 " Leave 5 lines of buffer when scrolling
set sidescrolloff=10            " Leave 10 characters of horizontal buffer when scrolling
set tabstop=2                   " 
set shiftwidth=2                " 
set expandtab                   " 

" ================ Remap keys ========================
inoremap jk <ESC>
let mapleader = " "

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Turn on syntax highlighting
syntax on

" =============== Vim Plug Initialization ===============
call plug#begin()

Plug 'tpope/vim-sensible'

" Night Owl 
Plug 'haishanh/night-owl.vim'

" A light and configurable statusline/tabline plugin for Vim 
Plug 'itchyny/lightline.vim'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Fuzzy search 
Plug 'kien/ctrlp.vim'

" Ack search
Plug 'mileszs/ack.vim'

" Dockerfile syntax
Plug 'ekalinin/Dockerfile.vim'

call plug#end()

" ================ Colors ============================
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme night-owl

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "don't fold by default


" ================ Lightline =========================
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'nightowl' }

" ================ NerdTree ==========================
" Open the tree with ctrl+O
map <C-o> :NERDTreeToggle<CR>
" Show dotfiles
let NERDTreeShowHidden=1

" ================ CtrlP ==============================
let g:ctrlp_show_hidden = 1

