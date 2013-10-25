" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc) - Vim7用試作
"
" Last Change: 25-Oct-2013.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
" かれています。GUIに関する設定はgvimrcに書かかれています。
"
" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
" イルの読込を中止する。
if 1 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

" plugins下のディレクトリをruntimepathへ追加する。
for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
source $VIM/plugins/kaoriya/encode_japan.vim
" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif
" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  set langmenu=japanese
endif
" 日本語入力用のkeymapの設定例 (コメントアウト)
if has('keymap')
  " ローマ字仮名のkeymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif
" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

"---------------------------------------------------------------------------
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  if &guioptions !~# "M"
    " vimrc_example.vimを読み込む時はguioptionsにMフラグをつけて、syntax on
    " やfiletype plugin onが引き起こすmenu.vimの読み込みを避ける。こうしない
    " とencに対応するメニューファイルが読み込まれてしまい、これの後で読み込
    " まれる.vimrcでencが設定された場合にその設定が反映されずメニューが文字
    " 化けてしまう。
    set guioptions+=M
    source $VIMRUNTIME/vimrc_example.vim
    set guioptions-=M
  else
    source $VIMRUNTIME/vimrc_example.vim
  endif
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=8
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set nonumber
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
"set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let s:uname = system('uname')
  if s:uname =~? "linux"
    set term=builtin_linux
  elseif s:uname =~? "freebsd"
    set term=builtin_cons25
  elseif s:uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet s:uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
" KaoriYaでバンドルしているプラグインのための設定

" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
set formatexpr=autofmt#japanese#formatexpr()

" vimdoc-ja: 日本語ヘルプを無効化する.
if kaoriya#switch#enabled('disable-vimdoc-ja')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "vimdoc-ja"'), ',')
endif

" Copyright (C) 2009-2012 KaoriYa/MURAOKA Taro

















"=============================================================================
"    Description: .vimrcサンプル設定
"         Author: anonymous
"  Last Modified: 0000-00-00 07:03
"        Version: 0.00
"=============================================================================
set nocompatible
scriptencoding cp932
" scriptencodingと、このファイルのエンコーディングが一致するよう注意！
" scriptencodingは、vimの内部エンコーディングと同じものを推奨します。
" 改行コードは set fileformat=unix に設定するとunixでも使えます。

" Windowsで内部エンコーディングを cp932以外にしていて、
" 環境変数に日本語を含む値を設定したい場合は Let を使用します。
" Letは vimrc(オールインワンパッケージの場合)と encode.vim で定義されます。
" Let $HOGE=$USERPROFILE.'/ほげ'

"----------------------------------------
" ユーザーランタイムパス設定
"----------------------------------------
" Windows, unixでのruntimepathの違いを吸収するためのもの。
" $MY_VIMRUNTIMEはユーザーランタイムディレクトリを示す。
" :echo $MY_VIMRUNTIMEで実際のパスを確認できます。
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif

" ランタイムパスを通す必要のあるプラグインを使用する場合、
" $MY_VIMRUNTIMEを使用すると Windows/Linuxで切り分ける必要が無くなります。
" 例) vimfiles/qfixapp (Linuxでは~/.vim/qfixapp)にランタイムパスを通す場合
" set runtimepath+=$MY_VIMRUNTIME/qfixapp

"----------------------------------------
" 内部エンコーディング指定
"----------------------------------------
" 内部エンコーディングのUTF-8化と文字コードの自動認識設定をencode.vimで行う。
" オールインワンパッケージの場合 vimrcで設定されます。
" エンコーディング指定や文字コードの自動認識設定が適切に設定されている場合、
" 次行の encode.vim読込部分はコメントアウトして下さい。
" silent! source $MY_VIMRUNTIME/pluginjp/encode.vim
" scriptencodingと異なる内部エンコーディングに変更する場合、
" 変更後にもscriptencodingを指定しておくと問題が起きにくくなります。
" scriptencoding cp932

"----------------------------------------
" システム設定
"----------------------------------------
" mswin.vimを読み込む
" source $VIMRUNTIME/mswin.vim
" behave mswin

