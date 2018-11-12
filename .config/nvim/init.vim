call plug#begin()

Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'tyrannicaltoucan/vim-quantum'
Plug 'lifepillar/vim-solarized8'

Plug 'cespare/vim-toml'
Plug 'treycordova/rustpeg.vim'
Plug 'posva/vim-vue'

Plug 'vim-airline/vim-airline'

call plug#end()

set termguicolors
colorscheme quantum
set background=dark

nnoremap <f12> :call LanguageClient_contextMenu()<cr>
nnoremap <f2> :call LanguageClient_textDocument_rename()<cr>
nnoremap ;t :call LanguageClient_textDocument_hover()<cr>
nnoremap ;d :call LanguageClient_textDocument_definition()<cr>
nnoremap ;i :call LanguageClient_textDocument_implementation()<cr>
nnoremap ;r :call LanguageClient_textDocument_references()<cr>
nnoremap <c-p> :GFiles<cr>
nnoremap <c-g> :Rg 

set so=10
set number
set relativenumber

syntax on
filetype on
filetype plugin on
filetype indent on

set lcs=tab:→-,trail:·,nbsp:_
set list

set autoindent
set copyindent
set modeline

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smartindent
set nofoldenable
set foldmethod=syntax

set showmatch
set matchtime=0
set nobackup
set nowritebackup
set noswapfile

set fileencoding=utf-8
set wrap
set linebreak
set lazyredraw

set backspace=indent,eol,start

set smartcase
set ignorecase
set nohlsearch
set incsearch

set splitright
set splitbelow
set path+=**
set pumheight=30
set exrc
set secure
set tagcase=smart

set mouse=a

vmap j gj
vmap k gk
nmap j gj
nmap k gk

nmap <C-h> <C-w><C-h>
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-l> <C-w><C-l>

nmap <C-space> :FZF<cr>
nmap ;q :q<cr>
nmap ;<cr> :nohl<cr>
nmap ;c :pc<cr>

imap <C-j> <C-n>
imap <C-k> <C-p>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

cnoremap mk. !mkdir -p <C-r>=expand("%:h")<cr>/

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

set fillchars+=vert:│

set hidden
set lazyredraw
let g:LanguageClient_serverCommands = {
	\ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['~/.local/bin/pyls']
	\ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_settingsPath = '/home/bartlomiejkuras/.config/nvim/language_client.json'
let g:rust_doc#downloaded_rust_doc_dir = '~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/'

set completefunc=LanguageClient#complete

command ReloadConfig source \~/\.config/nvim/init.vim
set diffopt+=vertical

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 5)

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


