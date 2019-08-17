" Keybinding settings, vim settings only, no plugin settings

" Change map leader to space
let mapleader = ' '

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

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $
" disable $/^
nnoremap $ <nop>
nnoremap ^ <nop>

" Toggle conceal level
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Page up/Page down
nnoremap <silent> <leader>u <C-U>zz
nnoremap <silent> <leader>d <C->zz