" ファイルの上書きの前にバックアップを作る/作らない
" set writebackupを指定してもオプション 'backup' がオンでない限り、
" バックアップは上書きに成功した後に削除される。
set nowritebackup
" バックアップ/スワップファイルを作成する/しない
set nobackup
if version >= 703
  " 再読込、vim終了後も継続するアンドゥ(7.3)
  " set undofile
  " アンドゥの保存場所(7.3)
  " set undodir=.
endif
" set noswapfile
set noswapfile
" viminfoを作成しない
" set viminfo=
" クリップボードを共有
set clipboard+=unnamed
" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100
" 編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set hidden
" ヒストリの保存数
set history=50
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM
" Visual blockモードでフリーカーソルを有効にする
set virtualedit=block
" カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" コマンドライン補完するときに強化されたものを使う
set wildmenu
" マウスを有効にする
if has('mouse')
  set mouse=a
endif
" pluginを使用可能にする
filetype plugin indent on

"----------------------------------------
" 検索
"----------------------------------------
" 検索の時に大文字小文字を区別しない
" ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
" インクリメンタルサーチ
set incsearch
" 検索文字の強調表示
set hlsearch
" w,bの移動で認識する文字
" set iskeyword=a-z,A-Z,48-57,_,.,-,>
" vimgrep をデフォルトのgrepとする場合internal
" set grepprg=internal

"----------------------------------------
" 表示設定
"----------------------------------------
" スプラッシュ(起動時のメッセージ)を表示しない
" set shortmess+=I
" エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set noerrorbells
set novisualbell
set visualbell t_vb=
" マクロ実行中などの画面再描画を行わない
" WindowsXpまたはWindowテーマが「Windowsクラシック」で
" Google日本語入力を使用するとIビームカーソルが残る場合にも有効
" set lazyredraw
" Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
" 行番号表示
set number
if version >= 703
  " 相対行番号表示(7.3)
  " set relativenumber
endif
" 括弧の対応表示時間
set showmatch matchtime=1
" タブを設定
" set ts=4 sw=4 sts=4
" 自動的にインデントする
"set autoindent
" Cインデントの設定
"set cinoptions+=:0
" タイトルを表示
"set title
" コマンドラインの高さ (gvimはgvimrcで指定)
" set cmdheight=2
set laststatus=2
" コマンドをステータス行に表示
set showcmd
" 画面最後の行をできる限り表示する
set display=lastline
" Tab、行末の半角スペースを明示的に表示する
set list
set listchars=tab:^\ ,trail:~

" ハイライトを有効にする
if &t_Co > 2 || has('gui_running')
  syntax on
endif
" 色テーマ設定
" gvimの色テーマは.gvimrcで指定する
" colorscheme mycolor

""""""""""""""""""""""""""""""
" ステータスラインに文字コード等表示
" iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするFencB()を使用
""""""""""""""""""""""""""""""
"if has('iconv')
"  set statusline=%<\ %f\ %m\ %r%h%w%{'['.&ff.']['.(&fenc!=''?&fenc:&enc).']['.&syntax.']'}%=@0x%{FencB()}\ (%v,%l)/%L%8P\ 
"else
"  set statusline=%<\ %f\ %m\ %r%h%w%{'['.&ff.']['.(&fenc!=''?&fenc:&enc).']['.&syntax.']'}%=\ (%v,%l)/%L%8P\ 
"endif
"if has('iconv')
"  set statusline=%<\ %f\ %m\ %r%h%w%{'['.&ff.']['.(&fenc!=''?&fenc:&enc).']['.&syntax.']'}%{fugitive#statusline()}%=@0x%{FencB()}\ (%v,%l)/%L%8P\ 
"else
"  set statusline=%<\ %f\ %m\ %r%h%w%{'['.&ff.']['.(&fenc!=''?&fenc:&enc).']['.&syntax.']'}%{fugitive#statusline()}%=\ (%v,%l)/%L%8P\ 
"endif

" FencB() : カーソル上の文字コードをエンコードに応じた表示にする
function! FencB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

"----------------------------------------
" diff/patch
"----------------------------------------
" diffの設定
if has('win32') || has('win64')
  set diffexpr=MyDiff()
  function! MyDiff()
    " 7.3.443 以降の変更に対応
    silent! let saved_sxq=&shellxquote
    silent! set shellxquote=
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let cmd = '!diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    silent execute cmd
    silent! let &shellxquote = saved_sxq
  endfunction
endif

