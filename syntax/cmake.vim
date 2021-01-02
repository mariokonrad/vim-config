" Vim syntax file
"
" Extends the cmake.vim provided by vim with newer keywords,
" variables, properties, etc.
"
" Language:    CMake
" Author:      Mario Konrad <mario.konrad@gmx.net>
" Last Change: 2021-01-02
" License:     Public Domain
"

if exists("b:current_syntax")
    runtime! syntax/cmake.vim
endif

syn keyword cmakeKWtarget_link_options contained
            \ BEFORE INTERFACE PRIVATE PUBLIC

syn keyword cmakeCommand
            \ target_link_options

hi def link cmakeKWtarget_link_options ModeMsg

