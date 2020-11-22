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

" Quick way to move between splits
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
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'

Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

call plug#end()

cnoreabbrev Ack Ack!

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['python', 'java'] }
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_html_checkers = ['syntastic-html-gjslint']
let g:syntastic_javascript_checkers = ['syntastic-html-gjslint']

let g:airline#extensions#whitespace#enabled = 0

" let g:indentLine_setColors = 0
" let g:indentLine_bgcolor_term = 150
" let g:indentLine_bgcolor_gui = '#FF5F00'
" let g:indentLine_char = '|'
" let g:indentLine_concealcursor = 'inc'
" let g:indentLine_conceallevel = 2

" VIM's theme
syntax enable
set termguicolors
set background=dark
colorscheme gruvbox

map <F2> :Buffers<CR>

" Mapping for opening NERDTree in the current file's folder
nnoremap <leader>f :execute (@% == '' ? 'NERDTreeToggle' : 'NERDTreeFind')<CR>

set mouse=a
map <leader>t :tag<CR>

" Cancel search highlighting
map <leader>q :let @/=""<CR>

" Fold the docstrings in python files
function! Fold_py(...)
    setlocal foldenable foldmethod=syntax
    syn region pythonString
          \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend fold
          \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell
    syn region pythonRawString
          \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend fold
          \ contains=pythonSpaceError,pythonDoctest,@Spell
endfunction
autocmd FileType python call Fold_py()

autocmd FileType java setlocal tabstop=4 shiftwidth=4 colorcolumn=90

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

" Align virtually selected lines by provided pattern
" https://vim.fandom.com/wiki/Regex-based_text_alignment
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <Leader>a :Align<CR>
function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction

highlight ExtraWhitespace ctermbg=darkred guibg=darkorange
autocmd Syntax * syn match ExtraWhitespace /\s\+$/