" 現バッファの差分表示(変更箇所の表示)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
   call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

"----------------------------------------
" ノーマルモード
"----------------------------------------
" ヘルプ検索
nnoremap <F1> K
" 現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
" 強制全保存終了を無効化
nnoremap ZZ <Nop>
" カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
" キーボードマクロには物理行移動を推奨
" h l は行末、行頭を超えることが可能に設定(whichwrap)
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv

"----------------------------------------
" 挿入モード
"----------------------------------------

"----------------------------------------
" ビジュアルモード
"----------------------------------------

"----------------------------------------
" コマンドモード
"----------------------------------------

"----------------------------------------
" Vimスクリプト
"----------------------------------------
""""""""""""""""""""""""""""""
" ファイルを開いたら前回のカーソル位置へ移動
" $VIMRUNTIME/vimrc_example.vim
""""""""""""""""""""""""""""""
augroup vimrcEx
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "normal! g`\"" | endif
augroup END

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインのカラー変更
""""""""""""""""""""""""""""""
"let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
"
"if has('syntax')
"  augroup InsertHook
"    autocmd!
"    autocmd InsertEnter * call s:StatusLine('Enter')
"    autocmd InsertLeave * call s:StatusLine('Leave')
"  augroup END
"endif
"" if has('unix') && !has('gui_running')
""   " ESCですぐに反映されない対策
""   inoremap <silent> <ESC> <ESC>
"" endif
"
"let s:slhlcmd = ''
"function! s:StatusLine(mode)
"  if a:mode == 'Enter'
"    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"    silent exec g:hi_insert
"  else
"    highlight clear StatusLine
"    silent exec s:slhlcmd
"    redraw
"  endif
"endfunction
"
"function! s:GetHighlight(hi)
"  redir => hl
"  exec 'highlight '.a:hi
"  redir END
"  let hl = substitute(hl, '[\r\n]', '', 'g')
"  let hl = substitute(hl, 'xxx', '', '')
"  return hl
"endfunction

""""""""""""""""""""""""""""""
" 全角スペースを表示
""""""""""""""""""""""""""""""
" コメント以外で全角スペースを指定しているので、scriptencodingと、
" このファイルのエンコードが一致するよう注意！
" 強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
" scriptencoding cp932

"function! ZenkakuSpace()
"  silent! let hi = s:GetHighlight('ZenkakuSpace')
"  if hi =~ 'E411' || hi =~ 'cleared$'
"    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
"  endif
"endfunction
"if has('syntax')
"  augroup ZenkakuSpace
"    autocmd!
"    autocmd ColorScheme       * call ZenkakuSpace()
"    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"  augroup END
"  call ZenkakuSpace()
"endif

""""""""""""""""""""""""""""""
" grep,tagsのためカレントディレクトリをファイルと同じディレクトリに移動する
""""""""""""""""""""""""""""""
 "if exists('+autochdir')
 "  "autochdirがある場合カレントディレクトリを移動
 "  set autochdir
 "else
 "  "autochdirが存在しないが、カレントディレクトリを移動したい場合
 "  au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
 "endif

" 印刷用フォント
if has('printer')
  if has('win32') || has('win64')
  "set printfont=Migu_2M:h10:cSHIFTJIS
  "set printfont=MS_Mincho:h10.5:cSHIFTJIS
  set printfont=Ricty_Diminished:h10:cSHIFTJIS
  set printoptions=wrap:y,number:y
  set printoptions+=left:5mm,right:5mm,top:5mm,bottom:5mm
  endif
endif

"----------------------------------------
" 各種プラグイン設定
"----------------------------------------

"----------------------------------------
" 一時設定
"----------------------------------------
set notitle
syntax on
set noet cin ts=2 sw=2 sts=2 tw=0
filetype plugin indent on

