autocmd FileType python noremap ;p iprint()<Esc>i
autocmd FileType python inoremap ;p print()<Esc>i
autocmd FileType python noremap ;f idef<space>():<Esc>Ffa<space>
autocmd FileType python noremap ;h i#!/usr/bin/env<space>python3<esc>

"================================================================================
"" Pymode
let g:pymode = 1
"================================================================================
" Python-mode settings
let g:pymode_lint = 1
let g:pymode_lint_cwindow = 1
let g:pymode_lint_checkers = ['pyflakes', 'mccabe']
let g:pymode_lint_ignore = "W"

" Python-mode motion
let g:pymode_motion = 1

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
let g:pymode_rope=1

let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=1
let g:pymode_rope_auto_project=0
let g:pymode_rope_autoimport=1
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

let g:pymode_rope_rename_bind = '<C-c>rr'
let g:pymode_rope_rename_module_bind = '<C-c>r1r'
let g:pymode_rope_organize_imports_bind = '<C-c>ro'
let g:pymode_rope_autoimport_bind = '<C-c>ra'
let g:pymode_rope_extract_method_bind = '<C-c>rm'
let g:pymode_rope_extract_variable_bind = '<C-c>rl'
let g:pymode_rope_use_function_bind = '<C-c>ru'

" documentation
let g:pymode_doc=1
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

" warnings
let g:pymode_warnings = 0
