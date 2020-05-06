" Tips {{{
  " Create the `tags` file
  "   command! MakeTags !ctags -R .
" }}}

" Plugins {{{
  " Plugins will be downloaded under the specified directory.
  call plug#begin('~/.local/share/nvim/plugged')
  " Declare the list of plugins.
  Plug 'evidanary/grepg.vim'
  Plug 'neomake/neomake'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  " Plug 'edkolev/tmuxline.vim'
  Plug 'kien/ctrlp.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'easymotion/vim-easymotion'
  Plug 'itchyny/lightline.vim'
  Plug 'haishanh/night-owl.vim'
  Plug 'lifepillar/vim-solarized8'
  Plug 'romainl/flattened'
  Plug 'rakr/vim-one'
  " List ends here. Plugins become visible to Vim after this call.
  call plug#end()
" }}}

" Filetype plugin {{{
  filetype plugin on
  " Tweaks for browsing
  " disable annoying banner
  let g:netrw_banner=0
  " open in prior window
  let g:netrw_browse_split=4
  " open splits to the right
  let g:netrw_altv=1
  " tree view
  let g:netrw_liststyle=3
  let g:netrw_list_hide=netrw_gitignore#Hide()
  let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" }}}

" UI {{{
  " Force 256 color mode if available
  if !has('gui_running')
    set t_Co=256
  endif
  " True color in the terminal
  set termguicolors

  hi Cursor guifg=green guibg=green
  hi Cursor2 guifg=red guibg=red
  set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

  " Ruler on
  set ruler

  " Line numbers on
  set number

  " turn hybrid line numbers on
  " set number relativenumber
  set nu rnu

  " Line wrapping off
  set nowrap

  " Always show the statusline
  set laststatus=2

  " Make the command area two lines high
  set cmdheight=1

  " Highlight current line
  set cursorline
  set encoding=utf-8

  set background=dark
  " colorscheme one
  " colorscheme onehalflight
  colorscheme night-owl

  "set showmode
  " Don't show the mode since Powerline shows it
  set noshowmode

  " Set the title of the window in the terminal to the file
  set title
  if exists('+colorcolumn')
    highlight ColorColumn ctermbg=7
    " Color the 120th column differently as a wrapping guide.
    set colorcolumn=120
  endif

  " disable tooltips for hovering keywords in Vim
  if exists('+ballooneval')
    " This doesn't seem to stop tooltips for Ruby files
    set noballooneval
    " 100 second delay seems to be the only way to disable the tooltips
    set balloondelay=100000
  endif
  " }}}

  " Behaviors {{{
    syntax enable

    "  Disable file backup
    set nobackup
    set nowritebackup

    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
    set noswapfile

    " Automatially reload changes if detected
    set autoread

    " Turn on WiLd menu
    set wildmenu

    " longest common part, then all.
    set wildmode=longest,full

    " Change buffer - without saving
    set hidden

    " Undo
    if exists("&undofile")
        set undofile
    endif

    " Number of things to remember in history.
    set history=768

    " Enable error files & error jumping.
    set confirm

    " Yanks go on clipboard instead.
    set clipboard+=unnamed

    " Writes on make/shell commands
    set autowrite

    " Time to wait for a command (after leader for example).
    set timeoutlen=400
    set ttimeout

    " Time to wait for a key sequence.
    set ttimeoutlen=200

    " Code folding settings
    set foldmethod=syntax " fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 " deepest fold is 10 levels
    set nofoldenable " don't fold by default
    set foldlevel=1

    set formatoptions=crql

    " Add extra characters that are valid parts of variables
    set iskeyword+=\$,-

    " Don't go to the start of the line after some commands
    set nostartofline

    " Keep three lines below the last line when scrolling
    set scrolloff=3

    " this makes search/replace global by default
    set gdefault

    " Switch to an existing buffer if one exists
    set switchbuf=useopen

    " display incomplete commands
    set showcmd

    " Automatically change window's cwd to file's dir
    set autochdir

    " Uncomment the following to have Vim jump to the last position when reopening a
    " file
    if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
    end

    " Open new split panes to right and bottom, which feels more natural
    set splitbelow
    set splitright

    " Always use vertical diffs
    set diffopt+=vertical

    autocmd! bufwritepost $MYVIMRC source $MYVIMRC

    " Search down into subfolders
    " Provides tab-completion for all file-related tasks
    set path+=**

" }}}

" Text Format {{{
  " Tab control
  " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
  set smarttab
  " the visible width of tabs
  set tabstop=2
  " edit as if the tabs are 4 characters wide
  set softtabstop=2
  " number of spaces to use for indent and unindent
  set shiftwidth=2
  " round indent to a multiple of 'shiftwidth'
  set shiftround

  " Delete everything with backspace
  set backspace=indent,eol,start

  " Tabs under smart indent
  set shiftwidth=2
  set shiftround
  set cindent
  set autoindent
  set smarttab
  set expandtab
" }}}

