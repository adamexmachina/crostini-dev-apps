"If Plug isn't installed when opening for the first time then install it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Add Plugins
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-matchquote'
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'elzr/vim-json'
Plug 'garbas/vim-snipmate'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'leafgarland/typescript-vim'
Plug 'liuchengxu/vim-which-key'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'qxxxb/vim-searchhi'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/denite.nvim'
Plug 'StanAngeloff/php.vim'
Plug 'stephpy/vim-yaml'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yuttie/comfortable-motion.vim'
Plug 'w0rp/ale'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
call plug#end()

set relativenumber
set background=dark
colorscheme solarized
set guifont=Inconsolata\ for\ Powerline\ 16
set guioptions=i " HIDE menu, toolbar, scrollbar"
set hlsearch
let NERDTreeShowLineNumbers=1 " enable line numbers in NERDTree
let NERDTreeQuitOnOpen=1 " Close NERDTree after opening file
autocmd FileType nerdtree setlocal relativenumber "make sure relative line numbers are used
autocmd! bufwritepost .vimrc source % " Source the vimrc file after saving it
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

" Jump to last position when file is opened
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Center cursor
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
augroup END

" Highlight cursor line
set cursorline
hi cursorline guibg=#023543 cterm=none term=none ctermbg=234
hi CursorLineNr guifg=#023543 

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Remove split borders and columns
set foldcolumn=0
hi LineNr guibg=bg
hi NonText guifg=bg " Remove Split borders
hi foldcolumn guibg=bg
hi VertSplit guibg=bg guifg=bg " Remove columns between windows like in the case of NERDTree

" AIRLINE
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" NOTES
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'

" INCSEARCH
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" COMFORTABLE MOTION
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

" EASY MOTION & INCSEARCH
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

" FUGITIVE
autocmd QuickFixCmdPost *grep* cwindow

" VIM-SEARCHHI
nmap n <Plug>(searchhi-n)
nmap N <Plug>(searchhi-N)
nmap * <Plug>(searchhi-*)
nmap g* <Plug>(searchhi-g*)
nmap # <Plug>(searchhi-#)
nmap g# <Plug>(searchhi-g#)
nmap gd <Plug>(searchhi-gd)
nmap gD <Plug>(searchhi-gD)

vmap n <Plug>(searchhi-v-n)
vmap N <Plug>(searchhi-v-N)
vmap * <Plug>(searchhi-v-*)
vmap g* <Plug>(searchhi-v-g*)
vmap # <Plug>(searchhi-v-#)
vmap g# <Plug>(searchhi-v-g#)
vmap gd <Plug>(searchhi-v-gd)
vmap gD <Plug>(searchhi-v-gD)

nmap <silent> <C-L> <Plug>(searchhi-clear-all)
vmap <silent> <C-L> <Plug>(searchhi-v-clear-all)

" VIM STARTIFY
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_custom_header = ''

" KEY MAPPINGS
autocmd! User vim-which-key call which#register('<Space>', 'g:which_key_map')
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

noremap ; :
nmap q; q:
inoremap kj <esc>:w<cr>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" DRUPAL SYNTAX SETTINGS
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.view set filetype=php
  augroup END
endif
syntax on

" CREATE MAPPINGS & DICTIONARY
let g:which_key_map = {}

map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
let g:which_key_map.b = {
	\ 'name': 'Buffer',
	\ 'n' : [':bn<cr>', 'Next Buffer'],
	\ 'p' : [':bp<cr>', 'Previous Buffer'],
	\}

map <leader>cm :CtrlPMRU<CR>
map <leader>cm :CtrlP<CR>
let g:which_key_map.c = {
	\ 'name': 'CtrlP',
	\ 'm' : [':CtrlPMRU', 'CtrlP Most Recent Files'],
	\ 'p' : [':CtrlP', 'CtrlP'],
	\}

map <leader>fc :bd<cr>
map <leader>fn :e<cr>
map <leader>fo :e<space>
map <leader>fs :w<cr>
let g:which_key_map.f = {
	\ 'name': 'File',
	\ 'c': [':bd<cr>', 'File Close'],
	\ 'n': [':e<cr>', 'File New'],
	\ 'o': [':e<space>', 'File Open'],
	\ 's': [':w<cr>', 'File Save'],
	\}

map <leader>nt :NERDTreeToggle<cr>
let g:which_key_map.n = {
	\ 'name': 'NERDTree',
	\ 't': [':NERDTreeToggle<cr>', 'Toggle']
	\}

map <leader>pc :PlugClean
map <leader>pu :PlugUpdate
let g:which_key_map.p = {
	\ 'name': 'Plug.vim',
	\ 'c': [':PlugClean<cr>', 'Plug Clean'],
	\ 'u': [':PlugUpdate<cr>', 'Plug Update'],
	\}
nnoremap <leader>sc :SC<cr>
nnoremap <leader>sd :SD<cr>
nnoremap <leader>sl :SL<cr>
nnoremap <leader>ss :SS<cr>
let g:which_key_map.s = {
	\ 'name': 'Sessions',
	\ 'c': [':SC<cr>', 'Session Close'],
	\ 'd': [':SD<cr>', 'Session Delete'],
	\ 'l': [':SL<cr>', 'Session Load'],
	\ 's': [':SS<cr>', 'Session Save'],
	\}

call which_key#register('<Space>', "g:which_key_map")
