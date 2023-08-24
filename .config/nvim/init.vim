"  _       _ _         _           
" (_)_ __ (_) |___   _(_)_ __ ___  
" | | '_ \| | __\ \ / / | '_ ` _ \ 
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"

call plug#begin()
	"Plug 'dpelle/vim-LanguageTool'
	Plug 'lervag/vimtex'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
	Plug 'nvim-treesitter/nvim-treesitter' " nvim-treesitter: for advanced syntax highlighting
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'nvim-lualine/lualine.nvim'
	" If you want to have icons in your statusline choose one of these
	Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

source ~/.config/nvim/lualine.lua
source ~/.config/nvim/telescope.vim

"
" Colorscheme
"
" some catppuccin specific configurations
" other colorschemes:
" -- catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
colorscheme catppuccin-frappe " 

"let g:languagetool_jar='/opt/LanguageTool-5.2/languagetool-commandline.jar'

" Return to last edit position when opening files (You want this!)
"
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

"
" Python recommend style will automatically correct the tabs to spaces, which
" is very annoying
"
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

"mouse integration between tmux
set mouse=a

"colorscheme industry

"show the indentation line (note: there is a space in the end)
"set list lcs=tab:\|\ 

"show the line numbers
set number

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
