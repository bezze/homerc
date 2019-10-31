" autocmd BufWritePre *.rs :normal m'gg=G''

noremap ;r :!cargo run<CR>
noremap ;b :!cargo build<CR>
inoremap ;l <'><left>
noremap ;l i<'><left>
