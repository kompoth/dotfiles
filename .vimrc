" General
syntax on
set ruler
set number
set mouse=a
set nowrap
set t_Co=16 " better system colors

" Color patches
highlight Pmenu ctermfg=8 ctermbg=0
highlight PmenuSel ctermfg=15 ctermbg=6
highlight StatusLine ctermfg=11 ctermbg=0
highlight StatusLineNC ctermfg=8 ctermbg=0
highlight VertSplit ctermfg=8 ctermbg=0
highlight CursorLine cterm=none ctermfg=none 
highlight CursorLineNr term=bold ctermfg=3 ctermbg=none 
highlight LineNr ctermfg=8
set cursorline

" Indentation
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set autoindent

" Highlighting
set showmatch
set hlsearch
set incsearch
set ignorecase

" Python space display
autocmd FileType python setlocal list lcs=tab:>-,space:·

" Special wrapping for tex files
autocmd FileType tex setlocal wrap linebreak

" Splits
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Pathogen autoinstall
if empty(glob('~/.vim/autoload/pathogen.vim'))
  silent !curl -fLo ~/.vim/autoload/pathogen.vim --create-dirs
    \ https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
endif
execute pathogen#infect()

" Vimwiki autoinstall
if empty(glob('~/.vim/bundle/vimwiki'))
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/vimwiki/vimwiki.git ~/.vim/bundle/vimwiki
endif

" Vimwiki (install it first)
let wikilist = {}
let wikilist.path = '~/creative/wiki/vim'
let wikilist.path_html = '~/creative/wiki/html'
let wikilist.template_path = '~/creative/wiki/templates'
let wikilist.template_default = 'default'
let wikilist.template_ext = '.html'
let g:vimwiki_list = [wikilist]

" Special rules for wiki files
autocmd BufEnter *.wiki setlocal wrap linebreak
autocmd BufEnter *.wiki imap -- —
autocmd BufEnter *.wiki set nocompatible
autocmd BufEnter *.wiki filetype plugin on
autocmd BufEnter *.wiki syntax on
