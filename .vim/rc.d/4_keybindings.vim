" Change map leader to ,
let mapleader = ','

" Saving files
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Quitting files
noremap <C-q> :q<CR>
inoremap <C-q> <Esc>:q<CR>

" Close buffer
nnoremap <leader>q :bp<cr>:bd #<cr>
" nnoremap <C-w> :bp<cr>:bd #<cr>
nnoremap <leader>Q :bp<cr>:bd! #<cr>

" Switching buffers
nnoremap <C-l> <Esc>:bnext<CR>
nnoremap <C-h> <Esc>:bprevious<CR>

" Disable arrow key
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Magic tab
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"
" Enter to select autocomplete option
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"
" Esc to cancel autocomplete
inoremap <expr><Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

" Clear search
nnoremap <leader><space> :nohlsearch<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>


map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
