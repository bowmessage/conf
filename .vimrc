if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'kien/ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/vendor/*
"let g:ctrlp_map = 'π'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_depth=40
let g:ctrlp_working_path_mode = 2

NeoBundle 'vim-ruby/vim-ruby'
autocmd FileType ruby compiler ruby
autocmd FileType ruby let g:rubycomplete_rails = 1
autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby let g:rubycomplete_classes_in_global = 1

NeoBundle 'astashov/vim-ruby-debugger'
let g:ruby_debugger_no_maps = 1
map <Leader>b  :call g:RubyDebugger.toggle_breakpoint()<CR>
map <Leader>v  :call g:RubyDebugger.open_variables()<CR>
map <Leader>m  :call g:RubyDebugger.open_breakpoints()<CR>
map <Leader>t  :call g:RubyDebugger.open_frames()<CR>
map <Leader>s  :call g:RubyDebugger.step()<CR>
map <Leader>f  :call g:RubyDebugger.finish()<CR>
map <Leader>x  :call g:RubyDebugger.next()<CR>
map <Leader>c  :call g:RubyDebugger.continue()<CR>
map <Leader>e  :call g:RubyDebugger.exit()<CR>
map <Leader>d  :call g:RubyDebugger.remove_breakpoints()<CR>

NeoBundle 'klen/python-mode', 'develop'
let g:pymode_options_max_line_length = 132
map <leader>f :PymodeLintAuto<CR>
set foldlevelstart=10

NeoBundle 'pangloss/vim-javascript'
NeoBundle 'maksimr/vim-jsbeautify'
map <leader>F :call JsBeautify()<CR>

NeoBundle 'Chiel92/vim-autoformat'
noremap <F3> :Autoformat<CR>

NeoBundle 'editorconfig/editorconfig-vim'

NeoBundle 'Valloric/YouCompleteMe'
let g:EclimCompletionMethod = 'omnifunc'
"map <leader>c :JavaCorrect<CR>
"map <leader>f :JavaFormat<CR>
map <leader>i :JavaImportOrganize<CR>

NeoBundle 'dhruvasagar/vim-railscasts-theme'

NeoBundle 'tpope/vim-fugitive'
map <Leader>B :Gblame<CR>

NeoBundle 'scrooloose/nerdtree'
autocmd VimEnter * NERDTree "FromBookmark SimpleGame
autocmd VimEnter * wincmd p
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git','\.hg','\.svn','\.bzr']
let NERDTreeKeepTreeInNewTab=1

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

"powerline
NeoBundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

call neobundle#end()

" Required:
filetype on
filetype indent on
filetype plugin on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

 
set relativenumber
syntax on
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

"Window management
function! WinMove(key) 
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we havent moved
    if (match(a:key,'[jk]')) "were we going up/down
      wincmd v
    else 
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

"autocmd BufWritePre *.java :%s/\s\+$//e

set backup
set writebackup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set ignorecase
set smartcase
set incsearch

set encoding=utf-8
 
map <leader>h              :call WinMove('h')<cr>
map <leader>k              :call WinMove('k')<cr>
map <leader>l              :call WinMove('l')<cr>
map <leader>j              :call WinMove('j')<cr>

map <leader>wc :wincmd q<cr>
map <leader>wr <C-W>r

map <leader>H              :wincmd H<cr>
map <leader>K              :wincmd K<cr>
map <leader>L              :wincmd L<cr>
map <leader>J              :wincmd J<cr>

map <leader>I              :set invnumber<cr>

inoremap kj <esc>
inoremap jk <esc>

nnoremap j gj
nnoremap k gk

"*E*dit my *V*imrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

colorscheme railscasts
set clipboard=unnamed

"use old regex engine to prevent lag in ruby files
set re=1
set ttyfast
set lazyredraw
set cursorline
