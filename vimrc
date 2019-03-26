" force english menus
language messages C
language ctype C
let $LANG='en'
set langmenu=none
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" appearance
set t_Co=256
if has('gui_running')
	let g:solarized_termcolors=256
	let g:solarized_visibility="low"
	let g:solarized_contrast="high"
	"set guifont=Courier\ New\ 9
	set anti guifont=Hack\ 9
	set background=dark
	colorscheme solarized
else
	"colorscheme reloaded

	"colorscheme hemisu
	"set background=dark
	"hi Search ctermfg=black ctermbg=yellow

	let g:solarized_termcolors=256
	let g:solarized_visibility="low"
	let g:solarized_contrast="high"
	colorscheme solarized
	set background=dark
	hi Search ctermfg=yellow ctermbg=black
endif

" ignore whitespaces while diff
set diffopt+=iwhite

" text editing
set shiftwidth=4
set tabstop=4
set textwidth=0
set wrapmargin=0
set softtabstop=0
set noai  " autoindent
set nocin " c code identing
set nosi  " smart ident
syn on
set backspace=2

" line numbering
set number
nmap <C-N><C-N> :set invnumber <CR>
map <F12> :set number!

" folding
set foldmethod=marker

" format options
set fo=

" search settings
set hls  " highlight search
set incsearch

" backup and info
set nobk   " do not keep a backup file after overwriting
set nowb   " do not keep a backup file before overwriting
set noswf  " no swapfile
"set viminfo='50,<1000,s100,n$HOME/.viminfo
set viminfo=""

" ctags + vim-taglist
let Tlist_Sort_Type = "name"
nmap <F3> :TlistToggle<cr>
set tags=tags;/

set guioptions=emtTr
set showtabline=2

" status line, disable 'statusline=...' when using powerline
if empty($POWERLINE_ROOT)
	set statusline=%Y\ /\ %{&ff}\ [char=\%03.3b/0x\%02.2B][pos=%l/%L,%v][%p%%]\ %m%r%h%w\ %F
endif
set laststatus=2

" tab switching
nmap <C-a> :tabnew<cr>
imap <C-a> <ESC> :tabnew<cr>i

nmap <C-tab> :tabnext<cr>
imap <C-tab> <ESC> :tabnext<cr>i

nmap <C-S-tab> :tabprevious<cr>
imap <C-S-tab> <ESC> :tabprevious<cr>i

" Makefiles are special, they need hard tabs
autocmd FileType make setlocal shiftwidth=4 tabstop=4 softtabstop=0 noexpandtab

" disable autocomment for C and C++
autocmd FileType c,cpp setlocal fo=

" code completion for C and C++
autocmd FileType c,cpp runtime! autoload/ccomplete.vim

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
	highlight NonText ctermfg=gray guifg=lightgray
	highlight SpecialKey ctermfg=236 guifg=lightgray
endif

" highlight trailing spaces and spaced before tabs
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

if version >= 702
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
	"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
endif

" include blocker id generator
command! Genuuid execute "r!uuidgen | sed 's/-//g' | tr 'a-z' 'A-Z'"

" cctree
command! CTL silent CCTreeLoadDB cscope.out

nmap <C-kMultiply>r :CCTreeTraceReverse<CR><CR>
nmap <C-kMultiply>f :CCTreeTraceForward<CR><CR>

nmap <S-Home> :CCTreeTraceReverse<CR><CR>
nmap <S-End>  :CCTreeTraceForward<CR><CR>

" pathogen
execute pathogen#infect()

" returns a list of buffers
function! BuffersList()
	let all = range(0, bufnr('$'))
	let res = []
	for b in all
		if buflisted(b)
			call add(res, bufname(b))
		endif
	endfor
	return res
endfunction

" greps in all open buffers
" found it here: https://vi.stackexchange.com/questions/2904/how-to-show-search-results-for-all-open-buffers
function! GrepBuffers(expression)
	exec 'vimgrep/'.a:expression.'/'.join(BuffersList())
endfunction

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_root_markers = ['.git']

" nerdtree
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

" clang-format
if !empty($VIM_CLANG_FORMAT)
	map <C-f> :pyf $VIM_CLANG_FORMAT<CR>
	imap <C-f> <ESC>:pyf $VIM_CLANG_FORMAT<CR>i
	map <leader>fm ggVG :pyf $VIM_CLANG_FORMAT<CR>
endif

" youcompleteme
set completeopt+=preview
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" powerline
if !empty($POWERLINE_ROOT)
	set rtp+=$POWERLINE_ROOT/bindings/vim/
endif

" todo/fixme/bug list of current buffer, showed in new buffer
command! Todo noautocmd :call GrepBuffers("TODO\\|FIXME\\|BUG") | cw

" local vim configuration (used for per-project configuration)
set exrc
set secure
if filereadable(".vimrc.local")
	so .vimrc.local
endif

