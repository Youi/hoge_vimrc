" vim:set ts=8 sts=2 sw=2 tw=0: (���̍s�Ɋւ��Ă�:help modeline���Q��)
"
" An example for a Japanese version vimrc file.
" ���{��ł̃f�t�H���g�ݒ�t�@�C��(vimrc) - Vim7�p����
"
" Last Change: 25-Oct-2013.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" ���:
" ���̃t�@�C���ɂ�Vim�̋N�����ɕK���ݒ肳���A�ҏW���̋����Ɋւ���ݒ肪��
" ����Ă��܂��BGUI�Ɋւ���ݒ��gvimrc�ɏ�������Ă��܂��B
"
" �l�p�ݒ��_vimrc�Ƃ����t�@�C�����쐬�������ōs�Ȃ��܂��B_vimrc�͂��̃t�@
" �C���̌�ɓǍ��܂�邽�߁A�����ɏ����ꂽ���e���㏑�����Đݒ肷�邱�Ƃ��o��
" �܂��B_vimrc��$HOME�܂���$VIM�ɒu���Ă����K�v������܂��B$HOME��$VIM����
" �D�悳��A$HOME�ł݂������ꍇ$VIM�͓Ǎ��܂�܂���B
"
" �Ǘ��Ҍ����ɖ{�ݒ�t�@�C���𒼐ڏ����������ɍς܂��邱�Ƃ�ړI�Ƃ��āA�T�C
" �g���[�J���Ȑݒ��ʃt�@�C���ōs�Ȃ���悤�ɔz�����Ă���܂��BVim�N������
" �T�C�g���[�J���Ȑݒ�t�@�C��($VIM/vimrc_local.vim)�����݂���Ȃ�΁A�{�ݒ�
" �t�@�C���̎�v�������ǂݍ��܂��O�Ɏ����I�ɓǂݍ��݂܂��B
"
" �ǂݍ��݌�A�ϐ�g:vimrc_local_finish����0�̒l�ɐݒ肳��Ă����ꍇ�ɂ͖{��
" ��t�@�C���ɏ����ꂽ���e�͈�؎��s����܂���B�f�t�H���g�����S�č����ւ�
" �����ꍇ�ɗ��p���ĉ������B
"
" �Q�l:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"---------------------------------------------------------------------------
" �T�C�g���[�J���Ȑݒ�($VIM/vimrc_local.vim)������Γǂݍ��ށB�ǂݍ��񂾌��
" �ϐ�g:vimrc_local_finish�ɔ�0�Ȓl���ݒ肳��Ă����ꍇ�ɂ́A����ȏ�̐ݒ�
" �t�@�C���̓Ǎ��𒆎~����B
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ���[�U�D��ݒ�($HOME/.vimrc_first.vim)������Γǂݍ��ށB�ǂݍ��񂾌�ɕϐ�
" g:vimrc_first_finish�ɔ�0�Ȓl���ݒ肳��Ă����ꍇ�ɂ́A����ȏ�̐ݒ�t�@
" �C���̓Ǎ��𒆎~����B
if 1 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

" plugins���̃f�B���N�g����runtimepath�֒ǉ�����B
for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"---------------------------------------------------------------------------
" ���{��Ή��̂��߂̐ݒ�:
"
" �t�@�C����Ǎ��ގ��Ƀg���C���镶���G���R�[�h�̏������m�肷��B�����R�[�h��
" �����ʋ@�\�𗘗p����ꍇ�ɂ͕ʓriconv.dll���K�v�Biconv.dll�ɂ��Ă�
" README_w32j.txt���Q�ƁB���[�e�B���e�B�X�N���v�g��ǂݍ��ނ��ƂŐݒ肳���B
source $VIM/plugins/kaoriya/encode_japan.vim
" ���b�Z�[�W����{��ɂ��� (Windows�ł͎����I�ɔ��f�E�ݒ肳��Ă���)
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
" MacOS X���j���[�̓��{�ꉻ (���j���[�\���O�ɍs�Ȃ��K�v������)
if has('mac')
  set langmenu=japanese
endif
" ���{����͗p��keymap�̐ݒ�� (�R�����g�A�E�g)
if has('keymap')
  " ���[�}��������keymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif
" ��GUI���{��R���\�[�����g���Ă���ꍇ�̐ݒ�
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

"---------------------------------------------------------------------------
" ���j���[�t�@�C�������݂��Ȃ��ꍇ�͗\��'guioptions'�𒲐����Ă���
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" Bram���̒񋟂���ݒ����C���N���[�h (�ʃt�@�C��:vimrc_example.vim)�B����
" �ȑO��g:no_vimrc_example�ɔ�0�Ȓl��ݒ肵�Ă����΃C���N���[�h�͂��Ȃ��B
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  if &guioptions !~# "M"
    " vimrc_example.vim��ǂݍ��ގ���guioptions��M�t���O�����āAsyntax on
    " ��filetype plugin on�������N����menu.vim�̓ǂݍ��݂������B�������Ȃ�
    " ��enc�ɑΉ����郁�j���[�t�@�C�����ǂݍ��܂�Ă��܂��A����̌�œǂݍ�
    " �܂��.vimrc��enc���ݒ肳�ꂽ�ꍇ�ɂ��̐ݒ肪���f���ꂸ���j���[������
    " �����Ă��܂��B
    set guioptions+=M
    source $VIMRUNTIME/vimrc_example.vim
    set guioptions-=M
  else
    source $VIMRUNTIME/vimrc_example.vim
  endif
endif

"---------------------------------------------------------------------------
" �����̋����Ɋւ���ݒ�:
"
" �������ɑ啶���������𖳎� (noignorecase:�������Ȃ�)
set ignorecase
" �啶���������̗������܂܂�Ă���ꍇ�͑啶�������������
set smartcase

"---------------------------------------------------------------------------
" �ҏW�Ɋւ���ݒ�:
"
" �^�u�̉�ʏ�ł̕�
set tabstop=8
" �^�u���X�y�[�X�ɓW�J���Ȃ� (expandtab:�W�J����)
set noexpandtab
" �����I�ɃC���f���g���� (noautoindent:�C���f���g���Ȃ�)
set autoindent
" �o�b�N�X�y�[�X�ŃC���f���g����s���폜�ł���悤�ɂ���
set backspace=indent,eol,start
" �������Ƀt�@�C���̍Ō�܂ōs������ŏ��ɖ߂� (nowrapscan:�߂�Ȃ�)
set wrapscan
" ���ʓ��͎��ɑΉ����銇�ʂ�\�� (noshowmatch:�\�����Ȃ�)
set showmatch
" �R�}���h���C���⊮����Ƃ��ɋ������ꂽ���̂��g��(�Q�� :help wildmenu)
set wildmenu
" �e�L�X�g�}�����̎����܂�Ԃ�����{��ɑΉ�������
set formatoptions+=mM

"---------------------------------------------------------------------------
" GUI�ŗL�ł͂Ȃ���ʕ\���̐ݒ�:
"
" �s�ԍ����\�� (number:�\��)
set nonumber
" ���[���[��\�� (noruler:��\��)
set ruler
" �^�u����s��\�� (list:�\��)
set nolist
" �ǂ̕����Ń^�u����s��\�����邩��ݒ�
"set listchars=tab:>-,extends:<,trail:-,eol:<
" �����s��܂�Ԃ��ĕ\�� (nowrap:�܂�Ԃ��Ȃ�)
set wrap
" ��ɃX�e�[�^�X�s��\�� (�ڍׂ�:he laststatus)
set laststatus=2
" �R�}���h���C���̍��� (Windows�pgvim�g�p����gvimrc��ҏW���邱��)
set cmdheight=2
" �R�}���h���X�e�[�^�X�s�ɕ\��
set showcmd
" �^�C�g����\��
"set title
" ��ʂ����n�ɔ��ɂ��� (���s�̐擪�� " ���폜����ΗL���ɂȂ�)
"colorscheme evening " (Windows�pgvim�g�p����gvimrc��ҏW���邱��)

