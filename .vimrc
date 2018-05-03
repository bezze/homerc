filetype off                  " required
set nocompatible              " be iMproved, required

" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" set the runtime path to include Vundle and initialize
" set rtp+=/home/$USER/.vim/bundle/Vundle.vim
" call vundle#begin('/home/$USER/.vim/plugins')
set rtp+=/home/teseo/.vim/bundle/Vundle.vim
call vundle#begin('/home/teseo/.vim/plugins')

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'scrooloose/nerdtree'                " Project and file navigation
Plugin 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plugin 'tpope/vim-commentary'               "  Comment lines with gc
Plugin 'tpope/vim-fugitive'                 " ? Git interface?
Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
" Plugin 'vim-airline/vim-airline'            " Status bar
Plugin 'python-mode/python-mode'            " Python stuff
Plugin 'flazz/vim-colorschemes'             " Colorschemes
Plugin 'christophermca/meta5'               " meta5: tronlike cholorscheme
Plugin 'ryanoasis/vim-devicons'             " Dev Icons
Plugin 'thaerkh/vim-indentguides'           " Visual representation of indents
" Plugin 'rudrab/vimf90', {'for' : 'f90'}   " Fortran 90 syntax
Plugin 'stevearc/vim-arduino'    " Arduino

" All of your Plugins must be added before the following line
call vundle#end()            " required
colorscheme meta5 "meta5 desert256 elflord meta5
colorscheme OceanicNext
"colorscheme OceanicNextNext "meta5 desert256 elflord meta5
syntax on
filetype plugin indent on
highlight ColorColumn ctermbg=235 guibg=#2c2d27
hi Normal ctermbg=none
hi NonText ctermbg=none
set expandtab
set tabstop=4
set shiftwidth=4
" set cursorline                              " shows line under the cursor's line
" highlight CursorLine ctermbg=135 guibg=#5c2d27

set showmatch                               " shows matching part of bracket pairs (), [], {}

" set guifont=mononoki\ Symbols\ Nerd\ Font\ 16
set guifont=DejaVu\ Sans\ Mono\ 13
" Inverts <j> with <k> navigation
noremap j k
noremap k j
" noremap h [1;5D
" noremap l [1;5C
" noremap j [1;5A
" noremap k [1;5B

" Activates highlight for searches
set hlsearch 
"Deactivates hl for searches
nnoremap <CR> :nohlsearch<CR><CR>
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
" Smart Home
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>
" Save and suspend
:noremap <C-Z> :w<CR><C-z> 
" End of line and enter
:noremap s $A<CR>
" Colorize column 80
let &colorcolumn=join(range(81,81),",")
" Open tag in vsplit
set previewheight=60
" nnoremap <C-]> :execute "vertical ptag " . expand("<cword>")<CR>


"=====================================================
"" Indent Guides Settings 
"=====================================================
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
"================================================================================
"" Pymode
"================================================================================
" Python-mode settings
let g:pymode_lint = 1
let g:pymode_lint_cwindow = 1
let g:pymode_lint_checkers = ['pyflakes', 'mccabe']
let g:pymode_lint_ignore = "W"

" python executables for different plugins
let g:pymode_python='python3'
let g:syntastic_python_python_exec='python3'

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

" rope
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_auto_project=0
let g:pymode_rope_enable_autoimport=0
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

" documentation
let g:pymode_doc=0
let g:pymode_doc_bind='K'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=40
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap º :NERDTreeToggle<CR>
