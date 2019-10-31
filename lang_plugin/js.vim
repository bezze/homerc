
noremap <Leader>b :call JsonDebugger(line('.'))<CR>

let g:js_breakpoint_cmd = 'debugger // XXX: DEBUGGER'

fun! JsonDebugger(lnum) "{{{
    if g:js_breakpoint_cmd == ''
        echoerr("g:js_breakpoint_cmd is empty")
        return -1
    endif
    let line = getline(a:lnum)
    if strridx(line, g:js_breakpoint_cmd) != -1
        normal dd
    else
        let plnum = prevnonblank(a:lnum)
        if &expandtab
            let indents = repeat(' ', indent(plnum))
        else
            let indents = repeat("\t", plnum / &shiftwidth)
        endif

        call append(line('.')-1, indents.g:js_breakpoint_cmd)
        normal k
    endif
endfunction "}}}
