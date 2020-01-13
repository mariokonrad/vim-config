" force english menus
language messages C
language ctype C
set langmenu=none
if has("eval")
	let $LANG='en'
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

" appearance
if has('gui_running')
	set t_Co=256
	let g:solarized_termcolors=256
	let g:solarized_visibility="low"
	let g:solarized_contrast="high"
	"set guifont=Courier\ New\ 9
	set anti guifont=Hack\ 9
	set background=dark
	colorscheme solarized
else
	set t_Co=256

	"colorscheme reloaded

	"colorscheme hemisu
	"set background=dark
	"hi Search ctermfg=black ctermbg=yellow

	set background=dark
	let g:solarized_use16=1
	let g:solarized_termcolors=256
	let g:solarized_degrade=0
	let g:solarized_visibility="low" " low, normal, high
	let g:solarized_contrast="high"
	let g:solarized_diffmode="normal" " low, normal, high
	let g:solarized_termtrans=0 " 0, 1
	let g:solarized_italics=1
	let g:solarized_bold=1
	let g:solarized_underline=1
	colorscheme solarized
	hi Search ctermfg=yellow ctermbg=black
endif

" ignore whitespaces while diff
set diffopt+=iwhite

" text editing
if has("autocmd")
	filetype plugin on " indent:off

	" disable autocomment for C and C++
	autocmd FileType c   set formatoptions=
	autocmd FileType cpp set formatoptions=

	" code completion for C and C++
	autocmd FileType c   runtime! autoload/ccomplete.vim
	autocmd FileType cpp runtime! autoload/ccomplete.vim

	" prefer markdown over modula
	autocmd BufRead,BufNewFile *.md set filetype=markdown

	" python: 4 spaces, no hardtabs
	autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab   textwidth=0 wrapmargin=0

	" Makefiles are special, they need hard tabs
	autocmd FileType make set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab textwidth=0 wrapmargin=0

	" xml folding
	let g:xml_syntax_folding=1
	autocmd FileType xml setlocal foldmethod=syntax
endif

if has("eval")
	syntax on
endif
set backspace=2

" default: hard tab, 4 space indent, noexpand
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set textwidth=0
set wrapmargin=0

set noautoindent
set nocindent
set nosmartindent
set nosmarttab

" line numbering
set number
nmap <C-N><C-N> :set invnumber <CR>
map <F12> :set number!

" folding, default: all unfolded
set foldmethod=marker
set foldlevel=99

" format options
set formatoptions-=croql

" search settings
set hlsearch " highlight search
set incsearch

" backup and info
set nobk   " do not keep a backup file after overwriting
set nowb   " do not keep a backup file before overwriting
set noswf  " no swapfile
set viminfo=""

" pathogen
if exists(":execute")
	execute pathogen#infect()
endif

" ctags + vim-taglist
if has("eval")
	let Tlist_Sort_Type = "name"
	nmap <F3> :TlistToggle<cr>
endif
set tags=tags;/

" e: tab labels
" m: menu bar
" t: tear off menues
" T: toolbar
" r: righ-hand scrollbar is always present
set guioptions=emtTr
set showtabline=2

" tabs control
nmap <C-a> :tabnew<cr>
imap <C-a> <ESC> :tabnew<cr>i
nmap <C-tab> :tabnext<cr>
imap <C-tab> <ESC> :tabnext<cr>i
nmap <C-S-tab> :tabprevious<cr>
imap <C-S-tab> <ESC> :tabprevious<cr>i

" tag list update on save
if has("autocmd")
	autocmd BufWritePost *.c :TlistUpdate
	autocmd BufWritePost *.h :TlistUpdate
	autocmd BufWritePost *.cpp :TlistUpdate
	autocmd BufWritePost *.hpp :TlistUpdate
endif

" no bells, no visual indication
set vb t_vb=

" searching
set grepprg=grep
map <F4> :grep -Ernw --include=*.c* --include=*.h* --exclude-dir=src_old --exclude-dir=extern <cword> include/* src/* <Bar> cw<CR>

" listchars (dot: "ctrl-k .M", quote: "ctrl-k >>", pi: "ctrl-k PI")
if has('gui_running')
	set list listchars=tab:»·
else
	set list listchars=tab:»·
	highlight NonText ctermfg=gray guifg=lightgray
	highlight SpecialKey ctermfg=236 guifg=lightgray
endif

" highlight trailing spaces and spaced before tabs
if exists(":match")
	highlight ExtraWhitespace ctermbg=red guibg=red
	match ExtraWhitespace /\s\+$\| \+\ze\t/
endif

if v:version >= 702
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
	"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
endif

" include blocker id generator
if exists(":execute")
	command! Genuuid execute "r!uuidgen | sed 's/-//g' | tr 'a-z' 'A-Z'"
endif

" cctree
if exists(":command")
	command! CTL silent CCTreeLoadDB cscope.out
	nmap <C-kMultiply>r :CCTreeTraceReverse<CR><CR>
	nmap <C-kMultiply>f :CCTreeTraceForward<CR><CR>
	nmap <S-Home> :CCTreeTraceReverse<CR><CR>
	nmap <S-End>  :CCTreeTraceForward<CR><CR>
endif

" enable visual debugger, only for vim 8.1 or newer
if v:version >= 801
	packadd termdebug
	hi debugPC term=reverse ctermbg=4 guibg=darkblue

	" %:r     : all windows horizontally
	" <c-w>2j : focus on source window
	" <c-w>L  : move source window to the right
	" <c-w>h  : focus back to gdb window
	nmap <F5> :Termdebug %:r<CR><c-w>2j<c-w>L<c-w>h
endif

if exists(":function") && exists(":command")
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

	" todo/fixme/bug list of current buffer, showed in new buffer
	command! Todo noautocmd :call GrepBuffers("TODO\\|FIXME\\|BUG") | cw
endif

if has("eval")
	" ctrlp
	set runtimepath^=~/.vim/bundle/ctrlp.vim
	let g:ctrlp_map = '<c-p>'
	let g:ctrlp_root_markers = ['.git']
	let g:ctrlp_custom_ignore = 'build\|.git'
endif

" nerdtree
silent! map <C-n> :NERDTreeToggle<CR>

" clang-format
if !empty($VIM_CLANG_FORMAT)
	map <C-f> :pyf $VIM_CLANG_FORMAT<CR>
	imap <C-f> <ESC>:pyf $VIM_CLANG_FORMAT<CR>i
	map <leader>fm ggVG :pyf $VIM_CLANG_FORMAT<CR>
endif

" gutentags
let g:gutentags_enabled = 0

" youcompleteme
set completeopt+=preview
if has("eval")
	let g:ycm_collect_identifiers_from_tags_files = 1
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
endif

" status line, disable 'statusline=...' when using powerline
if empty($POWERLINE_ROOT)
	set statusline=%Y\ /\ %{&ff}\ [char=\%03.3b/0x\%02.2B][pos=%l/%L,%v][%p%%]\ %m%r%h%w\ %F
else
	set rtp+=$POWERLINE_ROOT/bindings/vim/
endif
set laststatus=2

" local vim configuration (used for per-project configuration)
set exrc
set secure
if filereadable(".vimrc.local")
	so .vimrc.local
endif

