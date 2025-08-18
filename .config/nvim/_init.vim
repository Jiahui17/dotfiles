"  _       _ _         _           
" (_)_ __ (_) |___   _(_)_ __ ___  
" | | '_ \| | __\ \ / / | '_ ` _ \ 
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
"
let g:_plug_path = "$XDG_CACHE_HOME/" . (has('nvim') ? "nvim" : "vim") .  "/plugged"

call plug#begin()
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'mhartington/formatter.nvim'
	" If you want to have icons in your statusline choose one of these
	Plug 'folke/todo-comments.nvim'
	Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }

	" autocompletion of brackets
	Plug 'windwp/nvim-autopairs'
	" gS
	Plug 'echasnovski/mini.splitjoin', { 'branch': 'stable' }
call plug#end()

autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

"enable syntax highlighting
syntax on

"disable ex mode
map Q <Nop> 

set mouse=a "mouse integration between tmux

set number "show the line numbers


set noswapfile "disable the swapfiles
set nocompatible


set hlsearch "highlight the search results

set clipboard+=unnamedplus

"automatically format python code on save
if executable("black")
function PyFormatBuffer()
  if &modified
    let cursor_pos = getpos('.')
    :%!black -q -
    call setpos('.', cursor_pos)
  endif
endfunction
autocmd BufWritePre *.py :call PyFormatBuffer()
endif

"automatically format cpp code on save
if executable("clang-format")
function CppFormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp :call CppFormatBuffer()
endif

autocmd FileType c,cpp,java,php,tex,py,sh autocmd BufWritePre <buffer> %s/\s\+$//e

colorscheme nordic


lua << EOF

require("nvim-autopairs").setup {}
require('mini.splitjoin').setup()

-- setup must be called before loading

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
		},
      theme = 'nordic'
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
