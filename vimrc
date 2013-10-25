" force english menus
language messages C
language ctype C
let $LANG='en'
set langmenu=none
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" appearance
if has('gui_running')
	let g:solarized_termcolors=256
	let g:solarized_visibility="low"
	let g:solarized_contrast="high"
	colorscheme solarized
	set guifont=Courier\ New\ 9
	set background=dark
else
"	colorscheme reloaded
	colorscheme hemisu
	set background=dark
	hi Search ctermfg=black ctermbg=yellow
endif

" ignore whitespaces while diff
set diffopt+=iwhite

" misc settings
set sw=4
set ts=4
set tw=0
set wm=0
set sts=0
set noai
set nocin
set nosi
set hls
syn on
set backspace=2
set fo=
set foldmethod=marker
set number
nmap <C-N><C-N> :set invnumber <CR>
map <F12> :set number!

" search settings
set incsearch
set nobk
set nowb
set noswf
set viminfo='50,<1000,s100,n$HOME/.viminfo

" ctags + vim-taglist
let Tlist_Sort_Type = "name"
nmap <F3> :TlistToggle<cr>
set tags=tags;/

set guioptions=emtTr
set showtabline=2

" status line
set statusline=%Y\ /\ %{&ff}\ [char=\%03.3b/0x\%02.2B][pos=%l/%L,%v][%p%%]\ %m%r%h%w\ %F
set laststatus=2

" tab switching
nmap <C-a> :tabnew<cr>
imap <C-a> <ESC> :tabnew<cr>i

nmap <C-tab> :tabnext<cr>
imap <C-tab> <ESC> :tabnext<cr>i

nmap <C-S-tab> :tabprevious<cr>
imap <C-S-tab> <ESC> :tabprevious<cr>i

" autocommand to disable autocomment
autocmd FileType c,cpp setlocal fo=

" code completion for *.c
autocmd FileType c runtime! autoload/ccomplete.vim

" tag list update on save
autocmd BufWritePost *.c :TlistUpdate
autocmd BufWritePost *.h :TlistUpdate
autocmd BufWritePost *.cpp :TlistUpdate
autocmd BufWritePost *.hpp :TlistUpdate

" prefer markdown over modula
autocmd BufRead,BufNewFile *.md set filetype=markdown

" no bells, no visual indication
set vb t_vb=

" searching
"map <F4> :execute "vimgrep /\\<" . expand("<cword>") . "\\>/gj src/**/*.c* src/**/*.h*" <Bar> cw<CR>
set grepprg=grep
map <F4> :grep -Ernw --include=*.c* --include=*.h* --exclude-dir=src_old <cword> src/* <Bar> cw<CR>

" xml folding
let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax

" listchars (dot: "ctrl-k .M", quote: "ctrl-k >>", pi: "ctrl-k PI")
if has('gui_running')
	set list listchars=tab:»·
else
	set list listchars=tab:»·
	highlight NonText ctermfg=lightgray guifg=lightgray
	highlight SpecialKey ctermfg=lightgray guifg=lightgray
endif

" highlight trailing spaces and spaced before tabs
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

if version >= 702
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
"  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
endif

" cctree
command! CTL silent CCTreeLoadDB cscope.out

nmap <C-kMultiply>r :CCTreeTraceReverse<CR><CR>
nmap <C-kMultiply>f :CCTreeTraceForward<CR><CR>

nmap <S-Home> :CCTreeTraceReverse<CR><CR>
nmap <S-End>  :CCTreeTraceForward<CR><CR>

" pathogen
execute pathogen#infect()

" nerdtree
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

" clang-format
map <C-K> :pyf $HOME/local/llvm/bin/clang-format.py<CR>
imap <C-K> <ESC>:pyf $HOME/local/llvm/bin/clang-format.py<CR>i

" local vim configuration (used for per-project configuration)
set exrc
set secure
if filereadable(".vimrc.local")
	so .vimrc.local
endif

