---
title: 如何为Nginx服务器配置ssl证书
date: 2018-11-21 21:14:42
categories: 业务开发
---

# 如何为Nginx服务器配置ssl证书
&emsp;&emsp;我前不久才把自己的hexo博客部署到阿里云服务器上，买的学生机LAMP6.0.1,操作系统是centos，部署成功后就去申请备案，备案前期的资料审核还是快的，最后一步管局审核写着不超过20天，结果真的过了20天才发信息来审核通过...
&emsp;&emsp;之前的审核过程中，你的域名是不能进行访问，只能通过IP地址访问网站。审核通过后你可以通过http进行访问,但是不能通过进行https:进行访问。所以我们先来看看这两者的区别。
## http与https的基本定义

HTTP：是互联网上应用最为广泛的一种网络协议，是一个客户端和服务器端请求和应答的标准（TCP），用于从WWW服务器传输超文本到本地浏览器的传输协议，它可以使浏览器更加高效，使网络传输减少。

HTTPS：是以安全为目标的HTTP通道，简单讲是HTTP的安全版，即HTTP下加入SSL层，HTTPS的安全基础是SSL，因此加密的详细内容就需要SSL。

HTTPS协议的主要作用可以分为两种：一种是建立一个信息安全通道，来保证数据传输的安全；另一种就是确认网站的真实性。

## http与https的区别

HTTP协议传输的数据都是未加密的，也就是明文的，因此使用HTTP协议传输隐私信息非常不安全，为了保证这些隐私数据能加密传输，于是网景公司设计了SSL（Secure Sockets Layer）协议用于对HTTP协议传输的数据进行加密，这就是https的诞生。
阿里云官网的回答
>HTTP是过去很长一段时间我们经常用到的一种传输协议。HTTP协议传输的数据都是未加密的，这就意味着用户填写的密码、账号、交易记录等机密信息都是明文，随时可能被泄露、窃取、篡改，从而被黑客加以利用，因此使用HTTP协议传输隐私信息非常不安全。

>HTTPS是一种基于SSL协议的网站加密传输协议，网站安装SSL证书后，使用HTTPS加密协议访问，可激活客户端浏览器到网站服务器之间的SSL加密通道(SSL协议)，实现高强度双向加密传输，防止传输数据被泄露或篡改。简单讲，HTTPS=HTTP+SSL，即HTTPS是HTTP的安全版。

HTTPS加密、加密、及验证过程，如下图所示：
![alt](https://user-gold-cdn.xitu.io/2017/3/26/a480d891b7240325055da1e6b2f75ac3?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

按照网上博客的资料，两者主要有以下具体区别：
1、HTTPS更安全：HTTPS协议是由SSL+HTTP协议构建的可进行加密传输、身份认证的网络协议，要比HTTP协议的信息明文传输安全；

2、HTTPS需要申请证书：HTTPS协议需要到CA申请证书，一般免费证书很少，需要交费，费用大概与.com域名差不多，每年需要大约几十元的费用。而常见的HTTP协议则没有这一项；

3、端口不同：HTTP使用的是大家最常见的80端口，而HTTPS连接使用的是443端口；

4、状态不同：HTTP的连接很简单，是无状态的。而HTTPS协议是SSL+HTTP协议构建的可进行加密传输、身份认证的网络协议，要比HTTP协议安全；

## 为Nginx服务器配置ssl证书具体步骤

一：购买并申请免费证书

前往阿里云域名控制台-->进入域名管理-->申请免费开启ssl证书
这个过程比较快，一般申请成功后不需要多久证书就会发到你的证书控制台。
在证书控制台下载Nginx版本证书，下载到本地的是一个压缩文件，解压后里面包含.pem文件是证书文件，.key文件是证书的私钥文件（申请证书时如果没有选择系统创建CSR，则没有该文件）。

二、进入服务器配置Nginx.conf
按照官方文档，我们首先进入服务器的Nginx目录下，新建一个目录cert
```
mkdir cert
```
目录建完以后就需要把你之前下载的证书解压后的文件都拷贝到该目录下面。从本地拷贝文件到远程服务器可以用scp命令
```
scp -r /Users/study/xxxxx root@xxx:/etc/nginx/cert
```
我当时没注意，结果直接把整个文件夹给拷进去了，这样一来等会编辑文件路径的时候就不能忘了修改。
拷贝结束后就可以编辑Nginx.conf文件进行配置。
```
vim nginx.conf
```

```
server {
    listen 443;
    server_name localhost;
    ssl on;
    root html;
    index index.html index.htm;
    ssl_certificate   cert/a.pem;
    ssl_certificate_key  cert/a.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    location / {
        root html;
        index index.html index.htm;
    }
}
```
我主要提几个初次接触的小白容易碰到的问题：

 * include /etc/nginx/default.d/*.conf;这一行不需要取消注释
 * server_name 可以改为你自己的域名
 * location/{}里面的root注意要填写你当时配置的项目位置。

 配置好以后保存并退出。
 之后重新加载并启动nginx
```
nginx -s reload

systemctl restart nginx.service
```
这里很多人一开始可能会出现启动失败的错误，这时不要慌，我的建议是最好学会查看日志文件，看看命令行提示报了什么错。
```
nginx -t
```
我碰到过的有一种是属于80端口被某个进程占用，当时我是直接强制杀死该进程解决的。其他启动失败的原因多数是你nginx.conf文件配置出错了，比如如法错误，多了什么或少了什么。
我当时启动成功后采用https方式访问域名，结果一直都是显示Nginx welcome的首页面，这里其实就是我之前提到过的location/{}里面写错了。当时还有点慌，因为我不记得我把自己的hexo放在哪里了，但还好，把Nginx.conf往上翻就能找到我以前配置过的hexo的root信息，直接复制下来即可。

到这里，证书配置基本就完成了。
