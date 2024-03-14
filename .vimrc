" .vimrc "
" I prefer to use nvim, but I have to use vim in some cases, so I keep the same configuration for both
set nocompatible
filetype off
filetype plugin on
filetype indent on
syntax on

set cursorline

set number
set shiftwidth=4
set tabstop=4
set expandtab

set showmode
set showmatch
set hlsearch

set history=30

set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

let g:vimtex_quickfix_mode=0
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
            \ 'options' : ['--shell-escape'],
            \}

" Pluggins "

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" call plug#begin('~/.vim/plugged')
" Plugin 'tpope/vim-surround'
" Plugin 'preservim/nerdtree'
" Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
" Plugin 'ycm-core/YouCompleteMe'
Plugin 'lervag/vimtex'
" Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plugin 'dense-analysis/ale'
Plugin 'mcchrish/nnn.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'github/copilot.vim'
" call plug#end()
call vundle#end()
filetype plugin indent on

" Config "
let g:ale_linters={
\ 'python': ['pylint'],
\}
