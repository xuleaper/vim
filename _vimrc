" Author: xuleaper<xuleaper@gmail.com>
" Description: xuleaper's personal vim config file
" Blog: http://blog.csdn.net/xuleaper
" Since:2010-06-15
" History:
" 2013-11-18
" +update vim7.4 and add the new font 'Yahei_Consolas_hybrid'
" 2012-10-28
" +compress vimrc
" 2012-06-08
" +add Neobundle to manage plugins
" 2011-09-08
" +build vimrG
" ============
" Environment
" ============
syntax on
" �п���
set noscrollbind
set linebreak
set nocompatible
set textwidth=80
set wrap
" ��ǩ
set tabpagemax=9
set showtabline=2
" �кźͱ��
set number
set ruler
" ��������״̬��
set ch=2
set ls=2 " ʼ����ʾ״̬��
set wildmenu "�����в�ȫ����ǿģʽ����
" Search Option
set hlsearch  " Highlight search things
set magic     " Set magic on, for regular expressions
set showmatch " Show matching bracets when text indicator is over them
set mat=2     " How many tenths of a second to blink
set noincsearch
" �Ʊ��
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set iskeyword+=_,$,@,%,#,-
" ״̬����ʾĿǰ��ִ�е�ָ��
set showcmd 
" ����
set autoindent
set smartindent
" �Զ����¶���
set autoread
" ����ģʽ��ʹ�� <BS>��<Del> <C-W> <C-U>
set backspace=indent,eol,start
" �趨���κ�ģʽ����궼����
set mouse=a
" �Զ��ı䵱ǰĿ¼
"set autochdir
" ���ݺͻ���
set nobackup
set noswapfile
" �����۵�
set foldmethod=marker
" �����ⲿ������
set clipboard+=unnamed
" Diff ģʽ��ʱ�����ͬ������ for Vim7.3
set cursorbind
" ���� <Leader> Ϊ����
let mapleader = ","
let maplocalleader = ",""���ÿ��ٱ༭.vimrc�ļ� ,e �༭.vimrc
" �����޸� vimrc �ļ�
if has("win32")
    map <silent> <leader>e :e $VIM/_vimrc<cr>
else
    map <silent> <leader>e :e $VIM/.vimrc<cr>
endif
"����.vimrc�ļ�����Զ������µ�.vimrc
autocmd! bufwritepost _vimrc source $VIM/_vimrc

" =====================================================================
" Multi_language setting default encoding UTF  
" =====================================================================

if has("multi_byte")
    set encoding=utf-8
    if has('win32')
        language chinese
        let &termencoding=&encoding
    endif
    set nobomb " ��ʹ�� Unicode ǩ��
    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

"========================================================================
" GUI setting
" =======================================================================

if has('gui_running')
    " ֻ��ʾ�˵�
    set guioptions=mcr
    " ����������ڵ���
    set cursorline
    if has("win32")
        au GUIEnter * simalt ~x
        " �� Win32 �µ� gVim ��������͸����
        au GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 235)
        " Windows ��������
        source $VIMRUNTIME/mswin.vim
        source $VIMRUNTIME/menu.vim
        source $ViMRUnTIME/delmenu.vim
        exec 'set guifont='.iconv('Consolas', &enc, 'gbk').':h12:cANSI'
        if has("guifontwide")
            exec 'set guifontwide='.iconv('YaHei\ Consolas\ Hybrid:h12', &enc, 'gbk').':h12:cGB2312'
        endif
    endif
    " Under Linux/Unix etc.
    if has("unix") && !has('gui_macvim')
        set guifont=Courier\ 10\ Pitch\ 11
    endif
    " Under the Mac(MacVim)
    if has("mac") || has("gui_macvim")
        if has("gui_macvim")
            " MacVim �µ���������
            set guifont=Courier_New:h14
            set guifontwide=YouYuan:h14
            " ��͸���ʹ��ڴ�С
            set transparency=2
            set lines=200 columns=120
            " ʹ�� MacVim ԭ����ȫ��Ļ����
            let s:lines=&lines
            let s:columns=&columns
            func! FullScreenEnter()
                set lines=999 columns=999
                set fu
            endf
            func! FullScreenLeave()
                let &lines=s:lines
                let &columns=s:columns
                set nofu
            endf
            func! FullScreenToggle()
                if &fullscreen
                    call FullScreenLeave()
                else
                    call FullScreenEnter()
                endif
            endf
            set guioptions+=e
            " Mac �£��� <Leader>ff �л�ȫ��
            nmap <f11> :call FullScreenToggle()<cr>
            nmap <Leader>ff  :call FullScreenToggle()<cr>
            " I like TCSH :^)
            set shell=/bin/tcsh
            " Set input method off
            set imdisable
            " ���Ϊ���ļ������Զ����õ�ǰĿ¼Ϊ����
            lcd ~/Desktop/
        endif
    endif
