" Deoplete.
let g:deoplete#enable_at_startup = 1
set completeopt-=preview " no review windows
let g:deoplete#auto_complete_delay = 300
" deoplete-tern
"let g:tern_request_timeout = 1
"let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete
let g:deoplete#omni#functions = {}
"let g:deoplete#omni#functions.php = 'phpcomplete#CompletePHP'
let g:deoplete#omni#input_patterns = {}
"let g:deoplete#omni#input_patterns.php = '\w+|[^. \t]->\w*|\w+::\w*'

