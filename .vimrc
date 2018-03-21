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
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'kien/ctrlp.vim'
Plug 'luochen1990/rainbow'
Plug 'fatih/vim-go'
Plug 'maralla/completor.vim'

call plug#end()

" nerdtree
autocmd vimenter * NERDTree
map <C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" tagbar
autocmd vimenter * Tagbar
map <C-t> :TagbarToggle<CR>

" emmet
" let g:user_emmet_leader_key='<Tab>'

" ctrlp
let g:ctrlp_map = '<C-p>'

" rainbow
let g:rainbow_active = 1

" completor
let g:completor_gocode_binary = '/Users/mochen/go/bin/gocode'
let g:completor_node_binary = '/usr/local/bin/node'

if !empty(glob("src"))
  let $GOPATH=getcwd()
else
  let $GOPATH=go#path#Detect()
endif

let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_list_type = "locationlist"
let g:go_auto_type_info = 0
let g:go_info_mode = "guru"
let g:go_def_mode = "guru"
let g:go_echo_command_info = 1
let g:go_gocode_autobuild = 0
let g:go_gocode_unimported_packages = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
