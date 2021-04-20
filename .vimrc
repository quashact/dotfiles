"{{{ Automatic installation for vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

"{{{ Automatic installation of missing vim-plug plugins
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
"}}}

"{{{ List plugins for vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'badacadabra/vim-archery'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
call plug#end()
"}}}

"{{{ Basic Default VIM Configuration
set number         " Show line numbers
set noshowmode     " Hide mode indicator(because this is implemented by vim-airline)
set tabstop=4      " Appear tab character as 4 spaces wide
set shiftwidth=4   " Correspond an Indent as a single tab
set expandtab      " Make the tab key insert spaces instead of tab character.
set hlsearch       " Highlight searched keyword permanently.
set encoding=UTF-8 " Set encoding as UTF-8
colorscheme archery
"}}}

"{{{ Personal setting for vim-gitgutter 
set updatetime=150
set background=dark
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow
"}}}

"{{{ Personal setting for vim-alirline
let g:airline_theme='cool'
let g:airline#extensions#tabline#enabled = 1 "Always show smarter tab line
let g:airline_powerline_fonts = 1            "Nice looking symbols in status bar
"}}}

"{{{ Visual setting for Coc.nvim and vim itself
" These two lines below are required to display undercurl.
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
highlight CocErrorHighlight cterm=undercurl,bold ctermfg=DarkRed
"}}}

"{{{ Remap <C-f> and <C-b> for scroll float windows/popups for Coc.nvim
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
"}}}

"{{{ Remap [c and ]c for jumping to previous/next diagnostics for Coc.nvim
try
    nmap <silent> [c :call CocAction('diagnosticPrevious')<cr>
    nmap <silent> ]c :call CocAction('diagnosticNext')<cr>
endtry
"}}}

" Use <c-space> to trigger completion for Coc.nvim
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Select the first completion item and confirm the completion when no item has
" been selected for Coc.nvim
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