"---------------------------------------------------------------------------
" �t�@�C������Ɋւ���ݒ�:
"
" �o�b�N�A�b�v�t�@�C�����쐬���Ȃ� (���s�̐擪�� " ���폜����ΗL���ɂȂ�)
"set nobackup


"---------------------------------------------------------------------------
" �t�@�C�����ɑ啶���������̋�ʂ��Ȃ��V�X�e���p�̐ݒ�:
"   (��: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tags�t�@�C���̏d���h�~
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" �R���\�[���ł̃J���[�\���̂��߂̐ݒ�(�b��I��UNIX��p)
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
" �R���\�[���łŊ��ϐ�$DISPLAY���ݒ肳��Ă���ƋN�����x���Ȃ錏�֑Ή�
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" �v���b�g�z�[���ˑ��̓��ʂȐݒ�

" Win�ł�PATH��$VIM���܂܂�Ă��Ȃ��Ƃ���exe�������o���Ȃ��̂ŏC��
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Mac�ł̓f�t�H���g��'iskeyword'��cp932�ɑΉ�������Ă��Ȃ��̂ŏC��
  set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
" KaoriYa�Ńo���h�����Ă���v���O�C���̂��߂̐ݒ�

" autofmt: ���{�ꕶ�͂̃t�H�[�}�b�g(�܂�Ԃ�)�v���O�C��.
set formatexpr=autofmt#japanese#formatexpr()

