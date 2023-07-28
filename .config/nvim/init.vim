"  _       _ _         _           
" (_)_ __ (_) |___   _(_)_ __ ___  
" | | '_ \| | __\ \ / / | '_ ` _ \ 
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"

if has('nvim')
	call plug#begin()
		"Plug 'dpelle/vim-LanguageTool'
		Plug 'lervag/vimtex'
		Plug 'christoomey/vim-tmux-navigator'
		Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	call plug#end()
else
endif

"let g:languagetool_jar='/opt/LanguageTool-5.2/languagetool-commandline.jar'

" some catppuccin specific configurations
colorscheme catppuccin " catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

" Return to last edit position when opening files (You want this!)
"
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

let g:python_recommended_style=0

"set length of a tab
set tabstop=6

"set the shift width
set shiftwidth=6

"automatic indent
"set autoindent
set noexpandtab

"enable syntax highlighting
syntax on

"disable ex mode
map Q <Nop>

"colorscheme industry

"show the indentation line (note: there is a space in the end)
set list lcs=tab:\|\ 

"show the line numbers, show relative number instead of absolute linenumber
set number
set relativenumber

"disable the swapfiles
set noswapfile
set nocompatible

"highlight the search results
set hlsearch

"auto complete the parenthesises
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha

set clipboard=unnamedplus,unnamed

autocmd FileType c,cpp,java,php,tex,py,sh autocmd BufWritePre <buffer> %s/\s\+$//e
