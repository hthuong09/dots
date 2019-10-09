" Genaral settings, vim settings only, no plugin settings

" Required:
filetype plugin indent on

" Default encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Improve responsiveness of plugins that depend on this
set updatetime=750

" Lines of history to remember
set history=500

" Using soft tab
set tabstop=4
set shiftwidth=4
set expandtab

" Show line number, relative
set number
set relativenumber

" Wildmenu, autocomplete for command
set wildmenu
" set wildmode=longest:list,full

" Redraw only when we need to
set lazyredraw

" Search tweaks
set hlsearch
set incsearch
set ignorecase
set smartcase

" Auto indent
set autoindent

set nowrap
"set linebreak

" Hidden buffer
set hidden

" No backup and swap files
set nobackup
set nowritebackup
set noswapfile

" More natural split
set splitbelow
set splitright

" Line height
set linespace=3

" Folding
set foldmethod=marker

" Invisible characters
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:¬

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" Use system clipboard
set clipboard^=unnamedplus

" Set backups
" set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
" set backup
" set noswapfile
