" http://github.com/mitechie/pyvim
" ==================================================
" Dependencies
" ==================================================
" Pep8 : http://pypi.python.org/pypi/pep8
" pylint script
" curl - Gist plugin
" python-rope - for ropevim plugin

" ==================================================
" Shortcuts Documented
" ==================================================
" jj - esc
" ,b - bufferlist
" ,v - load .vimrc
" ,V - reload .vimrc
" ,m - run make
" ,M - alt make for filetype (pep8 for python, etc)
" ,y - yank to clipboard
" ,Y - yank current line to clipboard
" ,p - paste from clipboard
" ,q - reformat text paragraph
" ,s - toggle spellcheck
" ,S - remove end of line spaces
" ,c  - open the quickfix window
" ,cc - close the quickfix window
" ,t - toggle nerdtree
" ,r - view registers
" ,t - collapse/fold html tag
"
" Y  - yank to the end of the line
"
" <CR> - create newline with enter key
" C-n  - clear search
" C-l  - Omnicompletion
" C-p  - ctags completion
"
" gc        - comment the highlighted text
" gcc       - comment out the current line
"
" cs"(      - replace the " with (
" ysiw"     - wrap current text object with "
" yss"      - wrap current line with "
" S         - in visual mode surroud with something
" ds(       - remove wrapping ( from text
"
" ,,   - complete snippet
" ,,   - tab to next section of snippet
" ,n   - list available snippets for this filetype
"
" ,pw  - search for keyword in pydocs
" ,pW  - search any pydoc for this keyword
"
" F11  - toggle :set paste on/off
"
" Windows
" ctrl-jklm - swap to that split without the ctrl-w
" +/-       - shrink the current split verticall
" alt-,/.   - move the split vertically
" F2        - close current split
"
" :Gist
" :Gist -p (private)
" :Gist XXXX (fetch Gist XXXX and load)
"
" :PG XXXX php - vimgrep the project for XXXX in .php files requird workit
"
" TwitVim
" <F7>/<F8> - load timelines
" :Bpost... - post
" ,g        - load user's timeline
" ,d        - direct message
" ,@        - load the parent to this post
" :IsGd {url} - shorten the url
"
" -----------------------------------------
" Printing:
" set printoptions=paper:A4,syntax:y,wrap:y
" http://vim.runpaint.org/basics/printing/

" bootstrap the pathogen part of the config right away
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Highlight end of line whitespace.
" match WhitespaceEOL /\s\+$/
au InsertEnter * match WhitespaceEOL /\s\+$/
au InsertLeave * match WhitespaceEOL /\s\+$/

" make sure our whitespace matching is setup before we do colorscheme tricks
autocmd ColorScheme * highlight WhitespaceEOL ctermbg=red guibg=red

" now proceed as usual
syntax on                 " syntax highlighing
filetype on               " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype

" In GVIM
if has("gui_running")
    set guifont=Cousine\ 8" use this font
    set lines=75          " height = 50 lines
    set columns=180       " width = 100 columns
    set background=dark   " adapt colors for background
    set keymodel=
    set mousehide
    colorscheme underwater-mod
    colorscheme void

    " To set the toolbars off (icons on top of the screen)
    set guioptions-=T
else
    set background=dark   " adapt colors for dark background
    colorscheme lucius
    set t_Co=256
endif


" ==================================================
" Basic Settings
" ==================================================
let mapleader=","       " change the leader to be a comma vs slash
set textwidth=79        " Try this out to see how textwidth helps
set ch=3                " Make command line two lines high
set ls=2                " allways show status line
set tabstop=4           " numbers of spaces of tab character
set shiftwidth=4        " numbers of spaces to (auto)indent
set scrolloff=3         " keep 3 lines when scrolling
set nocursorline        " have a line indicate the cursor location
set cindent             " cindent
set autoindent          " always set autoindenting on
set showcmd             " display incomplete commands
set ruler               " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell
set nobackup            " do not keep a backup file
set number              " show line numbers
set title               " show title in console title bar
set ttyfast             " smoother changes
set modeline            " last lines in document sets vim mode
set modelines=3         " number lines checked for modelines
set shortmess=atI       " Abbreviate messages
set nostartofline       " don't jump to first character when paging
set backspace=start,indent,eol
set matchpairs+=<:>     " show matching <> (html mainly) as well
set showmatch
set matchtime=3
set spell
set expandtab           " tabs are converted to spaces, use only when required
set sm                  " show matching braces, somewhat annoying...

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" move freely between files
set whichwrap=b,s,h,l,<,>,[,]

set tags=tags;/         " search for tags file in parent directories

" complete in vim commands with a nice list
set wildmenu
set wildmode=longest,list
set wildignore+=*.pyc

" set the paste toggle key
set pastetoggle=<F11>

" replace the default grep program with ack
set grepprg=ack-grep

" ==================================================
" Config Specific Settings
" ==================================================

" If we're running in vimdiff then tweak out settings a bit
if &diff
   set nospell
endif


" ==================================================
" Basic Maps
" ==================================================

" Maps for jj to act as Esc
ino jj <esc>
cno jj <c-c>

" map ctrl-c to something else so I quick using it
map <c-c> <Nop>
imap <c-c> <Nop>

" ,v brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Run Make with ctrl-m or ,m
map <silent> <leader>m :make<CR>

" quick insertion of a newline
nmap <CR> o<Esc>

" Y yanks to the end of the line
nmap Y y$

" shortcuts for copying to clipboard
nmap <leader>y "*y

" copy the current line to the clipboard
nmap <leader>Y "*yy
nmap <leader>p "*p

" show the registers from things cut/yanked
nmap <leader>r :registers<CR>

" map the various registers to a leader shortcut for pasting from them
nmap <leader>0 "0p
nmap <leader>1 "1p
nmap <leader>2 "2p
nmap <leader>3 "3p
nmap <leader>4 "4p
nmap <leader>5 "5p
nmap <leader>6 "6p
nmap <leader>7 "7p
nmap <leader>8 "8p
nmap <leader>9 "9p

" shortcut to toggle spelling
nmap <leader>s :setlocal spell! spelllang=en_us<CR>

" setup a custom dict for spelling
" zg = add word to dict
" zw = mark word as not spelled correctly (remove)
set spellfile=~/.vim/dict.add


" shortcuts to open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

nnoremap <leader>q gqap

" ==================================================
" Windows / Splits
" ==================================================

" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Hints for other movements
" <c-w><c-r> rotate window to next spot
" <c-w><c-x> swap window with current one

" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
imap <C-W> <C-O><C-W>

" use - and + to resize horizontal splits
map - <C-W>-
map + <C-W>+

" and for vsplits with alt-< or alt->
map <M-,> <C-W>>
map <M-.> <C-W><

" F2 close current window (commonly used with my F1/F3 functions)
noremap <f2> <Esc>:close<CR><Esc>

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")


" ==================================================
" Search
" ==================================================

" Press Ctrl-N to turn off highlighting.
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set ignorecase          " ignore case when searching
set smartcase           " if searching and search contains upper case, make case sensitive search

nmap <silent> <C-N> :silent noh<CR>

" Clean all end of line extra whitespace with ,S
" Credit: voyeg3r https://github.com/mitechie/pyvim/issues/#issue/1
" deletes excess space but maintains the list of jumps unchanged
" for more details see: h keepjumps
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
map <silent><leader>S <esc>:keepjumps call CleanExtraSpaces()<cr>

" ==================================================
" Completion
" ==================================================

" complete on ctrl-l
inoremap <C-l> <C-x><C-o>

set complete+=.
set complete+=k
set complete+=b
set complete+=t

set completeopt+=menuone,longest

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1
let g:SuperTabMidWordCompletion = 1


" ==================================================
" Filetypes
" ==================================================

" Auto change the directory to the current file I'm working on
autocmd BufEnter * lcd %:p:h

" make the smarty .tpl files html files for our purposes
au BufNewFile,BufRead *.tpl set filetype=html
au BufNewFile,BufRead,BufEnter *.mako set filetype=mako

" Filetypes (au = autocmd)
au filetype help set nonumber      " no line numbers when viewing help
au filetype help nnoremap <buffer><cr> <c-]>   " Enter selects subject
au filetype help nnoremap <buffer><bs> <c-T>   " Backspace to go back

