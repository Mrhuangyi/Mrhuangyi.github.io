---
title: 如何在Windows和Mac平台上协同管理hexo博客
date: 2018-10-10 17:12:56
tags: Github
categories: 业务开发


---


# 如何在多台电脑协同管理hexo博客
我很早就想搞个个人博客，其实写博客主要有3种选择：
- 1 在第三方平台注册账号，直接在平台上写作并发布，例如博客圆，CSDN，新浪，网易等,这种方式最简单方便。
- 2 自己搭建博客。这种看个人需求，能力强的，可以完全前后端都自己代码实现，但大多数人一般也是直接采用模版的，简单省事。不过自己搭建的话需要去云服务商购买域名和云服务器，服务器的话学生优惠还是比较大的，阿里云，腾讯云上面都能买。
- 3 利用GitHub pages和hexo搭建静态博客，本地编写md文件，然后部署到github转化为html，相当于是托管于github。这种方法至少不用花钱买服务器，当然，你要是想绑定域名的话也可以照样去云服务商买一个，然后绑定到你的XXX.github.io上面。

<!-- more -->

现在假设你已经在之前的Windows平台上搭好了hexo博客，并且能够正常部署运行。但因为需要，你要在另一台Mac系统的电脑上也能够管理你的hexo博客，可以利用Git分支来实现。

# 在另一设备上管理博客
1. 配置好环境
* 安装Node.js
* 安装Git
* 安装hexo
node.js可以直接去官网下载相应的匹配版本，Git的话，如果你的电脑安装是Mac并且安装了xcode，那么便不用再重新安装，xcode里便已经装有Git。
2. 配置GitHub的SSH key
在新电脑上使用GitHub都需要先进行SSH key的配置，来获得GitHub的权限，以便本地和服务器之间数据的连接。
- 先测试你的电脑上是否已有ssh密钥,打开终端输入：
```
cd ~/.ssh
```
如果没有，则进入下一步，生成ssh key
```
ssh-keygen -t rsa -C "邮件地址"
```
3. 将你的ssh key复制到GitHub上，打开你的github主页，进入个人设置 -> SSH and GPG keys -> New SSH key：将ssh key复制进去。
4. 最后测试你的ssh是否配置成功
```
ssh -T git@github.com
```
具体如何配置hexo博客可以参考：[使用hexo快速搭建个人博客](https://www.titanjun.top/2018/03/08/%E5%9F%BA%E4%BA%8EGitHub%E5%92%8CHexo%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2/)

# 创建分支
1. 进入你的username.github.io仓库主要，新建一个分支，名字可以自定义，下面以hexo为例：
![alt](http://pc5wd3ju6.bkt.clouddn.com/hexo1.jpg)

2. 切换到hexo分支，并将该分支设置为默认分支后并保存。
![alt](http://pc5wd3ju6.bkt.clouddn.com/hexo2.jpg)

# 上传配置文件到GitHub
1. 克隆hexo分支
将之前新建的分支克隆到本地
```
git clone -b hexo git@github.com/username/username.github.io
```
查看当前所在分支是否为新建的hexo分支
```
git branch
```
2. 上传部署文件
- 将你原先电脑里的配置文件拷贝到你的username.github.io文件目录下，这里的拷贝有几个文件或文件夹是必须要拷贝的：
**拷贝文件时要注意如果你的themes主题文件下下面有.git文件夹，要先将.git文件夹删除，否则主题文件会上传失败，一个GitHub仓库只能有一个.git**
```
_config.yml
 package.json
 scaffolds/
 source/
 themes/
```
- 拷贝完以后执行npm install 安装必要的组件
- 执行如下命令更新分支：
```
git add .
git commit -m "add new files"
git push
```
- 测试是否成功
可以执行hexo new "post",hexo s预览是否有效，之后便用hexo d -g上传部署。
* 使用Mac系统操作hexo命令是要求在最前面加上sudo，否则会报错，提示你权限不足。
> master分支和hexo分支各自保存着一个版本，master分支用于保存博客静态资源，提供博客页面供人访问；hexo分支用于备份博客部署文件，供自己维护更新，两者在一个GitHub仓库内也不会有任何冲突