"nmap <M-1> :setl et ts=1<CR>:retab<CR>:setl ts=1 sw=1 sts=1<CR>
"nmap <M-2> :setl et ts=2<CR>:retab<CR>:setl ts=2 sw=2 sts=2<CR>
"nmap <M-3> :setl et ts=3<CR>:retab<CR>:setl ts=3 sw=3 sts=3<CR>
"nmap <M-4> :setl et ts=4<CR>:retab<CR>:setl ts=4 sw=4 sts=4<CR>
"nmap <M-5> :setl noet ts=1<CR>:retab!<CR>:setl ts=2 sw=2 sts=2<CR>
"nmap <M-6> :setl noet ts=2<CR>:retab!<CR>:setl ts=2 sw=2 sts=2<CR>
"nmap <M-7> :setl noet ts=3<CR>:retab!<CR>:setl ts=2 sw=2 sts=2<CR>
"nmap <M-8> :setl noet ts=4<CR>:retab!<CR>:setl ts=2 sw=2 sts=2<CR>
"nmap <M-9> :setl et<CR>:retab<CR>
"nmap <M-0> :setl noet<CR>:retab!<CR>

"set tw=0
"set et cin ts=3 sw=3 sts=3
"set et cin ts=4 sw=4 sts=4
"set et cin ts=8 sw=4 sts=4
"set noet

"<------------------------------------------------------------------
""set ts=4 sw=4 sts=4
""set cindent
""set expandtab
""filetype plugin indent on
"
""au BufRead,BufNewFile *.c     setlocal sw=3
""au BufRead,BufNewFile *.cpp   setlocal sw=3
"
""au BufRead,BufNewFile *.pm    setlocal sw=3
""au BufRead,BufNewFile *.xs    setlocal sw=3
""au BufRead,BufNewFile *.cgi   setlocal sw=3
""au BufRead,BufNewFile *.psgi  setlocal sw=3
"
"au BufRead,BufNewFile *.rb    setlocal sw=2
""au BufRead,BufNewFile *.erb   setlocal sw=2
""au BufRead,BufNewFile *.rhtml setlocal sw=2
"
"au BufRead,BufNewFile *.yml   setlocal sw=2
"au BufRead,BufNewFile *.yaml  setlocal sw=2
"
"------------------------------------------------------------------>
"au BufRead,BufNewFile *.pl setlocal sw=3 sts=3


""au BufRead,BufNewFile *.md setlocal noet ts=4
"au FileType mkd setl noet ts=4
""au FileType markdown setl noet ts=4


"au FileType yaml setl sw=2 sts=2
"<------------------------------------------------------------------
"au BufRead,BufNewFile *.go setl noet ts=2 sw=2 sts=2
"au BufRead,BufNewFile *.java setl noet ts=2 sw=2 sts=2
"
augroup BufReads
  autocmd!

  autocmd BufRead,BufNewFile *.cgi  set ft=perl
  autocmd BufRead,BufNewFile *.psgi set ft=perl
  autocmd BufRead,BufNewFile *.wsgi set ft=python
  autocmd BufRead,BufNewFile *.md   set ft=markdown
  autocmd BufRead,BufNewFile *.vb   set ft=vbnet

  autocmd BufRead,BufNewFile *.c    setlocal et ts=4 sw=4 sts=4
  autocmd BufRead,BufNewFile *.cpp  setlocal et ts=4 sw=4 sts=4
  autocmd BufRead,BufNewFile *.pl   setlocal et ts=4 sw=4 sts=4
  autocmd BufRead,BufNewFile *.py   setlocal et ts=4 sw=4 sts=4
  autocmd BufRead,BufNewFile *.vb   setlocal et ts=4 sw=4 sts=4
  autocmd BufRead,BufNewFile *.frm  setlocal et ts=4 sw=4 sts=4

  autocmd BufRead,BufNewFile *.rb   setlocal et ts=2 sw=2 sts=2
  autocmd BufRead,BufNewFile *.xml  setlocal et ts=2 sw=2 sts=2
  autocmd BufRead,BufNewFile *.yml  setlocal et ts=2 sw=2 sts=2

  autocmd BufRead,BufNewFile *.html setlocal et ts=2 sw=2 sts=2
  autocmd BufRead,BufNewFile *.scss setlocal et ts=2 sw=2 sts=2
  autocmd BufRead,BufNewFile *.css  setlocal et ts=2 sw=2 sts=2
  autocmd BufRead,BufNewFile *.js   setlocal et ts=2 sw=2 sts=2

  autocmd BufRead,BufNewFile * setlocal formatoptions-=ro
augroup END

