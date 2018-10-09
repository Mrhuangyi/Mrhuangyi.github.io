---
title: JavaWeb开发环境设置
date: 2018-10-01 13:39:58
tags: Java
categories: 业务开发
---

# 第一步：下载所需要的开发工具
- 我这里的javaweb项目选择eclipse的javaee，下载网站：https://www.eclipse.org/downloads/packages/
- 服务器下载Tomcat，下载网站：http://tomcat.apache.org/
- java jdk下载：https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
- jdk的环境配置这里我就不写了。
- 注意点：版本问题，每个软件版本都不是随便下的，首先不提倡急着下载最新版的，容易出bug。另外尤其要注意jdk版本和Tomcat版本的兼容问题，有一个版本过高或过低都是不行的。
关于版本匹配：可以参考下图（Tomcat官网有介绍）
![alt](http://pc5wd3ju6.bkt.clouddn.com/tomcatversion.PNG)

# 第二步：eclipse配置
1 如下图：
进入preferences
![alt](http://pc5wd3ju6.bkt.clouddn.com/jw1.PNG)

2 进入java选项下的installed JREs配置jdk目录

![alt](http://pc5wd3ju6.bkt.clouddn.com/jw2.PNG)

![alt](http://pc5wd3ju6.bkt.clouddn.com/jw3.PNG)

3 进入server配置tomcat的运行环境


![alt](http://pc5wd3ju6.bkt.clouddn.com/jw4.PNG)

# 第三步，新建一个javaweb项目，验证
如下图，在web选项新建一个Dynamic Web Project,并新建一个jsp，在里面任意输入内容后并允许，若能够正常输出，则配置成功。
![alt](http://pc5wd3ju6.bkt.clouddn.com/jw5.PNG)
