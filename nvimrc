if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if has('pbcopy')
  let g:python3_host_prog  = '/usr/local/Cellar/python/3.7.0/bin/python3'
else
  let g:python3_host_prog  = '/usr/local/bin/python3'
endif

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/deol.nvim')

  call dein#add('airblade/vim-gitgutter')
  call dein#add('luochen1990/rainbow')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-airline/vim-airline')
  call dein#add('junegunn/fzf.vim')
  call dein#add('slashmili/alchemist.vim')
  call dein#add('elixir-editors/vim-elixir')
  call dein#add('mbbill/undotree')
  call dein#add('neomake/neomake')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('kien/ctrlp.vim')
  call dein#add('davidhalter/jedi-vim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
let $PATH=substitute($PATH, "/usr/local[^:]\\+:", "", "g")

colorscheme srcery
let mapleader =" "
"set synmaxcol=120
let g:deoplete#enable_at_startup = 1

syntax on
set number
set hlsearch
set expandtab
set tabstop=2
set shiftwidth=2
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set backspace=indent,eol,start
set rtp+=/usr/local/opt/fzf

" vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" vim buffers
map <C-H> <C-^>

" elixir config
autocmd CompleteDone * pclose " To close preview window of deoplete automagically
tnoremap <ESC>   <C-\><C-n>

"set backupdir=~/.vim/backups
set directory=~/.vim/backups
autocmd BufWritePre * StripWhitespace

" neomake
augroup localneomake
  autocmd BufWritePost * Neomake
augroup END
" Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
let g:neomake_elixir_enabled_makers = ['mycredo', 'mix']
function! NeomakeCredoErrorType(entry)
  if a:entry.type ==# 'F'      " Refactoring opportunities
    let l:type = 'W'
  elseif a:entry.type ==# 'D'  " Software design suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'W'  " Warnings
    let l:type = 'W'
  elseif a:entry.type ==# 'R'  " Readability suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'C'  " Convention violation
    let l:type = 'W'
  else
    let l:type = 'M'           " Everything else is a message
  endif
  let a:entry.type = l:type
endfunction

let g:neomake_elixir_mycredo_maker = {
      \ 'exe': 'mix',
      \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
      \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
      \ 'postprocess': function('NeomakeCredoErrorType')
      \ }
let g:neomake_open_list = 2

" FZF
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" python jedi
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader><leader>du"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" key mappings
nnoremap <leader>d dd
nnoremap <leader>r :%s/\<<C-r><C-w>\>/
nnoremap K i<CR><Esc>
vnoremap <leader><leader>c :%y *<cr>
inoremap \fn <C-R>=expand("%:t")<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
vnoremap <leader>cp :cprevious<cr>
vnoremap <leader>cn :cnext<cr>


nmap <leader>f /\<<C-r><C-w>\>
nmap <leader>% :so $MYVIMRC<cr>
"nmap <leader>t :call system("tmux send -t 0 gulp SPACE test-dot ENTER") <Enter>
nmap <leader><leader>u :UndotreeToggle<cr>
nmap <leader>l :tabn <cr>
nmap <leader>h :tabp <cr>
nmap <leader><leader>n :set nonumber <cr>
nmap <leader>n :set number <cr>
nmap <leader><leader>i :call dein#install()<cr>

map <C-b> :Gblame<CR>
map <C-n> :NERDTreeToggle<CR>
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
map <leader>o <C-w>gf
map <leader><leader>o <C-w>gF
map <leader>s :w<CR>
map <leader><leader>s :Deol -split<CR>
map <leader>d :GoDef<CR>
map <leader>dp :GoDefPop<CR>
map <leader>ds :GoDefStack<CR>
map <leader>fd :GoDecls<CR>
map <leader>fdd :GoDeclsDir<CR>
map <leader>gr :GoRename<CR>
map <leader><leader>r :GoRun<CR>
map <leader>gi :GoImpl<CR>
map <leader>gp :GoPlay<CR>
map <leader>gl :GoMetaLinter<CR>
au Filetype go nmap <leader>b :GoBuild<CR>
au Filetype go nmap <leader>ru :GoRun<CR>
au Filetype go nmap <leader>t :GoTest<CR>
au Filetype go nmap <leader>at :GoTest ./...<CR>
map <leader>ln :lnext<CR>
map <leader>lp :lprev<CR>

" undo handling
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000
set shell=/bin/zsh\ -l

" gitgutter
let g:gitgutter_eager=0

""""" Go Bindings """""
"au Filetype go nmap <leader>l :GoLint<CR>
au Filetype go nmap <leader>db :DlvToggleBreakpoint<CR>
au Filetype go nmap <leader>dt :DlvToggleTracepoint<CR>
au Filetype go nmap <leader>dca :DlvClearAll<CR>
au Filetype go map <leader>dd :DlvDebug<CR>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = "goimports"
let g:go_term_enabled = 1
"let g:go_list_type = "quickfix"
let g:golang_goroot = "/usr/local/go"

set statusline+=%#warningmsg#
set statusline+=%*

set ttimeout
set ttimeoutlen=0
set matchtime=0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_go_checkers = ["gofmt", "govet", "golint"]
let g:syntastic_style_error_symbol=">>"
let g:syntastic_style_warning_symbol=">>"
let g:go_bin_path = expand("/usr/local/go/bin/go")
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

"haskell
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" vim airline configuration
set laststatus=2
"let g:airline_theme='murmur'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts = 1
let g:airline_section_x = airline#section#create_left(['filetype'])
let g:airline_section_y = ""
"function! AirlineInit()
  "let g:airline_section_a = airline#sections#create(['mode',' ','branch'])
"endfunction
"autocmd VimEnter * call AirlineInit()

" rainbow parens config
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'ctermfgs': ['blue', 'red', 'green', 'magenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}
