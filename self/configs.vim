
"""""  plus github repo:
" ./my_plugins/
"   git@github.com:Shougo/neocomplete.vim.git
"   git@github.com:majutsushi/tagbar.git
"   git@github.com:SirVer/ultisnips.git
" ./sources_non_forked/
"   git@github.com:tomasr/molokai.git


set history=2500

" line number
set nu


""""""""""""""""""""  about neocomplete.vim 

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" set mapleader
let mapleader = ","

" Go related mappings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab)

" vim-go settings: 在save file时既可以格式化代码，又可以自动插入包导入语句
" finished by somewhere...
"let g:go_fmt_command = "goimports"



"""""""""""""""""" about tagbar
"设置tagbar的窗口宽度  
let g:tagbar_width=30  

"设置tagbar的窗口显示的位置,为右边. 将左边留给Nerd Tree
let g:tagbar_right=1  

"打开文件自动 打开tagbar  
autocmd BufReadPost *.go,*.py,*.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  

"映射tagbar的快捷键  
nmap <F8> :TagbarToggle<CR>

" 设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
" 输入:Tagbar就可以打开tagbar，右侧的窗口会显示一系列符号。
" 当光标在右侧的某项时，可以通过Ctrl + ]跳至该项符号定义处，Ctrl + t返回。



""""""""""""""""" about Nerd Tree

" 关闭vim时，如果打开的文件除了NERDTree没有其他文件时，它自动关闭，减少多次按:q!
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif

" 打开vim时自动打开NERDTree
"autocmd vimenter * NERDTree

" usage: refer: http://www.jianshu.com/p/eXMxGx.  or use "?" to triggle help info.



""""""""""""""""" about molokai scheme

let g:molokai_original = 1
" under sources_non_forked/molokai


""""""""""""""""" about ultisnips

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" 用tab做snippet展开，ctrl+b正向切换占位符，ctrl+z反向切换占位符。
" 用法：输入func后按tab，此时进行扩展。形成name(params) {}
"   1、此时直接输入函数外，其后按ctrl-b再直接输入参数名，
"   2、如果要向前切换，则使用ctrl-z，此时位于函数名处，直接输入新的函数名即可。
"   3、不支持go中结构体的方法前缀，需要在输入函数名时直接加上结构变量如：(d *Dispatcher) FuncName

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


