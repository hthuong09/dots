" Load plugin settings
for g:rc in split(glob('$VIM_PATH/rc.d/plugins/*.vim'), '\n')
  exec 'source' rc
endfor
