" Force 256 color mode if available
if $TERM =~ '-256color'
   set t_Co=256
endif

" ---------------
" Plugins
" ---------------
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')
" Declare the list of plugins.
Plug 'evidanary/grepg.vim'
Plug 'neomake/neomake'
Plug 'tpope/vim-surround'
Plug 'haishanh/night-owl.vim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ---------------
" UI
" ---------------
"set termguicolors  " True color in the terminal
hi Cursor guifg=green guibg=green
hi Cursor2 guifg=red guibg=red
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

set ruler          " Ruler on
set number         " Line numbers on

" turn hybrid line numbers on
" set number relativenumber

set nu rnu

set nowrap         " Line wrapping off
set laststatus=2   " Always show the statusline
set cmdheight=2    " Make the command area two lines high
set cursorline     " Highlight current line
set encoding=utf-8

colorscheme night-owl

set showmode
" set noshowmode     " Don't show the mode since Powerline shows it
set title          " Set the title of the window in the terminal to the file
if exists('+colorcolumn')
  highlight ColorColumn ctermbg=7
  set colorcolumn=120 " Color the 120th column differently as a wrapping guide.
endif

" disable tooltips for hovering keywords in Vim
if exists('+ballooneval')
  " This doesn't seem to stop tooltips for Ruby files
  set noballooneval
  " 100 second delay seems to be the only way to disable the tooltips
  set balloondelay=100000
endif

" ---------------
" Behaviors
" ---------------
syntax enable
set nobackup           "  Disable file backup
set nowritebackup
set noswapfile         " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set autoread           " Automatically reload changes if detected
set wildmenu           " Turn on WiLd menu
" longest common part, then all.
set wildmode=longest,full
set hidden             " Change buffer - without saving
set history=768        " Number of things to remember in history.
set confirm            " Enable error files & error jumping.
set clipboard+=unnamed " Yanks go on clipboard instead.
set autowrite          " Writes on make/shell commands
set timeoutlen=400     " Time to wait for a command (after leader for example).
set ttimeout
set ttimeoutlen=100    " Time to wait for a key sequence.
set nofoldenable       " Disable folding entirely.
set foldlevelstart=99  " I really don't like folds.
set formatoptions=crql
set iskeyword+=\$,-    " Add extra characters that are valid parts of variables
set nostartofline      " Don't go to the start of the line after some commands
set scrolloff=3        " Keep three lines below the last line when scrolling
set gdefault           " this makes search/replace global by default
set switchbuf=useopen  " Switch to an existing buffer if one exists
set showcmd            " display incomplete commands
set autochdir          " Automatically change window's cwd to file's dir
" Uncomment the following to have Vim jump to the last position when reopening a
" file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
end
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set diffopt+=vertical " Always use vertical diffs
autocmd! bufwritepost $MYVIMRC source $MYVIMRC


" ---------------
" Text Format
" ---------------
set tabstop=2
set backspace=indent,eol,start " Delete everything with backspace
set shiftwidth=2 " Tabs under smart indent
set shiftround
set cindent
set autoindent
set smarttab
set expandtab

" ---------------
" Searching
" ---------------
set ignorecase " Case insensitive search
set smartcase  " Non-case sensitive search
set incsearch  " Incremental search
set hlsearch   " Highlight search results
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc,*/node_modules/*,
  \rake-pipeline-*

" ---------------
" Visual
" ---------------
set showmatch   " Show matching brackets.
set matchtime=2 " How many tenths of a second to blink
" Show invisible characters
set list

" Show trailing spaces as dots and carrots for extended lines.
" From Janus, http://git.io/PLbAlw

" Reset the listchars
set listchars=""
" make tabs visible
set listchars=tab:▸▸
" show trailing spaces as dots
set listchars+=trail:•
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:<

" ---------------
" Sounds
" ---------------
set noerrorbells
set novisualbell
set t_vb=

" ---------------
" Mouse
" ---------------
set mousehide  " Hide mouse after chars typed
set mouse=a    " Mouse in all modes

" Better complete options to speed it up
set complete=.,w,b,u,U

" ---------------
" Keyboard
" ---------------
let mapleader=" "
"
" Can be typed even faster than jj, and if you are already in normal mode, you (usually) don't accidentally move:
:imap jk <Esc>
:imap kj <Esc>
:imap ;; <Esc>
inoremap ;; <Esc>
map q <Nop> " Disable recording
"
" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Insert/append single char in 'normal' mode
" :nnoremap s :exec "normal i".nr2char(getchar())."\e"<cr> " s insert
" :nnoremap S :exec "normal a".nr2char(getchar())."\e"<cr> " S append

" vnoremap < <gv " Shift+> keys " Easier moving of code blocks
" vnoremap > >gv " Shift+< keys " Easier moving of code blocks

"Toggle [i]nvisible characters
nnoremap <leader>i :set list!<cr>

" Open a quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

" Activate autocomplete at <Ctrl+Space>
inoremap <c-space> <c-x><c-o>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
nnoremap Y y$

" Close buffer
noremap <leader>c :bd<cr>
map <c-q> :bd<cr>

" Allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >g

" Keep the cursor in place while joining lines
nnoremap J mzJ`

" Down N screen lines (differs from "j" when line wraps)
nnoremap j g

" Adjust viewports to the same size
map <leader>= <C-w>=

" Easier change size for splitted windows
nnoremap {{ :vertical resize +5<cr>
nnoremap }} :vertical resize -5<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Keep search matches when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Quick insertion of newline in normal mode
nnoremap <silent> <cr> :put=''<cr>

" Select entire buffer
nnoremap vaa ggvGg_

" Go to the position of the last change in this file"
nnoremap gI `

" Abbreviations
" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqa

" Switch between the last two files
nnoremap <leader><leader> <C-^>

" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" Get off my lawn
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>


augroup fast_quit
  au!
  au FileType help nnoremap <buffer> q :q<cr>
  au FileType qf nnoremap <buffer> q :q<cr>
  au FileType netrw nnoremap <buffer><nowait> q :bd!<cr>
  au FileType man nnoremap <buffer> q :q<cr>
  au CmdwinEnter * nnoremap <buffer> q :q<cr>
  au BufReadPost fugitive://* nnoremap <buffer> q :q<cr>
augroup END




" --------------- 
" neomake
" ---------------
" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)
