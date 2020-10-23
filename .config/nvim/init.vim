" Additional coc configuration
" source ~/.config/nvim/coc.conf.vim

" Enable line numbers
set relativenumber
set number
set ai

" Run python cell
vnoremap <silent> <leader>[ :w !python3 -i<CR>

set colorcolumn=120
set textwidth=120
set expandtab
set shiftwidth=2
set tabstop=2
set scrolloff=3
set tags+=,/usr/lib/include
let mapleader=","

set noswapfile
map <leader>w :w<CR>
map <C-A> <Nop>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
nnoremap <leader>st :SyntasticToggleMode<CR>
nnoremap <leader>sc :SyntasticCheck<CR>
nnoremap <leader>d :FZF<CR>

" Enable pasting from global clipboard
" with CTRL+V in Insert mode
inoremap <C-V> <Esc>"+pa

" Set font in order to use it within NERDTree
" set guifont=3270-Medium\ Nerd\ Font\ Complete.otf\ 11

" Quick way to move between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Install plugins section
call plug#begin('~/.local/share/nvim/plugged')

" Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-eunuch' " Interactions with filesystem within vim

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'ryanoasis/vim-devicons'
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'yggdroot/indentline'

Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'

Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

Plug 'majutsushi/tagbar'

call plug#end()

cnoreabbrev Ack Ack!

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_html_checkers = ['syntastic-html-gjslint']
let g:syntastic_javascript_checkers = ['syntastic-html-gjslint']

" let g:indentLine_setColors = 0
" let g:indentLine_bgcolor_term = 150
" let g:indentLine_bgcolor_gui = '#FF5F00'
" let g:indentLine_char = ''
" let g:indentLine_concealcursor = 'inc'
" let g:indentLine_conceallevel = 2

" VIM's theme
syntax enable
set termguicolors
set background=dark
" set t_Co=256
colorscheme gruvbox
let g:airline#extensions#whitespace#enabled = 0

map <F2> :Buffers<CR>

" Mapping for opening NERDTree in the current file's folder
nnoremap <leader>f :execute (@% == '' ? 'NERDTreeToggle' : 'NERDTreeFind')<CR>

set mouse=a
map <leader>t :tag<CR>

" Cancel highlighting
map <leader>q :let @/=""<CR>

" Fold the docstrings in python files
fu! Fold_py(...)
    setlocal foldenable foldmethod=syntax
    syn region pythonString
          \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend fold
          \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell
    syn region pythonRawString
          \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend fold
          \ contains=pythonSpaceError,pythonDoctest,@Spell
endfunction
autocmd FileType python call Fold_py()

" Search for selected text, forwards or backwards. 
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>