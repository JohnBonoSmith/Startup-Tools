" general tweaks
set nocompatible
set ruler
set number
set wildmenu
set backspace=indent,eol,start

" code folding
set foldlevel=100
set foldmethod=indent

" searching options
set ignorecase
set hlsearch
set incsearch

" coloring
set background=dark
syntax enable

" indenting
set expandtab
set shiftwidth=4
set smarttab
set autoindent
filetype plugin indent on

" Left-hand project directory drawer on :VExplore or \F
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Plug 'vim-scripts/restore_view.vim' Configuration
set viewoptions=cursor,folds,slash,unix

" Plug 'itchyny/lightline.vim' Configuration
set laststatus=2
let g:lightline = { 'colorscheme' : 'powerlineish' }

" Plug 'francoiscabrol/ranger.vim' Configuration
let g:ranger_replace_netrw = 1

" Plug 'vimwiki/vimwiki' Configuration
let g:vimwiki_list = [ { 'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'expr'

" Allow the clipboard to work between vim/MacOS
" TODO: Investigate getting this functionality over ssh/iTerm.
" TODO: vim on Debian is compiled without +clipboard, compile your own.
set clipboard=unnamed

" Disable mouse
set mouse=""

set viminfo=%,<800,'10,/50,:100,h,f0,n~/.viminfo
"           | |    |   |   |    | |  + viminfo file path
"           | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"           | |    |   |   |    + disable 'hlsearch' loading viminfo
"           | |    |   |   + command-line history saved
"           | |    |   + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list
    
" use guifg/guibg instead of ctermfg/ctermbg in terminal
if has('termguicolors')
    set termguicolors 
    " For tmux
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


" lightline + lightline-bufferline config
" set showtabline=2
" let g:lightline#bufferline#show_number  = 1
" let g:lightline = {
"       \ 'colorscheme': 'powerlineish',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'tabline': {
"       \   'left': [ ['buffers'] ],
"       \   'right': [ ['close'] ]
"       \ },
"       \ 'component_expand': {
"       \   'buffers': 'lightline#bufferline#buffers'
"       \ },
"       \ 'component_type': {
"       \   'buffers': 'tabsel'
"       \ }
"       \ }


" If we have a ~/.vim/autoload/plug.vim then we will set up the plugin manager
" so that our plugins will be installed.
if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin('~/.vim/plugged')
    Plug 'francoiscabrol/ranger.vim' " Remember to install ranger (brew install ranger)
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'vimwiki/vimwiki'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'itchyny/lightline.vim'
    Plug 'farmergreg/vim-lastplace'
    Plug 'itchyny/calendar.vim'
    Plug 'vim-scripts/restore_view.vim'
    Plug 'inkarkat/vim-ingo-library'
    Plug 'inkarkat/vim-spellcheck'
    " Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown' " Depends on ordering.
    call plug#end()
endif

" Common mappings for most programming languages, these will be enabled by
" InitalizeVimBuffer() for most coding files.
fun CustomMacrosEnableBasicCompletion()
    inoremap ( ()<Esc>i
    inoremap [ []<Esc>i
    inoremap { {}<Esc>i
    inoremap (<Space> (  )<Esc>hi
    inoremap [<Space> [  ]<Esc>hi
    inoremap {<Space> {  }<Esc>hi
    inoremap (<CR> (<CR>)<Esc>O
    inoremap [<CR> [<CR>]<Esc>O
    inoremap {<CR> {<CR>}<Esc>O
endfun

" function that is run whenever a new buffer is switched to - so we can set
" proper macros depending on the type of the file that is opened
fun InitalizeVimBuffer()
    " Taken from https://github.com/tpope/vim-rsi/blob/master/plugin/rsi.vim
    " Give me ^A and ^E in insert mode to go to beginning/end of the line, like I
    " can on the terminal.
    inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"
    inoremap        <C-A> <C-O>^

    " Use <Esc> instead of <C-w> for window management.
    nnoremap <Esc>h <C-w>h
    nnoremap <Esc>j <C-w>j
    nnoremap <Esc>k <C-w>k
    nnoremap <Esc>l <C-w>l

    " Use <Esc> instead of <C-w> for window management with terminal windows
    " if they are supported in this version of vim.
    if has('terminal')
        tnoremap <Esc>h <C-w>h
        tnoremap <Esc>j <C-w>j
        tnoremap <Esc>k <C-w>k
        tnoremap <Esc>l <C-w>l
        tnoremap <silent> <C-[><C-[> <C-\><C-n>
    endif
    
    " Shift lines back and forth by indentation level with Shift-Up or Shift-Down
    nnoremap <S-Right> >>
    nnoremap <S-Left> <<
    inoremap <S-Right> <Esc>>>i
    inoremap <S-Left> <Esc><<i
    " Shift lines up and down with Shift-Up or Shift-Down
    nnoremap <S-Up> :m .-2<CR>==
    nnoremap <S-Down> :m .+1<CR>==
    inoremap <S-Up> <Esc>:m .-2<CR>==
    inoremap <S-Down> <Esc>:m .+1<CR>==

    " Move between tabs with Shift-] and Shift-[, create new tabs with \t
    nnoremap } :tabnext <CR>
    nnoremap { :tabprevious <CR>
    nnoremap <leader>t :tabnew <CR>

    " Create new window splits with \d and \D to mimic new windows in iTerm
    nnoremap <leader>d :spl <CR>
    nnoremap <leader>D :vspl <CR>

    " Create project directory drawer
    nnoremap <leader>F :Vexplore <CR>

    " Use Shift-J and Shift-K for page down/up like I could with arrows.
    nnoremap <S-k> <C-u>
    nnoremap <S-j> <C-d>

    " Commenting Code Out
    "   If we have plugins loaded, then we'll map c/S-c in visual mode to
    "   vim-commentary to have filetype specific commenting.  Otherwise we'll
    "   fall back to prepending the line with #
    if exists('g:loaded_plug')
        xmap C <Plug>Commentary
        xmap c <Plug>Commentary
    else
        vnoremap C :s/^/#/<CR>:nohl<CR>
        vnoremap c :s/^#//<CR>:nohl<CR>
    endif
    
    " Get rid of that terrible default background for folded text.
    hi Folded guibg=grey9

    if &filetype == "perl"
        inoremap IFB if (  ) {<CR>}<Esc>O <Esc>xk$3hi
        inoremap FOB for my $ (  ) {<CR>}<Esc>O <Esc>xk$6hi
        inoremap WHB while (  ) {<CR>}<Esc>O <Esc>xk$3hi
        inoremap PP package ;<CR><CR>use warnings;<CR>use strict;<CR><CR>1;<Esc>Hwi
        inoremap SUB sub  {<CR><Esc>0i  my () = @_;<CR><CR><Esc>0i}<Esc>kkkw<BS>i

        call CustomMacrosEnableBasicCompletion()
        map <F12> :!perl -c %<CR>

    elseif &filetype == "ruby"
        inoremap do<CR> do<CR>end<Esc>O
        inoremap IFB if  then<CR>end<Esc>O <Esc>xk$4hi
        " for loops do not exist in ruby as they do in other languages
        inoremap WHB while  do<CR>end<Esc>O <Esc>xk$2hi
        call CustomMacrosEnableBasicCompletion()
        map <F12> :!ruby -c %<CR>

    elseif &filetype == "python"
        inoremap IFB if :<CR> <Esc>xk$i
        inoremap FOB for  in :<CR> <Esc>xk$4hi
        inoremap WHB while :<CR> <Esc>xk$i
        call CustomMacrosEnableBasicCompletion()
        " TODO - is there some way to syntax check a python program?

    elseif &filetype == "sh"
        inoremap IFB if [  ]; then<CR>fi<Esc>O <Esc>xk$7hi
        inoremap FOB for  in ; do<CR>done<Esc>O <Esc>xk$7hi
        inoremap WHB while [  ]; do<CR>done<Esc>O <Esc>xk$5hi
        inoremap UNB until [  ]; do<CR>done<Esc>O <Esc>xk$5hi
        call CustomMacrosEnableBasicCompletion()
        " TODO - is there some way to syntax check a shell script?

    elseif &filetype == "lua"
        inoremap IFB if  then<CR>end<Esc>O <Esc>xk$4hi
        inoremap FOB for  do<CR>end<Esc>O <Esc>xk$2hi
        inoremap WHB while  do<CR>end<Esc>O <Esc>xk$2hi
        call CustomMacrosEnableBasicCompletion()
        map <F12> :!luac -p %<CR>

    elseif &filetype == "php"
        " the <BS> (heh, how appropriate) is needed to get rid of the messed
        " up syntax indentation in vim's way of dealing with php syntax
        inoremap IFB if (  ) {<CR><BS>}<Esc>O <Esc>xk$3hi
        inoremap WHB while (  ) {<CR><BS>}<Esc>O <Esc>xk$3hi
        inoremap FOB for ( ; ;  ) {<CR><BS>}<Esc>O <Esc>xk$7hi
        inoremap <?php <?php  ?><Esc>2hi
        inoremap <?php<CR> <?php<CR>?><Esc>hi<BS><Esc>O
        call CustomMacrosEnableBasicCompletion()
        map <F12> :!php -l %<CR>

    elseif &filetype == "vim"
        " no special ones for vim because that makes it hard to write this file!
        " however, the basic parentheses and bracket completion macros are
        " still useful, as they can always be reversed if needed.
        call CustomMacrosEnableBasicCompletion()

    elseif &filetype == "vimwiki"
        " Use the spacebar to mark checklist items.
        nmap <Space> <Plug>VimwikiToggleListItem

        " List Shifting
        map >> <Plug>VimwikiIncreaseLvlSingleItem
        "map >>> <Plug>VimwikiIncreaseLvlWholeItem
        map << <Plug>VimwikiDecreaseLvlSingleItem
        "map <<< <Plug>VimwikiDecreaseLvlWholeItem
        call CustomMacrosEnableBasicCompletion()


    elseif &filetype == "markdown"
        " Use the spacebar to mark checklist items.
        nmap <Space> <Plug>VimwikiToggleListItem
        " Don't do anything yet....

    elseif &filetype == "calendar"
        " The plugin seems to kill these mappings?  Maybe those should go at
        " the end?
        nnoremap { :tabNext <CR>
        nnoremap } :tabprevious <CR>


    " ignore the following types
    elseif &filetype == ""     " null (no) type
    elseif &filetype == "help" " internal help file
    elseif &filetype == "html" " HTML hypertext
    else
        " TODO - other file formats. this should remind me.
        echo "SetCustomMacros(): Unknown filetype " . &filetype . "."
    endif
endfun

" augroup calendar-mappings
"     autocmd!

"     autocmd FileType calendar nnoremap <buffer> } :tabNext <CR>
"     autocmd FileType calendar nnoremap <buffer> { :tabprevious <CR>

" augroup END


function! VimwikiWikiIncludeHandler(value) "{{{
    let str = a:value

    " complete URL
    let url_0 = matchstr(str, g:vimwiki_rxWikiInclMatchUrl)
    if filereadable(url_0)
        return '<pre>'.join(readfile(url_0), "\r").'</pre>'
    end

    " Return the empty string when unable to process link
    return ''
endfunction "}}}


" Set the above functions into the correct events.
augroup custom_macros
    autocmd!
    autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
    autocmd BufEnter * call InitalizeVimBuffer()
    autocmd FileType calendar nnoremap <buffer> } :tabNext <CR>
    autocmd FileType calendar nnoremap <buffer> { :tabprevious <CR>

augroup END

" That is the end of the configuration.  The following is installation
" instructions for MacOS and CentOS 7.
"
" MacOS Installation
"
" 1.  Install Home Brew
" 2.  brew install vim
" 3.  brew install ranger
" 4.  Add this to ~/.vimrc
"
" CentOS 7 Installation
" 
" === Run this script as root ===
"
" #!/bin/bash
" # Largely stolen from https://phoenixnap.com/kb/how-to-install-vim-centos-7
" if [ $UID != 0 ];
" then
"     echo "You must be root to run this script."
"     exit -1
" fi
"
" if [ ! -e /etc/redhat-release ];
" then
"     echo "This is only intended to be run on centos 7."
"     exit -1
" fi
"
" CENTOS_VERSION=`cut -b22 /etc/redhat-release`
" if [ $CENTOS_VERSION -ne 7 ];
" then
"     echo "This is only intended to be run on centos 7."
"     exit -1
" fi
"
" throw_error ( ) {
"     echo -e "\033[36mERROR: $1\033[0m"
"     exit -1
" }
"
" yum -y remove vim-enhanced vim-common vim-filesystem python2-pip
"
" yum -y install             \
"     ncurses                \
"     ncurses-devel          \
"     ctags                  \
"     git                    \
"     tcl-devel              \
"     ruby ruby-devel        \
"     lua lua-devel          \
"     luajit luajit-devel    \
"     python python-devel    \
"     python-setuptools      \
"     perl perl-devel        \
"     perl-ExtUtils-ParseXS  \
"     perl-ExtUtils-XSpp     \
"     perl-ExtUtils-CBuilder \
"     perl-ExtUtils-Embed
"
" yum -y groupinstall "Development Tools"
" 
" git clone https://github.com/vim/vim.git
" cd vim
" ./configure --with-features=huge  \
"     --enable-multibyte    \
"     --enable-rubyinterp   \
"     --enable-pythoninterp \
"     --enable-perlinterp   \
"     --enable-luainterp    \
"              || throw_error "The configure step failed."
" make         || throw_error "The make step failed."
" make install || throw_error "The make install step failed."
" 
" # Install Ranger
" git clone https://github.com/hut/ranger.git
" cd ranger
" python setup.py install --optimize=1 --record=install_log.txt
"
"
" echo -e "\033[32mVim was installed.\033[0m"
"  
" === END ROOT SCRIPT ===
"
" Now as a user, you'll want to:
"
" 1.  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 2.  vim -c ':PlugInstall' -c ':q' -c ':q'
" 3.  Modify ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/powerlineish.vim
"     Add the following patch:
"
" === PATCH START ===
"
" diff --git a/autoload/lightline/colorscheme/powerlineish.vim b/autoload/lightline/colorscheme/powerlineish.vim
" index 34058a8..198ccf1 100644
" --- a/autoload/lightline/colorscheme/powerlineish.vim
" +++ b/autoload/lightline/colorscheme/powerlineish.vim
" @@ -25,4 +25,10 @@ let s:p.tabline.right = [ [ 'gray9', 'gray1' ] ]
"  let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
"  let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]
"
" +" Let's override some of this because the blue insert bar is meh
" +" [ FOREGROUND_COLOR, BACKGROUND_COLOR, MODIFIERS ]
" +let s:p.insert.left = [ ['white', 'darkestblue', 'bold'], ['white', 'gray0'] ]
" +let s:p.insert.right = s:p.normal.right
" +let s:p.insert.middle = s:p.normal.middle
" +
"  let g:lightline#colorscheme#powerlineish#palette = lightline#colorscheme#fill(s:p)
"
" === PATCH END ===
