set modeline
" Doxygen comments
autocmd Filetype c,cpp set comments^=:///

"Remember buffer history on buffer change
set hidden
"Swap '` as ` is more useful in mark-locating
nnoremap ' `
nnoremap ` '
"Default leader is \ which is inconvenient
let mapleader = ","
"Increase the command/search history
"set history=100000

" XXXX
runtime plugin/matchit.vim

"Shell-like command completion
set wildmode=list:longest
"Smart (usually case-insensitive) searching
set ignorecase
set smartcase
"When scrolling, include context
set scrolloff=5
"Single-step scroll faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
"Store swap files centrally in ~/.vimtmp
set directory=~/.vim/tmp
"Highlight and incremental search
set hlsearch
set incsearch
nmap <silent><leader>n :silent :nohlsearch<CR>
"Highlight trailing whitespace with ,s
"set listchars=tab:>-,trail:·,eol:$
nmap <silent><leader>s :set nolist!<CR>
"Shorten some messages
set shortmess=atI
"Reindent entire file
nmap <F10> 1G=G
imap <F10> <ESC>1G=Ga


set spell
set spelllang=en

set tabpagemax=40
syntax enable
set foldenable
set fdm=syntax
nnoremap <space> za
set wrap textwidth=72 ts=4 sw=4 et ai si nocp
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
set nocindent
let g:tex_flavor='latex'
let g:Tex_SmartKeyQuote=0
set runtimepath+=/usr/share/vim/addons

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 16
    endif
endif
set nu
set t_Co=256
let s:solarized_termtrans = 1
let g:solarized_termcolors = 256
colorscheme solarized

highlight SpellBad cterm=underline ctermfg=White ctermbg=NONE


highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/
" Show tabs that are not at the start of a line:
match ExtraWhitespace /[^\t]\zs\t\+/
" Show spaces used for indenting (so you use only tabs for indenting).
" match ExtraWhitespace /^\t*\zs \+/
" Switch off :match highlighting.
" match

"setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)
"function! DiffFold(lnum)
"  let line = getline(a:lnum)
"  if line =~ '^\(diff\|---\|+++\|@@\) '
"    return 1
"  elseif line[0] =~ '[-+ ]'
"    return 2
"  else
"    return 0
"  endif
"endfunction
"
"
"
augroup ProjectSetup
    au BufRead,BufEnter /export/home/jeffga/git/genome_nova/*/*.{cc,h} set makeprg=./project_scripts/build
augroup END


if has('python')
    map <C-I> :pyf /usr/share/clang/clang-format.py<cr>
    imap <C-I> <c-o>:pyf /usr/share/clang/clang-format.py<cr>
elseif has('python3')
    map <C-I> :py3f /usr/share/clang/clang-format.py<cr>
    imap <C-I> <c-o>:py3f /usr/share/clang/clang-format.py<cr>
endif
"autocmd BufWritePre *.h,*.cc,*.cpp,*.C call Formatonsave()