" vimdoc-ja: ���{��w���v�𖳌�������.
if kaoriya#switch#enabled('disable-vimdoc-ja')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "vimdoc-ja"'), ',')
endif

" Copyright (C) 2009-2012 KaoriYa/MURAOKA Taro

















"=============================================================================
"    Description: .vimrc�T���v���ݒ�
"         Author: anonymous
"  Last Modified: 0000-00-00 07:03
"        Version: 0.00
"=============================================================================
set nocompatible
scriptencoding cp932
" scriptencoding�ƁA���̃t�@�C���̃G���R�[�f�B���O����v����悤���ӁI
" scriptencoding�́Avim�̓����G���R�[�f�B���O�Ɠ������̂𐄏����܂��B
" ���s�R�[�h�� set fileformat=unix �ɐݒ肷���unix�ł��g���܂��B

" Windows�œ����G���R�[�f�B���O�� cp932�ȊO�ɂ��Ă��āA
" ���ϐ��ɓ��{����܂ޒl��ݒ肵�����ꍇ�� Let ���g�p���܂��B
" Let�� vimrc(�I�[���C�������p�b�P�[�W�̏ꍇ)�� encode.vim �Œ�`����܂��B
" Let $HOGE=$USERPROFILE.'/�ق�'

"----------------------------------------
" ���[�U�[�����^�C���p�X�ݒ�
"----------------------------------------
" Windows, unix�ł�runtimepath�̈Ⴂ���z�����邽�߂̂��́B
" $MY_VIMRUNTIME�̓��[�U�[�����^�C���f�B���N�g���������B
" :echo $MY_VIMRUNTIME�Ŏ��ۂ̃p�X���m�F�ł��܂��B
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif

" �����^�C���p�X��ʂ��K�v�̂���v���O�C�����g�p����ꍇ�A
" $MY_VIMRUNTIME���g�p����� Windows/Linux�Ő؂蕪����K�v�������Ȃ�܂��B
" ��) vimfiles/qfixapp (Linux�ł�~/.vim/qfixapp)�Ƀ����^�C���p�X��ʂ��ꍇ
" set runtimepath+=$MY_VIMRUNTIME/qfixapp

"----------------------------------------
" �����G���R�[�f�B���O�w��
"----------------------------------------
" �����G���R�[�f�B���O��UTF-8���ƕ����R�[�h�̎����F���ݒ��encode.vim�ōs���B
" �I�[���C�������p�b�P�[�W�̏ꍇ vimrc�Őݒ肳��܂��B
" �G���R�[�f�B���O�w��╶���R�[�h�̎����F���ݒ肪�K�؂ɐݒ肳��Ă���ꍇ�A
" ���s�� encode.vim�Ǎ������̓R�����g�A�E�g���ĉ������B
" silent! source $MY_VIMRUNTIME/pluginjp/encode.vim
" scriptencoding�ƈقȂ�����G���R�[�f�B���O�ɕύX����ꍇ�A
" �ύX��ɂ�scriptencoding���w�肵�Ă����Ɩ�肪�N���ɂ����Ȃ�܂��B
" scriptencoding cp932

"----------------------------------------
" �V�X�e���ݒ�
"----------------------------------------
" mswin.vim��ǂݍ���
" source $VIMRUNTIME/mswin.vim
" behave mswin

