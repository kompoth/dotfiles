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
set shiftwidth=4
set softtabstop=4
set expandtab
set nosmarttab
set autoindent

" Highlighting
set showmatch
set hlsearch
set incsearch
set ignorecase

" Python settings
"autocmd FileType python setlocal list lcs=tab:>-,space:·
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4

" Enable wrapping for tex files
autocmd FileType tex setlocal wrap linebreak

" Spellchecker in tex files
set spelllang=en_us,ru
set spellfile=~/.vim/spell/custom.utf-8.add
autocmd FileType tex setlocal spell

" Splits
set splitbelow
set splitright
nnoremap <leader><Down> <C-W><C-J>
nnoremap <leader><Up> <C-W><C-K>
nnoremap <leader><Right> <C-W><C-L>
nnoremap <leader><Left> <C-W><C-H>

" flake8
autocmd FileType python map <buffer> <C-F> :call flake8#Flake8()<CR>
let g:flake8_cmd="/usr/bin/flake8"
