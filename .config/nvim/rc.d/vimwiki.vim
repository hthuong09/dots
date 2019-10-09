" https://dev.to/konstantin/taking-notes-with-vim-3619

autocmd FileType vimwiki set ft=markdown

let g:vimwiki_list = [{
    \ 'path': '~/docs/notes/',
    \ 'syntax':'markdown',
    \ 'ext': '.md',
    \ 'nested_syntaxes': {'js': 'javascript', 'javascript': 'javascript'}
    \ }]