augroup BufWrites
  autocmd!

  autocmd BufWrite *.rb  setlocal fenc=utf8
  autocmd BufWrite *.py  setlocal fenc=utf8
  autocmd BufWrite *.vb  setlocal fenc=utf8
  autocmd BufWrite *.md  setlocal fenc=utf8
  autocmd BufWrite *.xml setlocal fenc=utf8
  autocmd BufWrite *.yml setlocal fenc=utf8

  "autocmd BufWrite *.c    FmtC
  "autocmd BufWrite *.cpp  FmtCPP
  "autocmd BufWrite *.java FmtJava
  "autocmd BufWrite *.pl   setlocal fenc=utf8
  "autocmd BufWrite *.pl   FmtPerl
  "autocmd BufWrite *.go   setlocal fenc=utf8
  "autocmd BufWrite *.go   Fmt
augroup END


"
"""autocmd FileType python setl nocindent
""autocmd FileType python setl autoindent
""autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
"autocmd FileType java setl noexpandtab
"------------------------------------------------------------------>

"set fileencodings=utf-8,cp932,euc-jp,default,latin,iso-2022-jp
"let IM_CtrlMode = 4

nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

"au BufRead,BufNewFile *.vb set filetype=vbnet
"au BufNewFile * set fenc=utf8

"au BufRead,BufNewFile *.vb set fileencoding=cp932
"au BufRead,BufNewFile *.frm set fileencoding=cp932
"au BufNewFile * set ff=unix
"nmap <F5> :wH0<CR>:!%<CR>

"nmap H H0
"nmap M M0
"nmap L L0

"nmap * *N

nnoremap <space>p $F<P


nnoremap <silent> <C-0> :ContinuousNumber <C-a><CR>
"nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> <C-0> :ContinuousNumber <C-a><CR>
"vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor


augroup MyXML
  autocmd!
  autocmd Filetype jsp inoremap <buffer> </ </<C-x><C-o><ESC>mav=`aa
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o><ESC>mav=`aa
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o><ESC>mav=`aa
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o><ESC>mav=`aa
augroup END

au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

set runtimepath+=$GOROOT/misc/vim
au BufRead,BufNewFile *.go set ft=go


au BufRead _ahk set ft=autohotkey
au BufRead *.less set ft=scss













"hi LineNr ctermfg=11
"hi Function ctermfg=10
"hi Identifier ctermfg=fg
"hi Underlined ctermbg=8
"hi Ignore ctermbg=8
"hi PmenuSel ctermfg=fg ctermbg=8
"hi PmenuSbar ctermfg=8
"hi PmenuThumb ctermfg=11
"hi SpellRare ctermfg=9
"
"hi perlVarPlain ctermfg=fg
"hi perlVarPlain2 ctermfg=fg
"hi perlStatement ctermfg=10
"hi perlIdentifier ctermfg=9
"hi perlOperator ctermfg=14
"hi perlPOD ctermfg=13
"
"hi vbOperator ctermfg=11
"hi vbFunction ctermfg=10
"
"hi rubyStringDelimiter ctermfg=13
"hi rubySymbolDelimiter ctermfg=13
"hi rubyDataDirective ctermfg=11
"
"hi dosbatchVariable ctermfg=10
"
"hi mkdRule ctermfg=11
"hi mkdListItem ctermfg=14
"
"hi htmlItalic ctermfg=14
"hi htmlBoldItalic ctermfg=14 ctermbg=8
"hi htmlUnderlineItalic ctermbg=DarkBlue
"hi htmlEndTag ctermfg=3
"hi htmlTagName ctermfg=11
"
"hi javaScript ctermfg=15
"
"hi xmlTag ctermfg=3
"hi xmlEndTag ctermfg=3
"
"hi hsOperator ctermfg=11
"
"hi StatusLine ctermfg=14 ctermbg=8
"hi StatusLineNC ctermfg=8 ctermbg=8
"
"hi CtrlPMatch ctermfg=9
"hi SpecialKey ctermfg=11
"
"hi javaScriptIdentifier ctermfg=9
"hi javaScriptFuncArg ctermfg=9
"
"hi cssSelectorOp ctermfg=fg
"hi cssSelectorOp2 ctermfg=fg
"hi cssTagName ctermfg=fg
"hi cssClassName ctermfg=fg
"hi cssIdentifier ctermfg=fg
"hi cssBraces ctermfg=13
"
"hi sassId ctermfg=fg
"hi sassIdChar ctermfg=fg
"hi sassClass ctermfg=fg
"hi sassClassChar ctermfg=fg
"hi sassAmpersand ctermfg=9
"
"hi CursorLine ctermfg=13 ctermbg=bg









"set runtimepath+=$XHOME/vimfiles
"set runtimepath+=$XUSR/vimfiles/_
"
"
"set runtimepath+=$XUSR/vimfiles/skk
let skk_jisyo = $HOME . '/.skk-jisyo'
let skk_large_jisyo = $HOME . '/SKK-JISYO.L'
let skk_auto_save_jisyo = 1
"
"set runtimepath+=$XUSR/vimfiles\ctrlp
"hi CtrlPMode1 ctermfg=14 ctermbg=8
"hi CtrlPMode2 ctermfg=14 ctermbg=8
"let g:ctrlp_clear_cache_on_exit = 0
"
"
"
"set runtimepath+=$XUSR/vimfiles/ctrlp-hotentry
"set runtimepath+=$XUSR/vimfiles/webapi
"set runtimepath+=$XUSR/vimfiles/open-browser
"
"set runtimepath+=$XUSR/vimfiles/simple-javascript-indenter
"" この設定入れるとshiftwidthを1にしてインデントしてくれる
"let g:SimpleJsIndenter_BriefMode = 1
"" この設定入れるとswitchのインデントがいくらかマシに
"let g:SimpleJsIndenter_CaseIndentLevel = -1
"
"set runtimepath+=$XUSR/vimfiles/vim-javascript-syntax
"
"set runtimepath+=$XUSR/vimfiles/jscomplete-vim
"
"
"set runtimepath+=$XUSR/vimfiles/tagbar
"nmap <Leader>TT :TagbarToggle<CR><C-W><C-W>










"set runtimepath+=$XUSR/vimfiles/align
"nmap <Space>= :Align=<CR>
"
"
"set runtimepath+=$XUSR/vimfiles/vim-multiple-cursors
"set runtimepath+=$XUSR/vimfiles/vim-easymotion
"
"set runtimepath+=$XUSR/vimfiles/neocomplcache
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

set runtimepath+=$HOME/vimfiles/snipmate-snippets
set runtimepath+=$HOME/vimfiles/neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ? (pumvisible() ? "\<C-n>" . neocomplcache#smart_close_popup() : "\<Plug>(neosnippet_expand_or_jump)") : pumvisible() ? "\<C-n>" : "\<TAB>"
"imap <expr><TAB> neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ? (pumvisible() ? "\<C-n>" . neocomplcache#smart_close_popup() : "\<Plug>(neosnippet_expand_or_jump)") : pumvisible() ? "\<C-n>" . neocomplcache#smart_close_popup() : "\<TAB>"
"imap <expr><TAB> neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"
"set runtimepath+=$XUSR/vimfiles/nerdcommenter
"
"set runtimepath+=$XUSR/vimfiles/TabBar
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
"
"set runtimepath+=$XUSR/vimfiles/emmet-vim
let g:user_emmet_expandabbr_key = '<c-e>'
"
"set runtimepath+=$XUSR/vimfiles/fugitive

""let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#right_sep = ' '
"let g:airline#extensions#tabline#right_alt_sep = '|'
"let g:airline_left_sep = ' '
"let g:airline_left_alt_sep = '|'
"let g:airline_right_sep = ' '
"let g:airline_right_alt_sep = '|'
"let g:airline_theme = "monochrome"

let g:lightline = {
        \ 'colorscheme': 'powerline',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     [ 'mode', 'paste' ],
        \     [ 'fugitive', 'gitgutter', 'filename' ]
        \   ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }
        "\ 'separator': {'left': '?', 'right': '?'},
        "\ 'subseparator': {'left': '?', 'right': '?'}

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:NERDTreeWinSize=80
let g:NERDTreeQuitOnOpen=1
"nmap <C-N> :NERDTreeToggle<CR>
"autocmd FileType nerdtree nmap <buffer> <2-LeftMouse> t
"autocmd FileType vimfiler nmap <buffer> <2-LeftMouse> <Plug>(vimfiler_edit_file)

let g:user_emmet_settings = {
\   'lang' : 'ja'
\ }

set numberwidth=5

nnoremap H H0
nnoremap M M0
nnoremap L L0
