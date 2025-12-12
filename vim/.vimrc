set scrolloff=8
set number
set rnu

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

set termguicolors
color andromeda

filetype plugin indent on
syntax on

let mapleader = " "

nnoremap <leader>e :Ex<CR>
nnoremap <leader>ev :Vex<CR>
nnoremap <leader><CR> :so ~/.vimrc<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-pv> :Files<CR>
