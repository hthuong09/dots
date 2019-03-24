" Default encoding - Use UTF-8 without BOM
set encoding=utf8 nobomb

set runtimepath^=$VIM_PATH

filetype plugin indent on


" Improve responsiveness of plugins that depend on this
set updatetime=750

" Lines of history to remember
set history=500

" Using soft tab
set tabstop=2
set shiftwidth=2
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

"set nowrap
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

" Use system clipboard when in X session
if $DISPLAY
  set clipboard=unnamedplus
endif