"If we're editing a mail message in mutt change to 70 wide and wrap
"without linex numbers
augroup mail
    autocmd!
    autocmd FileType mail set textwidth=70 wrap nonumber nocursorline
augroup END

" If we're editing a .txt file then skip line numbers
au! BufRead,BufNewFile *.txt set nonu

" automatically give executable permissions if file begins with #! and contains
" '/bin/' in the path
au bufwritepost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile> | endif | endif

" ==================================================
" Python
" ==================================================
au BufReadPost quickfix map <buffer> <silent> <CR> :.cc <CR> :ccl

au BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" ==================================================
" Javascript
" ==================================================
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen

au BufRead *.js set makeprg=jslint\ %

" ==================================================
" HTML
" ==================================================
" enable a shortcut for tidy using ~/.tidyrc config
map <Leader>T :!tidy -config ~/.tidyrc<cr><cr>

" enable html tag folding with ,f
nnoremap <leader>f Vatzf

" ==================================================
" Syntax Files
" ==================================================

" xml.vim
" http://github.com/sukima/xmledit/
" % jump between '<' and '>' within the tag
" finish a tag '>'
" press '>' twice it will complete and cursor in the middle

" mako.vim
" http://www.vim.org/scripts/script.php?script_id=2663
" syntax support for mako code

