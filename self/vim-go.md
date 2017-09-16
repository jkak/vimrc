## install vim-go



### 1) install dep

用于在vim中执行":GoInstallBinaries"命令时加载的工具。先将大部分都准备好。

[**参考**](http://www.cnblogs.com/breg/p/5386365.html)第三部分。

```go
go get -v github.com/alecthomas/gometalinter
go get -v github.com/alecthomas/gometalinter
go get -v github.com/alecthomas/gometalinter

go get -v github.com/kisielk/errcheck
go get -v github.com/jstemmer/gotags
go get -v github.com/klauspost/asmfmt/cmd/asmfmt

go get -v github.com/zmb3/gogetdoc
go get -v github.com/dominikh/go-tools/cmd/keyify

go get -v golang.org/x/tools/cmd/goimports
// 其他不同的部分，再列出来。
```



### 2） download vimrc项目

这是一个上万星的项目。

```shell
git clone git@github.com:jungle85gopy/vimrc.git  ~/.vim_runtime/
# forked from amix/vimrc

cd  ~/.vim_runtime/
bash install_awesome_vimrc.sh
# gen ~/.vimrc file
```

此时，因为目录下已经集成了sources_non_forked/vim-go/。因此打开go文件，已经有高亮及保存时自动补全import的功能。

可执行的命令：

```powershell
- 新起一行输入fmt.，然后ctrl+x, ctrl+o，Vim 会弹出补齐提示下拉框，不过并非实时跟随的那种补齐，这个补齐是由gocode提供的。
– 输入一行代码：time.Sleep(time.Second)，执行:GoImports，Vim会自动导入time包。
– 将光标移到Sleep函数上，执行:GoDef或命令模式下敲入gd，Vim会打开$GOROOT/src/time/sleep.go中 的Sleep函数的定义。执行:b 1返回到hellogolang.go。
– 执行:GoLint，运行golint在当前Go源文件上。
– 执行:GoDoc，打开当前光标对应符号的Go文档。
– 执行:GoVet，在当前目录下运行go vet在当前Go源文件上。
– 执行:GoRun，编译运行当前main package。
– 执行:GoBuild，编译当前包，这取决于你的源文件，GoBuild不产生结果文件。
– 执行:GoInstall，安装当前包。
– 执行:GoTest，测试你当前路径下地_test.go文件。
– 执行:GoCoverage，创建一个测试覆盖结果文件，并打开浏览器展示当前包的情况。
– 执行:GoErrCheck，检查当前包种可能的未捕获的errors。
– 执行:GoFiles，显示当前包对应的源文件列表。
– 执行:GoDeps，显示当前包的依赖包列表。
– 执行:GoImplements，显示当前类型实现的interface列表。
– 执行:GoRename [to]，将当前光标下的符号替换为[to]。
```

其中补全功能在一些目录下不成功。



### 3）neocomplete自动补全功能



```shell
# https://github.com/Shougo/neocomplete.vim
cd /Users/song/.vim_runtime/

grep my_plugins vimrcs/*
vimrcs/plugins_config.vim:call pathogen#infect(s:vim_runtime.'/my_plugins/{}')

cd my_plugins
git clone git@github.com:Shougo/neocomplete.vim.git
cd -
vim my_configs.vim
# 添加上前4项，就可以自动补全了。
```



conf。启动自动补全，启动map leader。

```powershell
" about neocomplete.vim """"""""""
 
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3


" about map leader """"""""""""""
" set mapleader
let mapleader = ","

" Go related mappings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab) 
```

#### 3.1) 快捷命令

以运行文件为例：

正常需要退出文件然后再执行`go run xxx.go`来运行。

有了上面的map leader设置后。

在命令模式下，输入`<ctl+,>`，然后马上输入`+`，就是运行当前main包。效果如下，回车后又回到终端。

```shell
vim main.go

vim-go
2017/09/16 13:47:08

Press ENTER or type command to continue
```



### 4) tagbar

```shell
cd my_plugins

git clone git@github.com:majutsushi/tagbar.git
Cloning into 'tagbar'...
remote: Counting objects: 2993, done.
remote: Compressing objects: 100% (32/32), done.
remote: Total 2993 (delta 11), reused 24 (delta 5), pack-reused 2954
Receiving objects: 100% (2993/2993), 3.01 MiB | 526.00 KiB/s, done.
Resolving deltas: 100% (1141/1141), done.

cd -
vim my_configs.vim
# nmap <F8> :TagbarToggle<CR>
```

设置后，打开一个go文件，使用F8却报错。解决办法[参考](https://github.com/majutsushi/tagbar/issues/365)：

```shell
# here are two ctags known as GNU ctags and exuberant-ctags, what the tagbar need to use is exuberant-ctags. exuberant-ctags need to be installed by yourself.

#What I do to solve this problem is
#brew install ctags-exuberant
#and find it's installed in /usr/local/Cellar/ctags/5.8_1
#then I add a line in .vimrc:
#let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
#then it work well.

brew install ctags-exuberant
=> Summary
🍺  /usr/local/Cellar/ctags/5.8_1: 8 files, 341.6K

vim my_configs.vim
let g:tagbar_ctags_bin='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
```

当光标在右侧的某项时，可以通过Ctrl + ]跳至该项符号定义处，Ctrl + t返回。



### 5) NERDTree

显示左右的文件树结构。已经默认有安装包。在sources_non_forked/nerdtree位置。

配置项在vimrcs/plugins_config.vim。默认是在右侧的，与tagbar冲突了。调整如下：

```shell
-let g:NERDTreeWinPos = "right"
+let g:NERDTreeWinPos = "left"

-let g:NERDTreeWinSize=35
+let g:NERDTreeWinSize=30

map <leader>nn :NERDTreeToggle<cr>
```

打开文件树的方式如上最后一行。使用



### 6) molokai color/theme



```shell
find vimrcs -type f | xargs grep 'colorscheme'
vimrcs/basic.vim:    colorscheme desert
vimrcs/extended.vim:colorscheme peaksea
vimrcs/plugins_config.vim:      \ 'colorscheme': 'wombat',
vimrcs/plugins_config.vim:      \ 'colorscheme': 'wombat',
# .vimrc 顺序：
# 	1) basic.vim 
# 	2）filetype.vim
#	3) plugin_config.vim
# 	4) my_configs.vim

# 修改“colorscheme peaksea”为 molokai，结果打开文件显示找不到该配色
vim vimrcs/extended.vim:colorscheme peaksea


find . -type d  -name colors
./sources_forked/peaksea/colors
./sources_forked/vim-irblack-forked/colors
./sources_non_forked/gruvbox/colors
./sources_non_forked/mayansmoke/colors
./sources_non_forked/vim-colors-solarized/colors
./sources_non_forked/vim-pyte/colors

cd ./sources_non_forked/
git clone git@github.com:tomasr/molokai.git
cd - 
vim my_configs.vim
# add:
# let g:molokai_original = 1

```



### 7) ultisnips



```shell
cd my_plugins
git clone git@github.com:SirVer/ultisnips.git

```



### 8) update vim to vim8 with-lua

```shell

 brew install vim --with-lua --override-system-vim
 Error: vim-8.0.0160 already installed
 To install this version, first `brew unlink vim`
 
 brew unlink vim
 Unlinking /usr/local/Cellar/vim/8.0.0160... 126 symlinks removed
 
 brew install vim --with-lua --override-system-vim
 ==> Installing dependencies for vim: lua
 ==> Installing vim dependency: lua
 ==> Downloading https://homebrew.bintray.com/bottles/lua-5.2.4_4.sierra.bottle.1.tar.gz
####################################################### 100.0%

==> Summary
  /usr/local/Cellar/lua/5.2.4_4: 144 files, 705.5K
 ==> Installing vim --with-lua
 ==> Using the sandbox
 ==> Downloading https://github.com/vim/vim/archive/v8.0.0402.tar.gz
 ==> Downloading from https://codeload.github.com/vim/vim/tar.gz/v8.0.0402
####################################################### 100.0%
 ==> ./configure --prefix=/usr/local --mandir=/usr/local/Cellar/vim/8.0.0402/share/man --enable-multibyte --with-tlib=ncurses --ena
 ==> make
 ==> make install prefix=/usr/local/Cellar/vim/8.0.0402 STRIP=/usr/bin/true
 🍺  /usr/local/Cellar/vim/8.0.0402: 1,714 files, 23.3M, built in 1 minute 54 seconds
```



### 小结

因为my_configs.vim和my_plugins被.gitignore了。因此单独建一个目录来保存必要的信息。

```shell
# 在新的环境将本项目拉取下来后
cd .vim_runtime
cp self/configs.vim  		./my_configs.vim
cp self/extended.vim       	./vimrcs/
cp self/plugins_config.vim	./vimrcs/

```

几个依赖的repo：

```shell
#  plus github repo:
 ./my_plugins/
#   git@github.com:Shougo/neocomplete.vim.git
#   git@github.com:majutsushi/tagbar.git
#   git@github.com:SirVer/ultisnips.git
 ./sources_non_forked/
#   git@github.com:tomasr/molokai.git

```

