set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
" === Plugins! ===

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup'
Plugin 'junegunn/fzf'
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'valloric/youcompleteme'
Plugin 'airblade/vim-gitgutter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set clipboard=unnamedplus,unnamed,autoselect

" Switch on NERDTree by default
autocmd VimEnter * NERDTree

" Switching features of VIM
syntax enable

set smartindent
set autoindent
set cindent
set expandtab
set smartcase
set modeline
set tabstop=4
set secure
set foldmethod=indent
set nofoldenable
set number
set diffopt+=vertical

autocmd BufRead,BufNewFile * set signcolumn=yes
autocmd FileType tagbar,nerdtree set signcolumn=no

" Removing leading and trailing whitespaces before read and write
autocmd BufReadPre * :%s/\s\+$//e
autocmd BufWritePre * :%s/\s\+$//e

" no bells
set noerrorbells
set novisualbell

" YouCompleteMe closes after complettion
let g:ycm_autoclose_preview_window_after_completion = 1