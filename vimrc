set nocompatible


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

execute pathogen#infect()

" Theme {{{

if &t_Co > 2
  colorscheme default
  set background=dark
  set paste
elseif has("gui_running")
  colorscheme solarized
  set background=light
  set guifont=Monaco
  set guioptions+=cegmRL
endif

nnoremap ,bgl :set background=light<CR>
nnoremap ,bgd :set background=dark<CR>

" }}}

" Settings {{{

set omnifunc=syntaxcomplete#Complete

syntax on
set hlsearch
set nospell
set hidden
set number
set mouse=a
set mousehide
set showmode
set cursorline
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
scriptencoding utf-8

set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4
set pastetoggle=<F12>
set ignorecase
set smartcase

set sessionoptions=buffers,sesdir,folds,localoptions,tabpages,winpos,winsize

set omnifunc=syntaxcomplete#Complete
" }}}

"  Statusline {{{ 
set statusline=
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%{fugitive#statusline()} "add fugitive statusline
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" }}}

" Mappings {{{

let mapleader=","

" edit vimrc in vsplit
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" quickfix and location-list mappings
nnoremap ,qo :copen<CR>
nnoremap ,qc :cclose<CR>
nnoremap ,lo :lopen<CR>
nnoremap ,lc :lclose<CR>

" move easily between windows
nnoremap <silent> <M-h> :wincmd h<CR>
nnoremap <silent> <M-l> :wincmd l<CR>
nnoremap <silent> <M-j> :wincmd j<CR>
nnoremap <silent> <M-k> :wincmd k<CR>

nnoremap <D-]> :tabnext<CR>
nnoremap <D-[> :tabprevious<CR>

" }}}

" {{{ AuGroups
if has("autocmd")
	augroup git
		autocmd!
		autocmd FileType gitconfig setlocal foldmethod=expr
		autocmd FileType gitconfig setlocal foldexpr=match(getline(v:lnum),'^[')>=0?'>1':1
	augroup end
	augroup vimrc
		autocmd!
		autocmd FileType vim setlocal foldmethod=marker
		autocmd BufWritePost .vimrc source $MYVIMRC
	augroup end
    augroup markdown
        autocmd!
        autocmd filetype markdown setlocal foldmethod=expr
        autocmd filetype markdown setlocal foldexpr=MarkdownLevel()
    augroup end
endif
" }}}

" {{{

function! MarkdownLevel() 
    let h = matchstr(getline(v:lnum), '^#\+') 
    if empty(h) 
        return "=" 
    else 
        return ">" . len(h) 
    endif 
endfunction

" }}}


" Plugins {{{ 

" Ack {{{
nnoremap <leader>a :AckFromSearch<CR>
" }}}

" BufExplorer {{{
nnoremap ,bd :bd!<CR>
let g:bufExplorerDefaultHelp=0
let g:bufExplorerDetailedHelp=0
let g:bufExplorerFindActive=0
let g:bufExplorerShowDirectories=1
" }}}

" Cscope {{{
if has('cscope')
  set cscopetag cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif
  nmap ,cs :cs find s  <C-R>=expand("<cword>")<CR><CR>	" symbol
  nmap ,cg :cs find g  <C-R>=expand("<cword>")<CR><CR>	" global
  nmap ,cc :cs find c  <C-R>=expand("<cword>")<CR><CR>	" calls
  nmap ,ct :cs find t  <C-R>=expand("<cword>")<CR><CR>	" text
  nmap ,ce :cs find e  <C-R>=expand("<cword>")<CR><CR>	" egrep
  nmap ,cf :cs find f  <C-R>=expand("<cfile>")<CR><CR>	" file
  nmap ,ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR> " includes
  nmap ,cd :cs find d  <C-R>=expand("<cword>")<CR><CR>	" called
endif
" }}} 

" CTRL+P {{{
" let g:loaded_ctrlp = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['tag', 'bookmarkdir', 'buffertag', 'quickfix', 'dir']
" ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
" }}}

" dbext {{{
let g:dbext_default_history_file = $HOME.'/.cache/dbext/sql_history.txt'
let g:dbext_default_history_size = 100
let g:dbext_default_type = 'MYSQL'
let g:dbext_default_user = 'root'
let g:dbext_default_passwd = 'secret'
let g:dbext_default_menu_mode = '2'
" }}}

" Fugitive {{{
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
"}}}

" Gundo {{{
nnoremap <leader>gu :GundoToggle<cr>
" let g:gundo_disable = 0
let g:gundo_help = 1
let g:gundo_right = 0
let g:gundo_width = 45
let g:gundo_preview_height = 20
let g:gundo_preview_bottom = 0
" }}}

" NERDTree {{{ 
nnoremap <leader>n :NERDTreeToggle<cr>
" let loaded_nerd_tree = 0
let NERDTreeWinPos = "left"
let NERDTreeWinSize = 30
let NERDTreeCasadeOpenSingleChildDir = 1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeIgnore = ['\~$']
let NERDTreeSortOrder = ['\/$', '*', '\.swp$',  '\.bak$', '\~$']
let NERDTreeBookmarksFile = $HOME.'/.cache/nerdtree/.NERDTreeBookmarks'
let NERDTreeShowBookmarks = 1
" }}} 

" PIV (php integration for vim) {{{
let g:DisableAutoPHPFolding = 0 
"}}} 

" Supertab {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" }}}

" Syntastic {{{
nnoremap <leader>xt :SyntasticToggleMode<CR>
nnoremap <leader>xc :SyntasticCheck<CR>
nnoremap <leader>xe :Errors<CR>
let g:syntastic_quiet_warnings=1
let g:syntastic_check_on_open=0
let g:syntastic_auto_jump=0
let g:syntastic_echo_current_error=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_php_checkers=['php', 'phpmd', 'phpcs']
let g:syntastic_php_phpcs_args="--report=csv --standard=Zend --error-severity=8 --warning-severity=8 "
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }




" }}}

" Tagbar {{{
nnoremap <silent> <leader>t :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 40
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 0
let g:tagbar_show_visibility = 1
let g:tagbar_expand = 1
let g:tagbar_foldlevel = 2
let g:tagbar_autoshowtag = 0

let g:tagbar_type_markdown = {
	\ 'ctagstype' : 'markdown',
	\ 'kinds' : [
		\ 'h:Heading_L1',
		\ 'i:Heading_L2',
		\ 'k:Heading_L3'
	\ ]
\ }

" }}}

" Ultisnips {{{
nnoremap <leader>us :UltiSnipsEdit<CR>
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir=$VIMRUNTIME."/snippets"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"}}}

" Vimcommander {{{
 noremap <silent> <leader>f :cal VimCommanderToggle()<CR>   
" }}}

" }}}
