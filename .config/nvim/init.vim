let mapleader=","
nmap <silent> <leader>ev :e $MYVIMRC<CR>

set hidden
set nowrap
set tabstop=4
set expandtab
set autoindent
set copyindent
set number
set shiftwidth=4
set shiftround
set showmatch
set smartcase
set smarttab
set incsearch
set history=100
set undolevels=100
set title
set novisualbell
set noerrorbells
set nobackup
set noswapfile
set colorcolumn=80
set showcmd
set diffopt+=vertical

set backspace=indent,eol,start
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set nohlsearch
nnoremap <silent> <leader>h :set hlsearch!<CR>
nnoremap <silent> <leader>u gUawe
inoremap <silent> <C-U> <Esc>gUawea
inoremap <silent> <C-L> <Esc>guawea