" �t�@�C���̏㏑���̑O�Ƀo�b�N�A�b�v�����/���Ȃ�
" set writebackup���w�肵�Ă��I�v�V���� 'backup' ���I���łȂ�����A
" �o�b�N�A�b�v�͏㏑���ɐ���������ɍ폜�����B
set nowritebackup
" �o�b�N�A�b�v/�X���b�v�t�@�C�����쐬����/���Ȃ�
set nobackup
if version >= 703
  " �ēǍ��Avim�I������p������A���h�D(7.3)
  " set undofile
  " �A���h�D�̕ۑ��ꏊ(7.3)
  " set undodir=.
endif
" set noswapfile
set noswapfile
" viminfo���쐬���Ȃ�
" set viminfo=
" �N���b�v�{�[�h�����L
set clipboard+=unnamed
" 8�i���𖳌��ɂ���B<C-a>,<C-x>�ɉe������
set nrformats-=octal
" �L�[�R�[�h��}�b�s���O���ꂽ�L�[�񂪊�������̂�҂���(�~���b)
set timeout timeoutlen=3000 ttimeoutlen=100
" �ҏW���ʔ�ۑ��̃o�b�t�@����A�V�����o�b�t�@���J���Ƃ��Ɍx�����o���Ȃ�
set hidden
" �q�X�g���̕ۑ���
set history=50
" ���{��̍s�̘A�����ɂ͋󔒂���͂��Ȃ�
set formatoptions+=mM
" Visual block���[�h�Ńt���[�J�[�\����L���ɂ���
set virtualedit=block
" �J�[�\���L�[�ōs���^�s���̈ړ��\�ɐݒ�
set whichwrap=b,s,[,],<,>
" �o�b�N�X�y�[�X�ŃC���f���g����s���폜�ł���悤�ɂ���
set backspace=indent,eol,start
" ���⁛�̕����������Ă��J�[�\���ʒu������Ȃ��悤�ɂ���
set ambiwidth=double
" �R�}���h���C���⊮����Ƃ��ɋ������ꂽ���̂��g��
set wildmenu
" �}�E�X��L���ɂ���
if has('mouse')
  set mouse=a
endif
" plugin���g�p�\�ɂ���
filetype plugin indent on

"----------------------------------------
" ����
"----------------------------------------
" �����̎��ɑ啶������������ʂ��Ȃ�
" �������啶���������̗������܂܂�Ă���ꍇ�͑啶������������ʂ���
set ignorecase
set smartcase
" �������Ƀt�@�C���̍Ō�܂ōs������ŏ��ɖ߂�
set wrapscan
" �C���N�������^���T�[�`
set incsearch
" ���������̋����\��
set hlsearch
" w,b�̈ړ��ŔF�����镶��
" set iskeyword=a-z,A-Z,48-57,_,.,-,>
" vimgrep ���f�t�H���g��grep�Ƃ���ꍇinternal
" set grepprg=internal

"----------------------------------------
" �\���ݒ�
"----------------------------------------
" �X�v���b�V��(�N�����̃��b�Z�[�W)��\�����Ȃ�
" set shortmess+=I
" �G���[���̉��ƃr�W���A���x���̗}��(gvim��.gvimrc�Őݒ�)
set noerrorbells
set novisualbell
set visualbell t_vb=
" �}�N�����s���Ȃǂ̉�ʍĕ`����s��Ȃ�
" WindowsXp�܂���Window�e�[�}���uWindows�N���V�b�N�v��
" Google���{����͂��g�p�����I�r�[���J�[�\�����c��ꍇ�ɂ��L��
" set lazyredraw
" Windows�Ńf�B���N�g���p�X�̋�؂蕶���\���� / ���g����悤�ɂ���
set shellslash
" �s�ԍ��\��
set number
if version >= 703
  " ���΍s�ԍ��\��(7.3)
  " set relativenumber
endif
" ���ʂ̑Ή��\������
set showmatch matchtime=1
" �^�u��ݒ�
" set ts=4 sw=4 sts=4
" �����I�ɃC���f���g����
"set autoindent
" C�C���f���g�̐ݒ�
"set cinoptions+=:0
" �^�C�g����\��
"set title
" �R�}���h���C���̍��� (gvim��gvimrc�Ŏw��)
" set cmdheight=2
set laststatus=2
" �R�}���h���X�e�[�^�X�s�ɕ\��
set showcmd
" ��ʍŌ�̍s���ł������\������
set display=lastline
" Tab�A�s���̔��p�X�y�[�X�𖾎��I�ɕ\������
set list
set listchars=tab:^\ ,trail:~

