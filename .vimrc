" General
syntax on
set ruler
set number
set mouse=a
set nowrap
set t_Co=16 " better system colors

" Configure colorscheme 
hi clear CursorLine
hi CursorLineNr term=bold cterm=bold ctermfg=3 ctermbg=none 
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

" Python settings
autocmd FileType python setlocal list lcs=tab:>-,space:·
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4

" Special wrapping for tex files
autocmd FileType tex setlocal wrap linebreak

" Spellchecker
set spelllang=en_us,ru
set spellfile=~/.vim/spell/custom.utf-8.add
autocmd FileType tex setlocal spell

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

" Plugins autoinstall
if empty(glob('~/.vim/bundle/vimwiki'))
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/vimwiki/vimwiki.git ~/.vim/bundle/vimwiki
endif

" Vimwiki (install it first)
let mywiki = {}
let mywiki.path = '~/mywiki/wiki'
let mywiki.path_html = '~/mywiki/html'
let mywiki.template_path = '~/mywiki/templates'
let mywiki.template_default = 'default'
let mywiki.template_ext = '.html'
let g:vimwiki_list = [mywiki]

let g:vimwiki_diary_months = {
    \1: 'Январь', 2: 'Февраль', 3: 'Март', 4: 'Апрель', 5: 'Май',
    \6: 'Июнь', 7: 'Июль', 8: 'Август', 9: 'Сентябрь', 10: 'Октябрь',
    \11: 'Ноябрь', 12: 'Декабрь'
  \}
let g:vimwiki_toc_header = "Содержание"

" Special rules for wiki files
autocmd BufEnter *.wiki setlocal wrap linebreak
autocmd BufEnter *.wiki imap -- —
autocmd BufEnter *.wiki set nocompatible
autocmd BufEnter *.wiki filetype plugin on
autocmd BufEnter *.wiki syntax on