" ==================================================
" Plugins
" ==================================================

" lusty-juggler
" http://www.vim.org/scripts/script.php?script_id=2050
nmap <silent> <Leader>b :LustyJuggler<CR>

" NERDTree
" http://www.vim.org/scripts/script.php?script_id=1658
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
map <leader>t :NERDTree<CR>

" tComment
" http://www.vim.org/scripts/script.php?script_id=1173
" gc        - comment the highlighted text
" gcc       - comment out the current line

" pep8
" http://www.vim.org/scripts/script.php?script_id=2914
autocmd FileType python map <buffer> <leader>M :call Pep8()<CR>


" python folding jpythonfold.vim
" http://www.vim.org/scripts/script.php?script_id=2527
" Setup as ftplugin/python.vim for auto loading

" PyDoc
" http://www.vim.org/scripts/script.php?script_id=910
" Search python docs for the keyword
" <leader>pw - search for docs for what's under cursor
" <leader>pW - search for any docs with this keyword mentioned

" Supertab
" http://www.vim.org/scripts/script.php?script_id=182
" :SuperTabHelp

" SnipMate
" http://www.vim.org/scripts/script.php?script_id=2540
" ,, - complete and tab to next section
" ,n - show list of snippets for this filetype

" bundle/snipmate/after/plugin/snipmate
ino <silent> <leader>, <c-r>=TriggerSnippet()<cr>
snor <silent> <leader>, <esc>i<right><c-r>=TriggerSnippet()<cr>
ino <silent> <leader>\< <c-r>=BackwardsSnippet()<cr>
snor <silent> <leader>\< <esc>i<right><c-r>=BackwardsSnippet()<cr>
ino <silent> <leader>n <c-r>=ShowAvailableSnips()<cr>

" Surround
" http://www.vim.org/scripts/script.php?script_id=1697
" default shortcuts

" Pyflakes
" http://www.vim.org/scripts/script.php?script_id=3161
" default config for underlines of syntax errors in gvim

" Gist - github pastbin
" http://www.vim.org/scripts/script.php?script_id=2423
" :Gist
" :Gist -p (private)
" :Gist XXXX (fetch Gist XXXX and load)
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" TwitVim
" http://vim.sourceforge.net/scripts/script.php?script_id=2204
" Twitter/Identica client for vim
" F7/F8 for loading identica/twitter
"source ~/.vim/twitvim.vim

" RopeVim
" http://rope.sourceforge.net/ropevim.html
" Refactoring engine using python-rope
source /usr/local/ropevim.vim
let ropevim_codeassist_maxfixes=10
let ropevim_vim_completion=1
let ropevim_guess_project=1
let ropevim_enable_autoimport=1
let ropevim_extended_complete=1

" function! CustomCodeAssistInsertMode()
"     call RopeCodeAssistInsertMode()
"     if pumvisible()
"         return "\<C-L>\<Down>"
"     else
"         return ''
"     endif
" endfunction
"
" function! TabWrapperComplete()
"     let cursyn = synID(line('.'), col('.') - 1, 1)
"     if pumvisible()
"         return "\<C-Y>"
"     endif
"     if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$' || cursyn != 0
"         return "\<Tab>"
"     else
"         return "\<C-R>=CustomCodeAssistInsertMode()\<CR>"
"     endif
" endfunction
"
" inoremap <buffer><silent><expr> <C-l> TabWrapperComplete()

" ==================================================
" Custom Functions
" ==================================================

" PGrep function to basically do vimgrep within the predefined $PROJ_DIR from
" workit scripts.
" :PG support php -- search the project for /support/j **/*.php
function! PGrep(pattern, ...)
    let pattern = a:pattern

    if a:0 == 0
        let ext = '*'
    else
        let ext = a:1
    endif

    let proj_path = system("echo $PROJ_PATH | tr -d '\n'")
    :exe 'cd '.proj_path

    let search_path = "**/*." . ext

    :execute "vimgrep /" . pattern . "/j " search_path | :copen
endfunction
command! -nargs=* PG :call PGrep(<f-args>)

" javascript folding
function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
