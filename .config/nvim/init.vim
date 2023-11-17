"  _       _ _         _           
" (_)_ __ (_) |___   _(_)_ __ ___  
" | | '_ \| | __\ \ / / | '_ ` _ \ 
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"

call plug#begin()
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'nvim-lualine/lualine.nvim'
	" If you want to have icons in your statusline choose one of these
	Plug 'folke/todo-comments.nvim'

	" autocompletion of brackets
	Plug 'windwp/nvim-autopairs'
call plug#end()

"
" Telescope: recall that the default <leader> key is "\"
"
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"
" Colorscheme
"
" some catppuccin specific configurations
" other colorschemes:
" -- catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
"colorscheme catppuccin-frappe " 

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

""auto complete the parenthesises
"inoremap { {}<Esc>ha
"inoremap ( ()<Esc>ha
"inoremap [ []<Esc>ha

set clipboard=unnamedplus,unnamed

autocmd FileType c,cpp,java,php,tex,py,sh autocmd BufWritePre <buffer> %s/\s\+$//e

lua << EOF

require("nvim-autopairs").setup {}

require('catppuccin').setup {
	vim.cmd.colorscheme "catppuccin"
}

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

EOF
