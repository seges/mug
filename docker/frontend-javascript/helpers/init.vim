set number
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set nofoldenable

let g:mapleader = ','

filetype plugin on
set omnifunc=syntaxcomplete#Complete

call plug#begin(stdpath('data') . '/plugged')

Plug 'dense-analysis/ale'
Plug 'ctrlpvim/ctrlp.vim' 

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'vim-scripts/paredit.vim'

Plug 'icymind/NeoSolarized'

Plug 'plasticboy/vim-markdown'

call plug#end()

set termguicolors
set background=light
colorscheme NeoSolarized

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

let g:paredit_electric_return = 0

set wildignore+=*/node_modules/*

nnoremap <leader>ex :Explore<cr>
nnoremap <leader>hh :nohl<cr>
nnoremap <leader>ff :ALEFix<cr>

nnoremap <leader>ei :vsplit $MYVIMRC<cr>
nnoremap <leader>si :so $MYVIMRC<cr>
nnoremap <leader>= mlgg=G'l

nnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>p "+p
