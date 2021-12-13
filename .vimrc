set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'flazz/vim-colorschemes'

Plugin 'Quramy/tsuquyomi'

Plugin 'preservim/nerdtree'

Plugin 'kien/ctrlp.vim'

Plugin 'dense-analysis/ale'

Plugin 'ycm-core/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

set ruler
set splitbelow
set splitright
colorscheme molokai
set runtimepath^=~/.vim/bundle/ctrlp.vim
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = '/usr/local/bin/ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore review
      \ -g ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
set background=dark
set t_Co=256

map <C-n> :NERDTreeToggle<CR>

" NOTE: update this to point to your discord root directory
let s:discoHome = $HOME . 'discord'

func! s:OnFormatted(tempFilePath, _buffer, _output)
    return readfile(a:tempFilePath)
endfunc

func! FormatDiscoPython(buffer, lines) abort
    " NOTE: clid's python format will ONLY operate correctly on a file
    " if it lives in the same discord repo root that clid does, so
    " we have to manually create the temp file/directory here:

    let dir = s:discoHome . '/.ale-tmp'
    if !isdirectory(dir)
        call mkdir(dir)
    endif
    call ale#command#ManageDirectory(a:buffer, dir)

    " this may be overkill, but just in case:
    let filename = localtime() . '-' . rand() . '-' . bufname(a:buffer)
    let path = dir . '/' . filename
    call writefile(a:lines, path)

    let blackw = s:discoHome . '/tools/blackw'
    let command = blackw . ' ' . path
    return {
        \ 'command': command,
        \ 'read_buffer': 0,
        \ 'process_with': function('s:OnFormatted', [path]),
        \ }
endfunc

call ale#fix#registry#Add('clid-format', 'FormatDiscoPython', ['python'], 'clid formatting for python')
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2
