if !exists('*bryant#save_and_exec')
    function! bryant#save_and_exec() abort
    if &filetype == 'vim'
      :silent! write
      :source %
    elseif &filetype == 'lua'
      :silent! write
      :luafile %
    endif

    return
  endfunction
endif

" Execute this file
" nnoremap <leader>rf :call bryant#save_and_exec()<CR>
if !exists('*bryant#terminal')
    function! bryant#terminal() abort
        new
        wincmd J
        call nvim_win_set_height(0, 12)
        set winfixheight
        term
    endfunction
endif
