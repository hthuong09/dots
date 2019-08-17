if &compatible
    set nocompatible
endif

let $VIM_PATH = expand('<sfile>:p:h')

source $VIM_PATH/plugins.vim

" Load settings
for g:rc in split(glob('$VIM_PATH/rc.d/*.*vim'), '\n')
  exec 'source' rc
endfor
