
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="mario"

"  Type        GUI FG           GUI BG           GUI             CTERM FG            CTERM BG            CTERM

hi LineNr      guifg=black      guibg=#e0e0e0                    ctermfg=white       ctermbg=white
hi Normal      guifg=black      guibg=white                      ctermfg=black       ctermbg=white
hi Comment     guifg=#006000                                     ctermfg=darkgreen   ctermbg=white
hi PreProc     guifg=purple                                      ctermfg=darkred
hi Identifier  guifg=darkblue                                    ctermfg=darkblue
hi Constant    guifg=#d00000                                     ctermfg=darkred
hi Type        guifg=blue                        gui=none        ctermfg=blue                            cterm=none
hi Statement   guifg=blue                        gui=none        ctermfg=blue                            cterm=none
hi Label       guifg=darkblue                    gui=underline   ctermfg=darkblue                        cterm=underline
hi Special     guifg=blue                                        ctermfg=blue
hi Todo        guifg=blue       guibg=yellow                     ctermfg=red         ctermbg=yellow
hi Folded      guifg=#606060    guibg=#e0e0e0                    ctermfg=white       ctermbg=black
hi MatchParen  guifg=white      guibg=black                      ctermfg=white       ctermbg=black
hi Directory   guifg=blue                                        ctermfg=blue
hi Search      guifg=blue       guibg=orange                     ctermfg=blue        ctermbg=yellow
hi DiffAdd                      guibg=lightblue                                      ctermbg=lightblue
hi DiffChange                   guibg=lightgreen                                     ctermbg=lightgreen
hi DiffDelete                   guibg=lightred                                       ctermbg=lightred
hi DiffText                     guibg=orange     gui=none                            ctermbg=yellow      cterm=none

hi link String	        Constant
hi link Character	    Constant
hi link Number	        Constant
hi link Boolean	        Constant
hi link Float		    Constant
hi link SpecialChar     Constant
hi link Function	    Identifier
hi link Conditional	    Statement
hi link Repeat	        Statement
hi link Operator	    Statement
hi link Keyword	        Statement
hi link Exception	    Statement
hi link Include	        PreProc
hi link Define	        PreProc
hi link Macro		    PreProc
hi link PreCondit	    PreProc
hi link StorageClass	Type
hi link Structure	    Type
hi link Typedef	        Type
hi link SpecialComment  Special
hi link Debug		    Special
hi link Delimiter	    Special
hi link IncSearch       Search