" Searching {{{
  " Case insensitive search
  set ignorecase

  " Non-case sensitive search
  set smartcase

  " Incremental search
  set incsearch

  " Highlight search results
  set hlsearch
  set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
    \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc,*/node_modules/*,
    \rake-pipeline-*
" }}}

" Visual {{{
  " Show matching brackets.
  set showmatch

  " How many tenths of a second to blink
  set matchtime=2

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
" }}}

" Sounds {{{
" ---------------
  set noerrorbells
  set novisualbell
  set t_vb=
" }}}

" Mouse {{{
  " Hide mouse after chars typed
  set mousehide

  " Mouse in all modes
  set mouse=a

  " Better complete options to speed it up
  set complete=.,w,b,u,U
" }}}

" Keyboard {{{
  let mapleader=" "
  "
  " Can be typed even faster than jj, and if you are already in normal mode, you (usually) don't accidentally move:
  if !exists('g:vscode')
      " ordinary neovim
      " :imap jk <Esc>
      " :imap kj <Esc>
      :imap ;; <Esc>
      :inoremap ;; <Esc>
  endif

  " Easy saving
  " inoremap <C-u> <Esc>:w<Cr>

  " Disable recording
  map q <Nop>

  " Select the stuff I just pasted
  nnoremap gV `[V`]

  " Sudo to write
  cnoremap w!! w !sudo tee % >/dev/null

  " Insert/append single char in 'normal' mode
  " s insert
  nnoremap <silent> s :exe "normal i".nr2char(getchar())<Cr>
  " S append
  nnoremap <silent> S :exe "normal a".nr2char(getchar())<Cr>

  " Easier moving of code blocks Shift+< keys
  vnoremap < <gv

  " Easier moving of code blocks Shift+> keys
  vnoremap > >gv

  " These create newlines like o and O but stay in normal mode
  nmap zj o<Esc>k
  nmap zk O<Esc>j

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
  " nnoremap J mzJ`

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

  " Go to the position of the last change in this file
  nnoremap gI `.

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
" }}}

" neomake {{{
  " When writing a buffer (no delay).
  call neomake#configure#automake('w')
  " When writing a buffer (no delay), and on normal mode changes (after 750ms).
  call neomake#configure#automake('nw', 750)
  " When reading a buffer (after 1s), and when writing (no delay).
  call neomake#configure#automake('rw', 1000)
  " Full config: when writing or reading a buffer, and on changes in insert and
  " normal mode (after 1s; no delay when writing).
  call neomake#configure#automake('nrwi', 500)
" }}}

" Ctrl-P {{{
  let g:ctrlp_show_hidden = 0
  let g:ctrlp_map = '<C-p>'
  let g:ctrlp_cmd = 'CtrlPMRU'
  let g:ctrlp_working_path_mode = 'ra'
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_user_command = 'find %s -type f'
" }}}

" Tmuxline {{{
  let g:tmuxline_powerline_separators = 1
" }}}

" LightLine {{{
  let g:lightline = {
      \ 'colorscheme': 'onehalfdark',
      \ 'component': {
      \ 'lineinfo': ' %3l:%-2v',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

  function! LightlineModified()
    return &ft ==# 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
  endfunction

  function! LightlineFilename()
    let fname = expand('%:t')
    return fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
          \ fname =~# '^__Tagbar__\|__Gundo\|NERD_tree' ? '' :
          \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft ==# 'unite' ? unite#get_status_string() :
          \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
          \ (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
          \ (fname !=# '' ? fname : '[No Name]') .
          \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
  endfunction

  function! LightlineFugitive()
    try
      if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
        let mark = ''  " edit here for cool mark
        let branch = FugitiveHead()
        return branch !=# '' ? mark.branch : ''
      endif
    catch
    endtry
    return ''
  endfunction

  function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
  endfunction

  function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
  endfunction

  function! LightlineMode()
    let fname = expand('%:t')
    return fname =~# '^__Tagbar__' ? 'Tagbar' :
          \ fname ==# 'ControlP' ? 'CtrlP' :
          \ fname ==# '__Gundo__' ? 'Gundo' :
          \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
          \ fname =~# 'NERD_tree' ? 'NERDTree' :
          \ &ft ==# 'unite' ? 'Unite' :
          \ &ft ==# 'vimfiler' ? 'VimFiler' :
          \ &ft ==# 'vimshell' ? 'VimShell' :
          \ winwidth(0) > 60 ? lightline#mode() : ''
  endfunction

  function! CtrlPMark()
    if expand('%:t') ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item')
      call lightline#link('iR'[g:lightline.ctrlp_regex])
      return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
            \ , g:lightline.ctrlp_next], 0)
    else
      return ''
    endif
  endfunction

  let g:ctrlp_status_func = {
    \ 'main': 'CtrlPStatusFunc_1',
    \ 'prog': 'CtrlPStatusFunc_2',
    \ }

  function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
  endfunction

  function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
  endfunction

  let g:tagbar_status_func = 'TagbarStatusFunc'

  function! TagbarStatusFunc(current, sort, fname, ...) abort
    return lightline#statusline(0)
  endfunction

  " Syntastic can call a post-check hook, let's update lightline there
  " For more information: :help syntastic-loclist-callback
  function! SyntasticCheckHook(errors)
    call lightline#update()
  endfunction
" }}}

" Misc {{{
  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimshell_force_overwrite_statusline = 0
" }}}

" Trim Whitespaces {{{
  fun! TrimWhitespace()
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
  endfun
  command! TrimWhitespace call TrimWhitespace()
" }}}
