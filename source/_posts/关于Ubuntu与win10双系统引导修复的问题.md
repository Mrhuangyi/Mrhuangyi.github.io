---
title: 关于Ubuntu与win10双系统引导修复的问题
date: 2018-10-01 15:30:50
categories: 随笔
---

# 问题来源

我的电脑之前是在Windows10系统上装了一个Fedora版本的linux，基本上使用都没什么问题，说实话，因为我大部分软件或开发工具啥的主要都装在Windows系统上，所以平时还是win10用的比较多。但最近听说国内有一款仿Ubuntu的深度deepin系统也挺不错的，而且界面还挺像mac，所以就急着将自己电脑上的Fedora换成了deepin，但估计就是在安装deepin的时候出了叉子。我到现在也没搞清楚是哪里出了问题，动了什么不该动的东西，导致win10的启动引导程序坏了，最后结果就是按下开机键只能进入deepin了。即是你在刚开机时按下ESC进入系统选择界面选择Windows也是照样进不了。

# 解决过程

发现进不了Windows只能进deepin我就开始有点慌了，要知道我很多软件和工具都是装在Windows上面，而linux还只是个壳子。我可不想重装系统，当然也不得不做好这最坏的打算。当时试了很多方法行不通，就又将deepin换成了Ubuntu，但结果还是一样，这倒是在意料之中。起初以为只是Ubuntu与win10不兼容，需要修复一下引导就行，但按理说不应该的，我室友的组装机用的就是这两个系统，从来没出什么问题。我上网查了查，有人说直接进入Ubuntu终端，运行sudo -updategrub，更新一下grub就行了，但我试了好几次，包括修改grub.cfg文件，但都行不通，每次update以后根本不显示found Windows这样的字眼。这是便意识到想必是win10的引导已经损坏了，再在linux上面瞎搞估计也无济于事。这样一来，我就去网上找资料，查如何修复win10引导。主要步骤如下：

- 首先你得有个win64位的PE系统启动U盘，在开机的时候按下ESC键进入系统选择界面（我的电脑是ESC，这个不同版本电脑可能有所不同，也有可能你是F11，F12）,之后选择你的U盘启动系统进入。
- 进入系统后，打开你的DG（DiskGenuis）分区工具

![alt](http://pc5wd3ju6.bkt.clouddn.com/dg1.PNG)

使用这个工具之前需要注意一个问题，那就是你的硬盘是什么格式的，是GPT还是MBR？
-

很多人写的修复方法都是针对硬盘类型为mbr的，就是直接选中的系统盘，如下图：点击硬盘选项下的重建主引导记录。

![alt](http://pc5wd3ju6.bkt.clouddn.com/dg2.png)

然而问题出现了，当我点击 硬盘选项后，重建主引导记录这一栏是灰色的，无法选中。原因就是我的硬盘类型是GPT的。

- 接下来要做的就是修复GPT格式的引导，首先我们注意到ESP分区没有盘符，我们需要给他指定一个盘符：
![alt](http://pc5wd3ju6.bkt.clouddn.com/dg3.PNG)

- 指派好了就关闭DG工具，回到桌面，

打开cmd命令行，输入以下命令并运行

　　bcdboot c:\windows /s g: /f uefi /l zh-cn

　　其中：c:\windows  硬盘系统目录，根据实际情况修改

　　/s g:     指定esp分区所在磁盘，根据实际情况修改

　　/f uefi   指定启动方式为uefi

　　/l zh-cn  指定uefi启动界面语言为简体中文

　　注：64位7PE不带/s参数，故7PE不支持bios启动下修复

![alt](http://pc5wd3ju6.bkt.clouddn.com/dg4.PNG)

- 创建成功后重新启动电脑，选择Windows boot manager进入系统，到这里win10的引导也就修复完成。

# 待解决问题
win10引导修复完成后的结果是，每次开机都是默认直接进入Windows，如果想要进入Ubuntu，还是要刚开机时按下ESC手动选择进入，而不是和之前一样，出现一个双系统选择界面供你直接选择。我进入Ubuntu之后尝试修复此问题，主要进行了如下操作：
1 进入Ubuntu终端，输入如下命令利用bootrepair修复引导
```
# 进入root用户
sudo -i 
# 添加软件源并更新
add-apt-repository ppa:yannubuntu/boot-repair &&　apt-get update
＃　安装boot-repair并启动软件
apt-get install -y boot-repair && boot-repair

```
2 查看Windows10磁盘所在引导，然后继续进入Ubuntu终端，修改引导

```
sudo -i
vim /boot/grub/grub.cfg
//再该文件末尾修改win10引导信息。
//之后再更新引导
grub-mkconfig -o /boot/grub/grub.cfg

```
3 庆幸的是更新引导之后的确出现了found Windows的字眼，但是当我重启电脑，发现并没有改变什么，还是只能直接进入Windows，所以挺困惑的。
