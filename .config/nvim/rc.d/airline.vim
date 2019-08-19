" Vim Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'oceanicnext'
let g:airline_left_sep = '▓▒░'
let g:airline_right_sep = '░▒▓'

let g:airline#extensions#tabline#left_sep = '▓▒░'
let g:airline#extensions#tabline#left_alt_sep = '▒'

" coc-git status line
let g:airline_section_b = "%{get(g:,'coc_git_status','')} ▒%{get(b:,'coc_git_status','')}"
