call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tyrannicaltoucan/vim-quantum', { 'branch': 'new-styles' }
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'jacoborus/tender.vim'

Plug 'cespare/vim-toml'
Plug 'treycordova/rustpeg.vim'
Plug 'posva/vim-vue'

Plug 'vim-airline/vim-airline'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'mattn/emmet-vim'
Plug 'cakebaker/scss-syntax.vim'

call plug#end()

set termguicolors
colorscheme quantum
set background=dark

let g:airline_powerline_fonts = 1
let g:airline_theme = 'quantum'

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
nnoremap <c-p> :GFiles<cr>
nnoremap <c-g> :Rg 

nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> ;f <Plug>(coc-format-selected)

set cmdheight=2
set updatetime=300
set signcolumn=yes

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

nnoremap <silent> ;h :call <SID>show_documentation()<CR>
nnoremap <expr><J> coc#util#has_float() ? coc#util#float_scroll(1) : "\<J>"
nnoremap <expr><K> coc#util#has_float() ? coc#util#float_scroll(0) : "\<K>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

set fillchars+=vert:│

set hidden
set lazyredraw

command! ReloadConfig source \~/\.config/nvim/init.vim
set diffopt+=vertical

let g:airline#extensions#tabline#enabled = 1

set conceallevel=2

command E Ex

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key=','

highlight CocErrorHighlight gui=undercurl guisp=#dd7186
highlight CocWarningHighlight gui=undercurl guisp=#d7956e
highlight CocErrorSign guifg=#dd7186
highlight CocWarningSign guifg=#d7956e
highlight CocErrorFloat guifg=#dd7186
highlight CocWarningFloat guifg=#d7956e
highlight CocFloating guibg=#2c3a41
highlight clear Conceal
