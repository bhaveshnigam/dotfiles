""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" OS X Mavericks. VIM installation procedure:
" http://benfrain.com/compiling-custom-vim-source-os-x-10-9-mavericks/

" See: https://github.com/fatih/vim-go/issues/30
" Ensure that vim uses the bash shell.
" if $SHELL =~ 'fish'
"  set shell=sh
" endif


if &shell =~# 'fish$'
  set shell=sh
endif

set nocompatible    " don't be compatible with vi
filetype on         " turn it on, then off. breaks git commits otherwise.
filetype off        " required by vundle.

" Automatically reload vimrc upon save.
autocmd! BufWritePost .vimrc source %
autocmd! BufWritePost vimrc source %

" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/vim-easy-align'

" Plug 'Lokaltog/powerline'
Plug 'bling/vim-airline'
Plug 'mbbill/undotree'
" Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'

" Language-specific
" Plug 'dart-lang/dart-vim-plugin'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'uarun/vim-protobuf'
Plug 'Rykka/riv.vim'  " restructured text
Plug 'neo4j-contrib/cypher-vim-syntax'
Plug 'jceb/vim-orgmode'
Plug 'lervag/vimtex'

" Completion and suggestions.
Plug 'Valloric/YouCompleteMe'
" Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
" Plug 'SirVer/ultisnips'
Plug 'kien/ctrlp.vim'
" Plug 'andrep/vimacs'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
Plug 'nsf/gocode', { 'rtp': 'vim/' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Color schemes.
Plug 'fatih/molokai'

" Code checking.
" Plug 'scrooloose/syntastic'

call plug#end()

" ----------------------------------------------------------------------
" No annoying sound on errors
" ----------------------------------------------------------------------
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" ----------------------------------------------------------------------
" File backups (please use git or mercurial instead).
" We don't want backup files because they also interfere with
" file monitoring programs.
" ----------------------------------------------------------------------
set autoread                 " Automatically reload files that change on disk.
set nobackup                 " Do not create backup files.
set nowritebackup            " No writeback.
set noswapfile               " No swapfiles.
set modeline                 " Allow vim modelines in files.
set modelines=5              " Lines within which modelines can be found.


" ----------------------------------------------------------------------------
" Colors, fonts, and appearance
" ----------------------------------------------------------------------------
syntax enable                   " enable syntax processing

set nofoldenable                " disable folding

set number                      " show line numbers
set relativenumber              " show relative numbering
set showcmd                     " show command in bottom bar
set ruler                       " always show current position
set cursorline                  " highlight current line
set title

set showtabline=2               " Always display tabline even if only 1 tab
set laststatus=2                " Always display statusline in all windows
set noshowmode                  " Hide the default mode text


filetype indent on  " load filetype-specific indentation

" Margins
set colorcolumn=80              " Show a right margin.

" Highlight lines that are longer than the right margin.
function! HighlightTooLongLines()
  highlight def link RightMargin Error
  if &textwidth != 0
    exec ('match RightMargin /\%>' . &textwidth . 'v.\+/')
 endif
endfunction

augroup filetypedetect
  au WinEnter,BufNewFile,BufRead * call HighlightTooLongLines()
augroup END


" ----------------------------------------------------------------------------
" Performance optimizations
" ----------------------------------------------------------------------------
set lazyredraw      " redraw only when we need to


" ----------------------------------------------------------------------------
" Autocompletion and suggestions
" ----------------------------------------------------------------------------
set wildmode=list:longest
set wildmenu        " visual autocomplete for commands

" Ignore these files from autocompletion.
set wildignore+=*.o,*~,*.obj,.git,*.pyc,*.pyo,*.a
set wildignore+=eggs/**
set wildignore+=*.egg-info/**


" ----------------------------------------------------------------------------
" Search and matching
" ----------------------------------------------------------------------------
set incsearch
set hlsearch
set ignorecase        " Ignore case when searching
set smartcase         " When searching try to be smart about cases
set showmatch         " highlight matching parentheses
set mat=2             " Highlight parens for duration.



" ----------------------------------------------------------------------------
" Editing.
" ----------------------------------------------------------------------------
set encoding=utf8         " UTF-8 as standard encoding.
set ffs=unix,dos,mac      " Use UNIX as standard file type.
set history=1000          " Remember these many lines.
if has("mouse")
  set mouse=a             " On OS X press Option and click.
endif
set undolevels=1000       " Allow more undo levels.

" Indentation and whitespace
set autoindent                  " Automatically indent.
set smartindent                 " Smart indent.
set nowrap                      " Don't wrap lines.

set tabstop=2             " number of visual spaces per TAB
set softtabstop=2         " number of spaces in tab when editing
set shiftwidth=2          " Use 2 spaces per shift.
set expandtab             " tabs are spaces
set smarttab              " Use tabs intelligently.
set shiftround            " Indenting with < and > is times shiftwidth.

set backspace=eol,start,indent  " Tell backspace to behave.
set whichwrap+=<,>,h,l

au FileType python setl sw=2 sts=2 et

" " Show trailing whitespace.
" if has("autocmd")
"   autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"   au InsertLeave * match ExtraWhitespace /\s\+$/
" endif

" Deletes trailing whitespace.
func! DeleteTrailingWhitespace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

if has("autocmd")
  autocmd FileType html,dart,markdown,python,javascript,go,sh,bash,yaml,csh,text,php,c,cpp,java autocmd BufWritePre <buffer> :call DeleteTrailingWhitespace()
  autocmd BufWritePre *.coffee :call DeleteTrailingWhitespace()
  autocmd BufWritePre .vimrc :call DeleteTrailingWhitespace()
  autocmd BufWritePre vimrc :call DeleteTrailingWhitespace()
endif

" Removes trailing blank lines from files and preserve cursor position.
" See:
" http://stackoverflow.com/questions/7495932/how-can-i-trim-blank-lines-at-the-end-of-file-in-vim
function! TrimEndBlankLines()
  let save_cursor = getpos(".")
  :silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', save_cursor)
endfunction
au FileType * autocmd BufWritePre <buffer> :call TrimEndBlankLines()

" ----------------------------------------------------------------------------
" Keyboard bindings.
" ----------------------------------------------------------------------------

nnoremap ; :

" Clear the last search highlighting in vim.
" See: https://coderwall.com/p/pcha8g
" Don't do this.
" nnoremap <esc> :noh<return><esc>
noremap <leader><space> :nohlsearch<CR> " turn off search highlight

"
" nnoremap <silent><leader>n :set rnu! rnu? <cr>
nnoremap <silent><leader>n :set relativenumber!<cr>

" Fast save.
nmap <leader>w :w!<CR>
nmap <leader>ww :wq<CR>

" Quit window.
nmap <leader>q :q<CR>
nmap <leader>qq :qa!<CR>

" Paste from clipboard.
nmap <leader>v "+p
" nmap <leader>c "+yy
vmap <leader>c "+yy

" Edit and reload vim configuration.
nmap <leader>ve :tabedit $MYVIMRC<CR>
nmap <leader>vr :source $MYVIMRC<CR>

" Strip off 2 keystrokes from almost every Vim command by aliasing this.
nnoremap ; :

" Forgot to use sudo to edit a file? Just use this.
cmap w!! w !sudo tee % >/dev/null

" Window splitting.
nmap <leader>\ :vsplit<CR>
nmap <leader>- :split<CR>

" Window navigation.
map <leader>j <c-w>j
map <leader>h <c-w>h
map <leader>k <c-w>k
map <leader>l <c-w>l
"map <leader>[ <c-w>h
"map <leader>] <c-w>l

" Sort lines.
vnoremap <leader>s :sort<CR>

" Indentation.
vnoremap < <gv  " Better outdent.
vnoremap > >gv  " Better indent.

" Alignment and filling.
vmap Q gq
nmap Q gqap

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Replace line with shell command output.
map <F7> !!sh<CR><ESC>

" Append line with shell command output.
map <s-F7> yyp!!sh<CR><ESC>


" ----------------------------------------------------------------------------
" Clipboard.
" ----------------------------------------------------------------------------
" set paste                       " Don't automatically indent pastes.
" set pastetoggle=<F2>            " Allow toggling paste.
" set clipboard+=unnamedplus


" ----------------------------------------------------------------------------
" Automatically assign executable permissions if file begins with #!
" and contains '/bin/' in the path.
" ----------------------------------------------------------------------------
function! AutoAssignExecutablePermissions()
  if getline(1) =~ "^#!"
    if getline(1) =~ "/bin/"
      silent !chmod a+x %
    elseif getline(1) =~ "/usr/bin/"
      silent !chmod a+x %
    endif
  endif
endfunction
autocmd BufWritePost * :call AutoAssignExecutablePermissions()


" ----------------------------------------------------------------------------
" Color schemes. Apply this last.
" ----------------------------------------------------------------------------
" let g:molokai_original = 1
colorscheme molokai

" Fonts and gui behavior.
if has("gui_running")
  " set guioptions-=m          " Remove the menu bar.
  " set guioptions-=T          " Remove the toolbar.
  set guioptions+=a            " Interact with the system clipboard.
  set lines=50 columns=120
  if has("gui_macvim")
    set guifont=Monaco:h13
  elseif has("gui_gtk2")
    " set guifont=Monaco\ 11
    set guifont=Ubuntu\ Mono\ 12
  endif
endif

" ----------------------------------------------------------------------------
" Plugin configuration
" ----------------------------------------------------------------------------
" Fast file browsing and buffer switching.
map <leader>o :NERDTreeToggle<CR>
map <leader>p :CtrlP<CR>
"map <leader>b :CtrlPBuffer<CR>
"map <leader>r :CtrlPMRUFiles<CR>
let g:ctrlp_map = '<c-P>'
let g:ctrlp_cmd = 'CtrlP'

" Airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" To open a new empty buffer
" " This replaces :tabnew which I used to bind to this mapping
nmap <leader>t :enew<cr>
"
" " Move to the next buffer
nmap <leader>] :bnext<CR>
"
" " Move to the previous buffer
nmap <leader>[ :bprevious<CR>
"
" " Close the current buffer and move to the previous one
" " This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
"
" " Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Go lang.
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

au FileType go nmap <Leader>s <Plug>(go-implements)   " interfaces implemented
au FileType go nmap <Leader>i <Plug>(go-info)         " show type info

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap gd <Plug>(go-def)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)



" Map start key separately from next key
"let g:multi_cursor_start_key='<C-}>'
"let g:multi_cursor_next_key='<C-}>'
"let g:multi_cursor_prev_key='<C-{>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<Esc>'

" Compatibility between UltiSnips and YCM.
" http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
" function! g:UltiSnips_Complete()
"     call UltiSnips#ExpandSnippet()
"     if g:ulti_expand_res == 0
"         if pumvisible()
"             return "\<C-n>"
"         else
"             call UltiSnips#JumpForwards()
"             if g:ulti_jump_forwards_res == 0
"                return "\<TAB>"
"             endif
"         endif
"     endif
"     return ""
" endfunction

" "au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" "let g:UltiSnipsJumpForwardTrigger="<tab>"
" "let g:UltiSnipsListSnippets="<c-e>"

" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" See http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" Tabularize plugin.
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

let g:VM_Enabled = 1

let delimitMate_expand_cr = 1

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
