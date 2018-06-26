set nocompatible              " be iMproved, required
"filetype off                  " required
filetype plugin on            " required

" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" set the runtime path to include Vundle and initialize
set rtp+=/home/teseo/.vim/bundle/Vundle.vim    " needed for vundle
call vundle#begin('/home/teseo/.vim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'scrooloose/nerdtree'                " Project and file navigation
Plugin 'Xuyuanp/nerdtree-git-plugin'        " NerdTree git functionality
Plugin 'tpope/vim-commentary'               "  Comment lines with gc
Plugin 'tpope/vim-fugitive'                 " ? Git interface?
Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
Plugin 'python-mode/python-mode'            " Python stuff
Plugin 'rust-lang/rust.vim'                 " Rust stuff
Plugin 'flazz/vim-colorschemes'             " Colorschemes
Plugin 'christophermca/meta5'               " meta5: tronlike cholorscheme
Plugin 'ryanoasis/vim-devicons'             " Dev Icons
Plugin 'thaerkh/vim-indentguides'           " Visual representation of indents
" Plugin 'rudrab/vimf90', {'for' : 'f90'}     " Fortran 90 syntax
" Plugin 'stevearc/vim-arduino'               " Arduino
Plugin 'cespare/vim-toml'                   " TOML syntax
Plugin 'prabirshrestha/async.vim'           " This is needed for vim-lsp
" Plugin 'prabirshrestha/vim-lsp'             " Language Server Protocol
Plugin 'autozimu/LanguageClient-neovim'       " Another LSP, requires manual install
Plugin 'Valloric/YouCompleteMe'             " Shit just got REAL

Plugin 'SirVer/ultisnips'                    " Vim snippets. Track the engine.
Plugin 'honza/vim-snippets'                  " Snippets are separated from the engine. Add this if you want them

" All of your Plugins must be added before the following line
call vundle#end()            " required


colorscheme meta5 "meta5 desert256 elflord meta5
colorscheme OceanicNext
"colorscheme OceanicNextNext "meta5 desert256 elflord meta5
"
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
:noremap s $A<CR><Esc>
" Colorize column 80
let &colorcolumn=join(range(81,81),",")
set previewheight=60
" Open tag in vsplit
" nnoremap <C-]> :execute "vertical ptag " . expand("<cword>")<CR>

" Leader
let mapleader = "\<Space>"

" Enable folding
set foldmethod=indent
" Start unfolded
set foldlevelstart=99
" binds 'shift tab' to 'toggle fold'
nnoremap <s-tab> za

nnoremap <silent> <Leader>r :call mappings#cycle_numbering()<CR>

nnoremap <Leader>k :tabnext<CR>
nnoremap <Leader>j :tabprev<CR>
nnoremap <Leader>l :tablast<CR>
nnoremap <Leader>h :tabfirst<CR>
nnoremap <Leader>n :tabnew<space>

"=====================================================
" YouCompleteMe Bindings
"=====================================================
noremap <C-a>d :YcmCompleter GetDoc<CR>
noremap <C-a>s :YcmCompleter GoTo<CR>
noremap <C-a>c :YcmCompleter GoToDefinition<CR>
noremap <C-a>C :YcmCompleter GoToImplementation<CR>

"=====================================================
"" Indent Guides Settings 
"=====================================================
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=40
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap º :NERDTreeToggle<CR>

"=====================================================
"" vim-lsp Language Server Protocol
"=====================================================
" Rust : needs package rustup, and installation of toolchain + RLS
" if executable('rls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'rls',
"         \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
"         \ 'whitelist': ['rust'],
"         \ })
" endif

" " Python : needs package python-language-server
" if executable('pyls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ })
" endif
"=====================================================
"" LanguageClient-neovim Language Server Protocol
"=====================================================
" Rust : needs package rustup, and installation of toolchain + RLS
" Python : needs package python-language-server
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <F3> :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F4> :call LanguageClient_textDocument_documentSymbol()<CR>

""
"Custom python bindings
""
autocmd FileType python source ~/.vim/custom_py.vim
autocmd FileType rust source ~/.vim/custom_rs.vim

