" Additional coc configuration
" source ~/.config/nvim/coc.conf.vim

" Enable line numbers
set number
set ai

" Run python cell
vnoremap <silent> <leader>[ :w !python3 -i<CR>

set colorcolumn=120
set expandtab
set shiftwidth=2
set tabstop=2
set scrolloff=3
set tags+=,/usr/lib/include
let mapleader=","

set noswapfile
map <leader>w :w<CR>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
map <leader>d :FZF<CR>

" Enable pasting from global clipboard
" with CTRL+V in Insert mode
inoremap <C-V> <Esc>"+pa

" Set font in order to use it within NERDTree
" set guifont=3270-Medium\ Nerd\ Font\ Complete.otf\ 11

" Smart way to move between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Install plugins section
call plug#begin('/home/keyg/.local/share/nvim/plugged')
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Collection of colorschemes
Plug 'rafi/awesome-vim-colorschemes'

" Search tool
Plug 'mileszs/ack.vim'

" Syntax for languages
Plug 'sheerun/vim-polyglot'

" Interactions with filesystem within vim
Plug 'tpope/vim-eunuch'

" Cool plugin for surroundings
Plug 'tpope/vim-surround'

" Plugin for quick commentary
Plug 'tpope/vim-commentary'

"Supports plugin functionality repeating
Plug 'tpope/vim-repeat'

" Syntax checking plugin for vim
Plug 'vim-syntastic/syntastic'

" NERDTree plugin for maintaining working directories
Plug 'preservim/nerdtree'

" Icons for NERDTree
Plug 'ryanoasis/vim-devicons'

" Plugin for convenient buffer usage
Plug 'vim-scripts/buffet.vim'

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

" VIM's theme
" let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum'
" let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum'
syntax enable
set termguicolors
set background=dark
set t_Co=256
colorscheme gruvbox

" Mapping for Buffet popup
map <F2> :Buffers<CR>

" Mapping for opening NERDTree in the current file's folder
nnoremap <leader>f :execute (@% == '' ? 'NERDTreeToggle' : 'NERDTreeFind')<CR>

set mouse=a " Yep

" Jump up the tag tree
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