else
    colorscheme distinguished
    set number
endif
" ===========================================
" AutoCmd
" ===========================================
if has("autocmd")
    filetype plugin indent on
    " �����Զ���ȫ
    func! AutoClose()
        :inoremap ( ()<ESC>i
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
    endf
    func! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=80
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END
    " Auto close quotation marks for PHP, Javascript, etc, file
    au FileType php,javascript,c,cpp exe AutoClose()
endif
" ==================
" script's functions  
"===================
" ��ȡ��ǰĿ¼
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf
" ȫѡ
func! SelectAll()
    let s:current = line('.')
    exe "norm gg" . (&slm == "" ? "VG" : "gH\<C-O>G")
endfunc
"����������ϣ��Ƿ�ֹvimrc�ļ���������ʱ����
"ʵ�ֹ��λ���Զ�����:) -->  ):
function! Swap()
    if getline('.')[col('.') - 1=~ ")"
        return "\<ESC>la:"
    else
        return ":"
    endif
endf
"------------------------------------------------------------------------------------
"SwitchToBuf()ʵ���������б�ǩҳ�Ĵ����в���ָ�����ļ���������ҵ�����һ�����ڣ�
"�������˴����У��������½�һ����ǩҳ����vimrc�ļ�
"�����Զ��༭.vimrc�ļ��õ��ĺ���
function! SwitchToBuf(filename)
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction
" =============
" Key Shortcut
" =============
nmap <leader>l :set list!<cr>
for i in range(1, &tabpagemax)
    exec 'nmap <A-'.i.'> '.i.'gt'
endfor
set sessionoptions=buffers,curdir,resize,folds,tabpages,winsize,buffers
autocmd VimLeave * mks! $VIM/sessions/Session.vim  
nmap <F2> :wa<Bar>exe "mksession! " . v:this_session<CR>:so $VIM\sessions\session.vim<cr>
map <F6> zM    " �ر�������
map <F7> zR    " �������۵�
map <F12> :!ctags -R<CR>
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <silent><leader>ww <c-w>w
map <silent><leader>wl <c-w>l
map <silent><leader>wk <c-w>k
map <silent><leader>wj <c-w>j
map <silent><leader>wh <c-w>h
map <silent><leader>wn <c-w>n
map <silent><leader>wr <c-w>r
map <silent><leader>wR <c-w>R
map <silent><leader>wx <c-w>x
map <silent><leader>wo <c-w>o
imap jk <esc>
"==================
" Bundle setting
"=================
" Note: Skip initialization for vim-tiny or vim-small.
set nocompatible               " be iMproved
set runtimepath+=$VIM\bundle\neobundle.vim\
" Required:
call neobundle#begin(expand('$VIM\bundle\'))
 " Let NeoBundle manage NeoBundle
 " Required:
NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ichernev/a.vim'
NeoBundle 'scrooloose/nerdtree'
let g:NERDTreeWinPos = 'right'
nmap <silent><F7> :NERDTreeToggle<cr>
NeoBundle 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%F'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
au BufNewFile,BufRead,BufEnter,WinEnter * :AirlineRefresh
NeoBundle 'Shougo/neocomplete.vim'
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomlete#enable_smart_case = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
NeoBundle 'Shougo/neosnippet'
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
NeoBundle 'Shougo/neosnippet-snippets'
"vim-scripts 
NeoBundle 'tomasr/molokai'
let g:rehash256 = 1
NeoBundle 'c.vim'
let g:C_GlobalTemplateFile = $VIM.'\bundle\c.vim\c-support\templates\Templates'
NeoBundle 'mru.vim'
nmap <silent><Leader>mr :MRU<cr>
NeoBundle 'FencView.vim'
let g:fencview_autodetect = 1
NeoBundle 'L9'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'dhallman/bufexplorer'
let g:bufExplorerResize = 30
let g:bufExplorerUseCurrentWindow=1
nmap <Leader>bf :BufExplorer<cr>
NeoBundle 'Tagbar'
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_ctags_bin = '$VIMRUNTIME\ctags.exe'
nmap <silent><F8> :TagbarToggle<cr>
nmap <silent><Leader>ta :TagbarToggle<cr>
NeoBundle 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_c_avrgcc_config_file = '.config'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/nerdcommenter'

call neobundle#end()
"---------------------------------------------------
filetype plugin indent on     " required!
" Required
NeoBundleCheck
"==================================================================

colorscheme molokai

