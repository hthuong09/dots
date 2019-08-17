" These settings are generally for autocomplete and snippets
" But since there are conflict in keymap settings with some plugins, settings were moved here.
" Conflict plugins:
" - rstacruz/vim-closer
" - Shougo/neosnippet.vim
" - neoclide/coc.nvim

" Magic Tab
" 1. If autocomplete popup is display, jump to next suggestion
" 2. Otherwise, if neosnippet is expandable or jumpable, execute it
" 3. Otherwise, just add normal \t
" Note: this require neosnippet.vim
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" If neosnippet is not enabled, use this instead
" imap <expr><TAB> pumvisible() ? "\<C-n>" :"\<TAB>"

" Enter to select autocomplete option
" This require vim-closer
" imap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR><Plug>CloserClose"
" If vim-closer is not enabled, use this instead
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Esc to cancel autocomplete
inoremap <expr><Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
