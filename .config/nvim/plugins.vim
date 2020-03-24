let pluggedFolder = $VIM_PATH . '/plugged'

" Auto download vim-plug and install plugin with :PlugInsall
" TODO: wrap with fold
let plugPath = $VIM_PATH. '/autoload/plug.vim'
let plugUrl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" Download vim-plug
if !filereadable(plugPath)
    if executable('curl')
        echo "Installing vim-plug\n"
        call system('curl -fLo ' . shellescape(plugPath) . ' --create-dirs ' . plugUrl)
        if v:shell_error
            echom "Failed to download vim-plug. Please install it manually.\n"
            exit
        endif
        " Auto install plugins
        autocmd VimEnter * PlugInstall
    else
        echom "vim-plug can't be installed. Please install it manually or install curl.\n"
        exit
    endif
endif

" Load plugins
call plug#begin(pluggedFolder)
" Colorscheme
Plug 'mhartington/oceanic-next'
" Plug 'chriskempson/base16-vim'

" Status bar
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Syntax higlighting
"" JavaScript, TypeScript and React (jsx)
" Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ekalinin/Dockerfile.vim'

"" CSS3
Plug 'hail2u/vim-css3-syntax'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release', 'do': { -> coc#util#install()}}

" " Auto close brackets
" Plug 'rstacruz/vim-closer'

" Fuzzy search
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" JSDocs generator
Plug 'heavenshell/vim-jsdoc'

" Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
Plug 'ConradIrwin/vim-bracketed-paste'

" Coding time log
Plug 'wakatime/vim-wakatime'

" Prevent press hjkl mutil times
" Plug 'takac/vim-hardtime'

" Comments
" - gcc to comment out a line (takes a count)
" - gc to comment out the target of a motion (for example, gcap to comment out a paragraph)
" - gc in visual mode to comment out the selection
" - gc in operator pending mode to target a comment.
" You can also use it as a command, either with a range like :7,17Commentary, or as part of a :global invocation like with :g/TODO/Commentary.
Plug 'tpope/vim-commentary'

" Surround
" s become surround operator, just like i for inisde/inner
Plug 'tpope/vim-surround'

" Faster movement
Plug 'easymotion/vim-easymotion'

" Sidebar tree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Icons
Plug 'ryanoasis/vim-devicons'

" Auto detect indent
Plug 'tpope/vim-sleuth'

" Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

call plug#end()
