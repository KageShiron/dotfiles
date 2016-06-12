set nocompatible

function! s:LetAndMkdir(variable, path) "{{{
  try
    if !isdirectory(a:path)
      call mkdir(a:path, 'p')
    endif
  catch
    echohl WarningMsg
    echom '[error]' . a:path . 'is exist and is not directory, but is file or something.'
    echohl None
  endtry

  execute printf("let %s = a:path", a:variable)
endfunction "}}}

let $DOTVIM=expand('~/.vim')

"##### Path #####
call s:LetAndMkdir('&backupdir',$DOTVIM.'/backup')
set swapfile
call s:LetAndMkdir('&directory',$DOTVIM.'/swap')
call s:LetAndMkdir('&undodir'  ,$DOTVIM.'/undo')
set viminfo+=n$DOTVIM/.viminfo

set autoindent
set backspace=indent,eol,start
set wrapscan
set showmatch
set formatoptions+=mM
set nonumber
set ruler
set wrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set tabstop=4       "Tabの幅を設定
set shiftwidth=4    "自動インデント
set expandtab       "タブではなくスペースでインデント
set encoding=utf-8  "UTF8
set textwidth=0     "自動折り返しをしない
set list            "空白文字を表示
set listchars=eol:',tab:>\ 
set wildmenu wildmode=longest,list,full "補完をShell互換に
set history=2000
set showbreak=+++
set incsearch       "インクリメントサーチ
set ignorecase      "大小文字
set smartcase       "検索を賢く
set display=lastline "入りきらなくても@にしない

colorscheme desert

"##### キー無効化 #####
"保存全終了
nnoremap ZZ <Nop>
"未保存全終了
nnoremap ZQ <Nop>

let mapleader=" "
inoremap <C-CR> <br><CR>

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = $DOTVIM  "empty($XDG_CACHE_HOME) ? $TEMP : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = $DOTVIM."/dein.toml"
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
"}}}

""##### neobundle ##### {{z{
""##################################################
"if has('vim_starting')
"set nocompatible               " Be iMproved
"
"" Required:
"set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
"endif
"
"" Required:
"call neobundle#begin(expand('~/.vim/bundle/'))
"
"" Let NeoBundle manage NeoBundle
"" Required:
"NeoBundleFetch 'Shougo/neobundle.vim'
"
"" My Bundles here:
""
"NeoBundle 'Shougo/neocomplete.vim'
"NeoBundle 'Shougo/neosnippet.vim'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'
"NeoBundle 'itchyny/lightline.vim'       "ステータスバーをかっこよく
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimshell.vim'
"NeoBundle 'easymotion/vim-easymotion'
"NeoBundle 'Shougo/neomru.vim'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'Shougo/vinarise'
"NeoBundle 'mattn/emmet-vim'
"NeoBundle 'fuenor/im_control.vim'
"NeoBundle 'tpope/vim-surround'
"NeoBundle 'LeafCage/yankround.vim'
"NeoBundle 'Shougo/neoyank.vim'
"
"" You can specify revision/branch/tag.
"NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
"
"call neobundle#end()
"
"" Required:
"filetype plugin indent on
"
"" If there are uninstalled bundles found on startup,
"" this will conveniently prompt you to install them.
"NeoBundleCheck
""}}}

"##### lightline #####{{{
"################################################
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"[RO]":""}',
      \  'jpmode' : '%{IMStatus("[日]")}',
      \ },
      \ 'active' : {
      \ 'left' : [['mode','paste','jpmode'],['readonly','filename','modified']]
      \},
      \ 'subseparator' : {'left' : '>' , 'right' : '<'}
      \}

" End of lightline}}}

"##### 全角スペース ##### {{{
"##################################################
"https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color#color-zenkaku
"デフォルトのZenkakuSpaceを定義
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guibg=#663333
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif

" End of 全角スペース }}}

"##### neocomplete ##### {{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"##### End Of neocomplete }}}

"##### unite.vim ##### {{{

let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,uh :<C-u>Unite file_mru<CR>
"End Of unite.vim }}}

"##### vim-easymotion ##### {{{
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_leader_key = '<Space><Space>'
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap S <Plug>(easymotion-overwin-f2)
nmap s <Plug>(easymotion-overwin-f)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)"End of vim-easymotion}}}

"##### im_control.vim #####{{{


"}}}}
" vim: foldmethod=marker
"
filetype plugin indent on