" �n�C���C�g��L���ɂ���
if &t_Co > 2 || has('gui_running')
  syntax on
endif
" �F�e�[�}�ݒ�
" gvim�̐F�e�[�}��.gvimrc�Ŏw�肷��
" colorscheme mycolor

""""""""""""""""""""""""""""""
" �X�e�[�^�X���C���ɕ����R�[�h���\��
" iconv���g�p�\�̏ꍇ�A�J�[�\����̕����R�[�h���G���R�[�h�ɉ������\���ɂ���FencB()���g�p
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

" FencB() : �J�[�\����̕����R�[�h���G���R�[�h�ɉ������\���ɂ���
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
" diff�̐ݒ�
if has('win32') || has('win64')
  set diffexpr=MyDiff()
  function! MyDiff()
    " 7.3.443 �ȍ~�̕ύX�ɑΉ�
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

" ���o�b�t�@�̍����\��(�ύX�ӏ��̕\��)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" �t�@�C���܂��̓o�b�t�@�ԍ����w�肵�č����\���B#�Ȃ痠�o�b�t�@�Ɣ�r
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" �p�b�`�R�}���h
set patchexpr=MyPatch()
function! MyPatch()
   call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

"----------------------------------------
" �m�[�}�����[�h
"----------------------------------------
" �w���v����
nnoremap <F1> K
" ���݊J���Ă���vim�X�N���v�g�t�@�C�������s
nnoremap <F8> :source %<CR>
" �����S�ۑ��I���𖳌���
nnoremap ZZ <Nop>
" �J�[�\����j k �ł͕\���s�ňړ�����B�����s�ړ���<C-n>,<C-p>
" �L�[�{�[�h�}�N���ɂ͕����s�ړ��𐄏�
" h l �͍s���A�s���𒴂��邱�Ƃ��\�ɐݒ�(whichwrap)
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv

"----------------------------------------
" �}�����[�h
"----------------------------------------

"----------------------------------------
" �r�W���A�����[�h
"----------------------------------------

"----------------------------------------
" �R�}���h���[�h
"----------------------------------------

"----------------------------------------
" Vim�X�N���v�g
"----------------------------------------
""""""""""""""""""""""""""""""
" �t�@�C�����J������O��̃J�[�\���ʒu�ֈړ�
" $VIMRUNTIME/vimrc_example.vim
""""""""""""""""""""""""""""""
augroup vimrcEx
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "normal! g`\"" | endif
augroup END

""""""""""""""""""""""""""""""
" �}�����[�h���A�X�e�[�^�X���C���̃J���[�ύX
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
""   " ESC�ł����ɔ��f����Ȃ��΍�
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
" �S�p�X�y�[�X��\��
""""""""""""""""""""""""""""""
" �R�����g�ȊO�őS�p�X�y�[�X���w�肵�Ă���̂ŁAscriptencoding�ƁA
" ���̃t�@�C���̃G���R�[�h����v����悤���ӁI
" �����\������Ȃ��ꍇ�A������scriptencoding���w�肷��Ƃ��܂�������������܂��B
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
"    autocmd VimEnter,WinEnter * match ZenkakuSpace /�@/
"  augroup END
"  call ZenkakuSpace()
"endif

""""""""""""""""""""""""""""""
" grep,tags�̂��߃J�����g�f�B���N�g�����t�@�C���Ɠ����f�B���N�g���Ɉړ�����
""""""""""""""""""""""""""""""
 "if exists('+autochdir')
 "  "autochdir������ꍇ�J�����g�f�B���N�g�����ړ�
 "  set autochdir
 "else
 "  "autochdir�����݂��Ȃ����A�J�����g�f�B���N�g�����ړ��������ꍇ
 "  au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
 "endif

" ����p�t�H���g
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
" �e��v���O�C���ݒ�
"----------------------------------------

"----------------------------------------
" �ꎞ�ݒ�
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
"" ���̐ݒ������shiftwidth��1�ɂ��ăC���f���g���Ă����
"let g:SimpleJsIndenter_BriefMode = 1
"" ���̐ݒ������switch�̃C���f���g�������炩�}�V��
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
