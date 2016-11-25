"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/eodos/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/eodos/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

call dein#add('altercation/vim-colors-solarized')
call dein#add('mhartington/oceanic-next')
call dein#add('kien/rainbow_parentheses.vim')


" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" source $HOME/.config/nvim/bundles.vim
source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/map.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/autocmd.vim
