"=============================================================================
"" File: xz-gtags.vim
" Author: kaizoa
" " Created: 2017-05-06
" "=============================================================================
scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim


if !exists("g:xz#gtags#load_preset_plugin")
  let g:xz#gtags#load_preset_plugin = 1
endif


if !exists('g:xz#gtags#prog')
  let g:xz#gtags#prog = exepath("gtags")
endif


if g:xz#gtags#prog == ""
  finish
endif


function! s:load_preset_plugin() abort
  :execute "source " . fnamemodify(resolve(g:xz#gtags#prog), ":p:h:h"). "/share/gtags/gtags.vim"
  let g:xz#gtags#preset_plugin_loaded = 1
endfunction


if g:xz#gtags#load_preset_plugin && !exists('g:xz#gtags#preset_plugin_loaded')
  let g:xz#gtags#preset_plugin_loaded = 0
  call s:load_preset_plugin()
endif


augroup xz_gtags
  autocmd!
  autocmd BufWritePost * call xz#gtags#auto_update()
augroup END


command! -nargs=* XZGtags call xz#gtags#gtags(<q-args>)
command! XZGtagsUpdate call xz#gtags#update()
let &cpo = s:save_cpo
unlet s:save_cpo
" vim: ts=2 sw=2 sts=2 et foldenable foldmethod=marker foldcolumn=1

