" modernize vim
set nocompatible
" ensure utf-8 encoding
set encoding=utf-8

let mapleader="\\"
let maplocalleader=","

"" Plugins

call plug#begin()

" project/file/SCM support
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'

" text editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" language support
Plug 'sheerun/vim-polyglot'
Plug 'm104/vim-checklist'
Plug 'sirtaj/vim-openscad'

" Python integration
Plug 'psf/black'

" Upcase conjure log (,l*) mappings to (,L*)
let g:conjure#mapping#log_split = "Ls"
let g:conjure#mapping#log_vsplit = "Lv"
let g:conjure#mapping#log_tab = "Lt"
let g:conjure#mapping#log_buf = "Le"
let g:conjure#mapping#log_toggle = "Lg"
let g:conjure#mapping#log_close_visible = "Lq"
let g:conjure#mapping#log_reset_soft = "Lr"
let g:conjure#mapping#log_reset_hard = "LR"
let g:conjure#mapping#log_jump_to_latest = "Ll"

" Clojure/lisp integration
Plug 'Olical/conjure'
Plug 'Shougo/deoplete.nvim'
Plug 'ncm2/float-preview.nvim'
Plug 'w0rp/ale'

" color schemes
Plug 'nanotech/jellybeans.vim' , {'as': 'jellybeans'}
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'jacoborus/tender.vim', {'as': 'tender'}

call plug#end()


"" Plugin Settings

" ignore some file types
let NERDTreeIgnore = ['\.pyc$', '^target$']

" float preview updates
let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

" deoplete settings
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
set completeopt-=preview

" Ale settings
let g:ale_linters = {
      \ 'clojure': ['clj-kondo']
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'clojure': ['cljfmt'],
      \}


"" General Settings

" enable filetype detection
filetype plugin indent on
" allow hidden buffers
set hidden

" determine the full nvim config path
let s:configdir = expand('<sfile>:p:h')

" lines of command-line (etc) history
set history=1000
" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me
set viminfo=/10,'10,r/Volumes,f0,h,\"100

" rebuild spelling file(s)
for textfile in glob(s:configdir . '/spell/*.add', 1, 1)
  let s:spellfile = textfile . '.spl'
  if filereadable(textfile) && (!filereadable(s:spellfile) || getftime(textfile) > getftime(s:spellfile))
    echomsg 'Rebuilding spelling file: ' . s:spellfile
    exec 'silent mkspell! ' . fnameescape(textfile)
  endif
endfor


"" User Interface

" dark background, by default
set background=dark
" mouse selection
set selectmode=mouse
" no beeping, please...
set vb
" always show status line
set laststatus=2
" display the current mode and partially-typed commands in the status line
set showmode
set showcmd
" default or informative status line
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline=%<%f\ %h%w%m%r%y%{exists('g:loaded_fugitive')?fugitive#statusline():''}%=%b\ 0x%B%=%-16(\ %l,%c%V\ %)%P
" use '[RO]' for '[readonly]' to save space in the message line
set shortmess+=r
" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities
set wildmode=list:longest,full
" ignore some files
set wildignore=*/target/*


"" Text Editing Display

" have syntax highlighting in terminals which can display colours:
syntax on
" faster or more accurate syntax highlighting
syn sync ccomment cComment minlines=30 maxlines=300
"syn sync fromstart
" use the OS clipboard
set clipboard=unnamedplus
" don't wrap long lines
set nowrap
" cursor position
set ruler
" if we do wrap lines, show them explicitly
set showbreak=`
" make searches case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase
" show the `best match so far' as search strings are typed
set incsearch
" highlight search strings
set hlsearch
" show matches
set showmatch
" show 'invisible' characters
set listchars=tab:>.,trail:-
set list
" show at least 1 line above/below the cursor
set scrolloff=1
" and at least 5 characters on either side
set sidescrolloff=5
" show last line of the file
set display+=lastline
" show line numbers
set number
" autoload file changes ('u' to cancel)
set autoread
" update files every 750ms
set updatetime=750


"" Text Formatting

" indents with 2 spaces and smart indenting
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set shiftround
set expandtab
set autoindent
" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 80 characters
set formatoptions=crq
set textwidth=80
" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode
set whichwrap+=h,l,~,[,]
" turn on programmaticly syntactical folds
set foldmethod=indent
" set the fold level high enough to not fold the whole program
set foldlevel=20
" backspace through lines, indentations
set backspace=indent,eol,start
" don't consider octal when inc/dec-ing numbers
set nrformats-=octal


"" Key Mappings
" fast Esc
inoremap <C-J> <Esc>

" show all buffers
nnoremap <silent> <Leader>b :buffers<CR>
" cycle through buffers/files
nnoremap <silent> <C-N> :bn<CR>
nnoremap <silent> <C-B> :bp<CR>

" toggle spell checking
nnoremap <silent> <Leader>s :set invspell<CR>

" search for points of interest
nnoremap <silent> <Leader>hi /\<\(TODO\\|FIXME\\|BUG\\|DEBUG\\|XXX\\|HACK\\|NOTE\)\><CR>
" search for git merge conflicts
nnoremap <silent> <Leader>hm /^[<=>]\{7\}<CR>

" file tree toggling
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>

" ALE formatting
nnoremap <silent> <LocalLeader>f :ALEFix<CR>

" show syntax highligh group under cursor
map <F10> :echo "0:" . synIDattr(synID(line("."),col("."),1),"name") . ', 1:'
  \ . synIDattr(synID(line("."),col("."),0),"name") . ", 2:"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ""<CR>


"" Automatic commands

" check for updates after the cursor has been inactive
autocmd CursorHold,FocusGained * silent! checktime

" clear CtrlP caches on startup
autocmd VimEnter * :CtrlPClearCache


"" Host Settings

let s:hostfile=s:configdir . '/local/' . hostname() . '.vim'
let s:localfile=s:configdir . '/local/local.vim'
if filereadable(s:hostfile)
  execute 'source '. s:hostfile
elseif filereadable(s:localfile)
  execute 'source '. s:localfile
else
  echomsg 'No host config file found: ' . s:hostfile
endif

