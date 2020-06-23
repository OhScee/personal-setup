" helper functions
" files, backups and undo
source ~/.vim/general.vim
source ~/.vim/backup.vim " text, tab etc
source ~/.vim/text.vim

source ~/.vim/functions.vim

if &compatible
  set nocompatible
endif

" for kitty terminal
let &t_ut=''

" Load packager only when you need it
function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

" Language Server Auto Complete
  call packager#add('neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' })

  " Typescript tools
  " Yet another typescript plugin
  call packager#add('HerringtonDarkholme/yats.vim')

  " React tools
  " ReactJS JSX syntax highlighting
  call packager#add('mxw/vim-jsx')

  " Linting defaults xo ;3 - needs global xo
  call packager#add('xojs/vim-xo')

  " Show file tree
  " Show git status in files
  call packager#add('scrooloose/nerdtree')
  call packager#add('Xuyuanp/nerdtree-git-plugin')

  " Quick comment out
  call packager#add('tpope/vim-commentary')

  " Show hex colors in stylesheets
  call packager#add('etdev/vim-hexcolor')

  " Search functionality
  call packager#add('airblade/vim-gitgutter', {'do:': './install.sh'})
  call packager#add('ctrlpvim/ctrlp.vim')
  " Close html tags
  " call packager#add('alvan/vim-closetag')
  " Close brackets and such
  " BLESS
  call packager#add('cohama/lexima.vim')

  " Test runner and dispatcher
  call packager#add('tpope/vim-dispatch')

  " React
  " call 'ianks/vim-tsx'

  " For C#
  call packager#add('OmniSharp/omnisharp-vim')

endfunction

" COC INSTALL
function! InstallCoc(plugin) abort
 exe '!cd '.a:plugin.dir.' && yarn install --frozen-lockfile'
 call coc#add_extension('coc-tsserver', 'coc-json', 'coc-tslint', 'coc-eslint', 'coc-html', 'coc-css', 'coc-angular', 'coc-omnisharp')
endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

"Load plugins only for specific filetype
augroup packager_filetype
  autocmd!
  autocmd FileType javascript packadd vim-js-file-import
  autocmd FileType go packadd vim-go
  autocmd FileType php packadd phpactor
augroup END

" Load plugins only for specific filetype
augroup packager_filetype
 autocmd!
 autocmd FileType javascript packadd vim-js-file-import
 autocmd FileType go packadd vim-go
 autocmd FileType php packadd phpactor
augroup END

" COC tab-complete
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
 let col = col('.') - 1
 return !col  getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
   \ pumvisible() ? "<C-n>" :
   \ <SID>check_back_space() ? "<Tab>" :
   \ coc#refresh()

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

nmap <silent> <C-e> <Plug(coc-diagnostic-prev)>
nmap <silent> <C-r> <Plug>(coc-diagnostic-next)

" NerdTREE related
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
hi Directory guifg=#FF0000 ctermfg=red

" gitgutter related
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = 'x'
let g:gitgutter_sign_removed_first_line = '^x'
let g:gitgutter_sign_modified_removed = '~x'

" OmniSharp (C#) related
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_highlight_types = 3

" CtrlP related
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
