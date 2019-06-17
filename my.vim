set number
set pastetoggle=<F2>
set hlsearch
set incsearch
set smartindent
set clipboard=unnamed
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cindent

let mapleader=","
syntax on
set list lcs=tab:\|\ 

inoremap jj <Esc>`^
inoremap <leader>w <Esc>:w<cr>
noremap <leader>w :w<cr>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

com! FormatJSON %!python3 -m json.tool


"vim-plug
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify' "启动界面
Plug 'vim-airline/vim-airline' "状态栏
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine' "缩进线
Plug 'w0ng/vim-hybrid' "主题

Plug 'scrooloose/nerdtree' "目录
Plug 'kien/ctrlp.vim' "文件模糊搜索
Plug 'easymotion/vim-easymotion' "快速定位
Plug 'chun-yang/auto-pairs' "括号，引号自动配对

Plug 'tpope/vim-surround'  "成对编辑ys,cs,ds
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  "模糊搜索Files,Ag
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'  "搜索替换Far foo bar **/*.py , Fardo

"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  "golang IDE
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }  "python IDE
Plug 'lfv89/vim-interestingwords' "高亮<leader>k,<leader>K
Plug 'tpope/vim-commentary'  "快速注释gcc,gcgc
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'} "自动补全

call plug#end()


"配合插件使用
"NERDTree
map <C-n> :NERDTreeToggle<CR> 
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.git$','\.bash']
"ctrlp
let g:ctrlp_map = '<c-p>' "ctrlp
"easymotion
nmap <Leader> <Plug>(easymotion-prefix)
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
"hybrid
let g:hybrid_custom_term_colors = 1
set background=dark
colorscheme hybrid"
"coc
set updatetime=300
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"python
let g:pymode_python = 'python3'
let g:pymode_trim_whitespaces = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_rope_goto_definition_bin = "<C-]>"
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pyflakes','pep8','pylint']
set completeopt-=preview
inoremap <f8> <Esc>:PymodeLintAuto<cr>
noremap <f8> :PymodeLintAuto<cr>

"<F5> compile and running code
noremap <f5> :call RunningCode()<cr>
inoremap <f5> <Esc>:call RunningCode()<cr>
func! RunningCode()
	exec "w"
	if &filetype == 'c'
		exec "! gcc % -o a.out && ./a.out && rm a.out"
	elseif &filetype == 'cpp'
		exec "! g++ % -o a.out && ./a.out && rm a.out"
	elseif &filetype == 'python'
		exec "! python %"
	elseif &filetype == 'sh'
		exec "!chmod a+x % && ./%"
	endif
endfunc

"<F9> debug c/cpp
noremap <f9> :call DebugCode()<cr>
inoremap <f9> <Esc>:call DebugCode()<cr>
func! DebugCode()
	exec "w"
	if &filetype == 'c'
		exec "! gcc -g % -o a.out && gdb a.out && rm a.out"
	elseif &filetype == 'cpp'
		exec "! g++ -g % -o a.out && gdb a.out && rm a.out"
	endif
endfunc
