autocmd!

let mapleader = ","
let maplocalleader = "\\"

set cmdheight=2
set wildmode=longest,list
set foldlevel=3
set nolist eol
set whichwrap+=<,>,h,l
filetype plugin on
filetype indent on
set autoread
set incsearch
set nocompatible
set tw=80
set showtabline=2
set et
set ts=2
set sw=2
syntax on
set ff=unix
set autoindent
set history=400
set ruler
set number
set laststatus=2
set statusline=%t%(\ [buf:\ %n%M]%)%(\ %H%R%W%)\ %L\ lines\ \|\ scroll:\ %P\ \|\ [cursor]\ %(col:\ %c,\ byte:\ #%o,\ val:\ %b=0x%B%)
set hidden

set modeline

autocmd BufEnter * set mouse=

set cursorline
hi  cursorline   cterm=none
hi  cursorlinenr term=bold ctermfg=white

"colorscheme elflord
"" EXPERIMENTAL:
" freya
" Tomorrow-Night-Eighties
" jellybeans
" " specific to 'jellybeans':
" " highlight LineNr ctermfg=grey ctermbg=black
" hornet
" graywh
" mustang " no cursor
" freya
" tir_black

" always jump to last position in file, see :help last-position-jump
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"highlight redundant whitespace.
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

if v:version >= 703
  " creates *constant* long-line marker with columns color
  " set colorcolumn=+1,+2,+3

  augroup color_tweak
    autocmd!
    autocmd ColorScheme * highlight clear ColorColumn
    autocmd ColorScheme * highlight ColorColumn guifg=red ctermfg=red gui=bold
  augroup END
endif

" no need to 'q:' anymore
nnoremap ; :
