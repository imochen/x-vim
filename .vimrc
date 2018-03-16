set nu " 显示行号
syntax on " 语法高亮

set nocompatible " 关闭vi兼容模式
set backspace=indent,eol,start " 退格删除

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab " tab替换为空格


set autoread " 当文件在外部被修改，自动更新
set autoindent " 自动缩进

filetype plugin indent on

" Plug插件管理
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'kien/ctrlp.vim'
Plug 'luochen1990/rainbow'

call plug#end()

" nerdtree
autocmd vimenter * NERDTree
map <C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" tagbar
autocmd vimenter * Tagbar
map <C-t> :TagbarToggle<CR>

" emmet
let g:user_emmet_leader_key='<Tab>'

" ctrlp
let g:ctrlp_map = '<C-p>'

" rainbow
let g:rainbow_active = 1

