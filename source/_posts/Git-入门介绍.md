---
title: Git 与Ｇithub入门介绍
date: 2018-09-27 22:22:17
tags: Github
categories: 业务开发
photos: http://pc5wd3ju6.bkt.clouddn.com/timg.jpg
---

# Git是什么？
　　Git 是一款免费、开源的分布式版本控制系统，最早由 LinilusTorvalds 创建，用于管理 Linux 内核开发， 现已成为分布式版本控制的主流工具。版本控制系统（VCS）： 一种可以管理和追逐软件代码或其他类似类容的不同版本的工具。我们知道一旦启动一个项目，数据短暂且易失，对于相关的文本和代码，我们需要寻找合适的备份策略。而版本控制系统就是很好的备份策略，方便开发人员对变更进行追踪管理。。Git 由 Linus Torvalds 发明，起初是为了方便管理 Linux1内核的开发工作。如今，Git 已经在大量的项目中得到了 非常成功的应用。 
　　
# Ｇｉｔ常见功能
1. 从服务器上克隆数据库（包括代码和版本信息）到单机上。 
2. 在自己的机器上创建分支，修改代码。
3. 在本地上自己创建的分支上提交代码。
4. 在单机上合并分支。
5. 新建⼀个分⽀，把服务器上最新版的代码fetch下来，然后跟⾃⼰的主分⽀合并。 
6. ⽣成补丁（patch），把补丁发送给主开发者。   
7.  看主开发者的反馈，如果主开发者发现两个⼀般开发者之间有冲突（他们之间可 以合作解决的冲突），就会要求他们先解决冲突，然后再由其中⼀个⼈提交。如果 主开发者可以⾃⼰解决，或者没有冲突，就通过。 
8. ⼀般开发者之间解决冲突的⽅法，开发者之间可以使⽤ pull 命令解决冲突，解决 完冲突之后再向主开发者提交补丁

# Git初步入门
* 如果你是第一次安装使用Git，你需要设置署名和邮箱：

         $ git config --global user.name "⽤户名" 
         $ git config --global user.email "电⼦邮箱"

## 关于git的常用命令，阮一峰老师有一篇博客讲的蛮好的。
  链接：http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html

阮老师用了一张图介绍了最常用的6个命令。
![alt](http://pc5wd3ju6.bkt.clouddn.com/git.png)
```
* Workspace：工作区
* Index / Stage：暂存区
* Repository：仓库区（或本地仓库）
* Remote：远程仓库
```

* 将代码仓库clone到本地，其实就是将代码复制到你的机器⾥，并交由Git来管理：

       $ git clone git@github.com:someone/symfony-docs-chs.git

* 初始化本地仓库，当前目录下会出现一个名为 .git 的目录
    
    $ git init
    
* 新建一个目录，将其初始化为Git代码库
    
    $ git init [project-name]

* 下载一个项目和它的整个代码历史

     $ git clone [url]

* 删除工作区文件，并将这次删除放入暂存区

    $ git rm [file1] [file2] ...

* 向这个本地的代码仓库添加当前目录的所有改动。
        
       $ git add .

* 提交文件到本地仓库
     
     $ git commit -m "Hello"   
     
* 提交暂存区的指定文件到仓库
    
     $ git commit [file1] [file2] ... -m [message]

* 添加某个文件

     $ git add -p

* 查看现在的状态

    $ git status

* 推送所有分支到远程仓库

     $ git push [remote] --all
# Github是什么

* 维基百科的说明：

GitHub 是⼀个共享虚拟主机服务，⽤于存放使⽤ Git 版本控制的软件代码 和内容项⽬。它由 GitHub 公司（曾称 Logical Awesome）的开发者 Chris Wanstrath、PJHyett和TomPreston-Werner使⽤RubyonRails编写⽽成。

* 官方介绍：
GitHubisthebestplacetosharecodewithfriends,co-workers,classmates, andcompletestrangers. OvereightmillionpeopleuseGitHubtobuildamazingthingstogether.

* 对普通用户来说，它还可以是：
1 网站
2 静态博客
3 管理配置文件
4 资料收集库
5 简历
6 管理代码片段
7 托管的编程环境
8 写作
……
* 界面主要功能
1 Git仓库
2 Organization
可以统一管理账户和权 限，还能统一支付一些费用。 
3 Issue
Issue功能，是将一个任务或问题分配给一个 Issue进行追踪和管理的功能。每一个功能更改或修正都对应一个Issue，讨论或修正都以这个 Issue为中心进行。只要查看Issue，就能知道和这个更改相关的一切信 息，并以此进行管理。 
4 Wiki
通过Wiki功能，任何人都能随时对一篇文章进行更改并保存，因 此可以多人共同完成一篇文章。该功能常用在开发文档或手册的编写 中。
5 Pull Request 
开发者向GitHub的仓库推送更改或功能添加后，可以通过Pull Request 功能向别人的仓库提出申请，请求对方合并。


GitHub可以托管各种git库，并提供⼀个web界⾯，但与其它像SourceForge 或 GoogleCode 这样的服务不同，GitHub 的独特卖点在于从另外⼀个项⽬ 进⾏分⽀的简易性。为⼀个项⽬贡献代码⾮常简单：⾸先点击项⽬站点的 “fork” 的按钮，然后将代码检出并将修改加⼊到刚才分出的代码库中，最后通过内建的 “pullrequest” 机制向项⽬负责⼈申请代码合并。

# GitHub项目创建
可以直接在web页面new repository。
或者
```
$ git init 
$ git add .
$ git commit -m "first commit" 
$ git remote add origin 地址
$ git push -u origin master //将代码由本地仓库上传到Github远程仓库
```

# Pull Request 的概要
* Pull Request 是自己修改源代 码后，请求对方仓库采纳该修改时采取的一种行为。

![alt](http://pc5wd3ju6.bkt.clouddn.com/pushrequest.PNG)

PR流程：
1 fork对方的repository
2 clone你之前fork的repository到你的本地电脑
      
     git clone git@url
3 与对方GitHub的repository建立连接

    git remote add upstream url
4 建立工作分支

    git checkout -b xiaoming-branch
5 添加代码

6 提交修改
用 git diff命令查看修改是否已经正确进行。
使用 git add PRTest ，git commit ,git push等系列命令提交

7 发起Pull Request
