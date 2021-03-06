---
title: 一个成功的git分支模型
date: 2019-03-16 19:20:45
categories: 译文集
---


# 一个成功的Git分支模型
>原文链接：https://nvie.com/posts/a-successful-git-branching-model/
>原文作者： Vincent Driessen

在这片文章我介绍了一些我在一年前为一些项目（包括工作和私人）介绍的开发模型，并且事实证明非常成功。一直以来我都打算专门为其写一篇文章，然而我几乎完全找不到空闲的时间来做这件事，直到现在。我不会讨论任何有关项目的细节，只关注这个分支策略和发布管理。

<div align="center"> <img src="https://nvie.com/img/git-model@2x.png" width="640"/> </div><br>
<!-- more -->

# 为什么要用git？
有关Git与集中式源代码控制系统相比的优缺点的详细讨论，请参阅如下网站：
[网站](https://git.wiki.kernel.org/index.php/GitSvnComparsion)
上述论坛有很多思想碰撞的火焰。作为一个开发者，在今天所有其他的工具里面我更偏爱Git。Git确实改变了开发人员对合并与分支的看法。从经典的CVS / Subversion世界来看，合并/分支一直被认为有点可怕（“小心合并冲突，它们会咬你！”）以及有时候你在一段时间只做一次的事情。

但是使用Git，这些操作变得非常轻便和简单，并且它们被认为是您日常工作流程的核心部分之一。例如，在CVS / Subversion 书籍中，分支与合并首先在后面的章节中被讨论（对于高级用户），而在 每一本 Git 书中，它已经在第3章（基础知识）中被介绍过。  

由于其简单性和重复性，分支和合并不再是一件令人害怕的事情。版本控制工具应该比其他任何东西更有助于进行分支/合并的操作。

关于这个工具讲够了，让我们进入这个开发模型。我将在这里介绍的模型本质上不再是每个团队成员必须遵循的为了进入托管软件开发过程的一组程序。

# 分散但集中
我们使用的存储库设置与该分支模型配合良好，具有中心“真实”存储库。请注意，这个仓库只被认为是一个中央仓库（因为Git是DVCS，在技术层面没有这种中央仓库这种东西）。我们将此repo称为origin，因为所有Git用户都熟悉此名称。

![[alt]](https://nvie.com/img/centr-decentr@2x.png)

每个开发人员都会拉取并推送到origin。但除了集中式推拉关系之外，每个开发人员还可以从其他同行中获取更改以形成子团队。例如，在将正在进行的工作过早推进origin之前，在开发一项大的新功能时，这对于两个或更多开发人员一起工作可能是有用的 。在上图中，有爱丽丝和鲍勃，爱丽丝和大卫以及克莱尔和大卫这些子团队。

从技术上讲，这意味着Alice已经定义了一个Git远程，名为bob，指向Bob的存储库，反之亦然。

# 主要分支
在核心部分，开发模型受到现有模型的极大启发。中央仓库拥有两个主要分支，具有无限的生命周期：
- master
- develop

![alt](https://nvie.com/img/main-branches@2x.png)

该master分支的origin应该对每一位Git用户都很熟悉。与master分支并行的另一个分支称为develop分支。

我们认为origin/master是反映这个HEAD源代码生产就绪状态的主要分支 。

我们认为origin/develop是主要的分支，其源代码 HEAD始终反映了最新交付的下一版本中开发被更改的状态。有些人称之为“整合分支”。这是在夜间自动被构建的地方。

当develop分支中的源代码到达稳定点并准备好被发布时，所有的更改都应该以某种方式被合并到master分支，然后使用版本号进行标记。上述将如何执行进一步详细讨论。  

因此，当每次将更改合并回master时，根据定义，这是一个新的生产版本。我们对此非常严格，因此从理论上讲，我们可以使用Git钩子脚本在每次提交时对master自动构建和发布我们的软件到我们的生产服务器 。

# 支持分支

接着上面的主要分支master和develop，我们的发展模式，采用了多种支持分支机构，以帮助团队成员进行并行开发，缓解功能跟踪，为生产版本做准备，并协助快速修复现场制作的问题。与主要分支不同，这些分支的寿命有限，因为它们最终会被删除。  

我们可能使用的不同类型的分支是：

- 功能分支
- 发布分支机构
- 修补程序分支

这些分支中的每一个都有特定的目的，并且必须遵守关于哪些分支可以是它们的起始分支以及哪些分支必须是它们的合并目标的严格规则。我们将在一分钟内讨论它们。  

从技术角度来看，这些分支绝不是“特殊的”。分支类型根据我们如何使用它们进行分类。他们当然是老的Git分支。

## 功能分支

- 可能会分支于：
develop
- 必须合并回：
develop
- 分支命名约定：
anything except master, develop, release-\*, or hotfix-\*


功能分支（或有时称为主题分支）用于为即将发布或将来的版本开发新功能。在开始开发功能时，此功能将会在其中合并的目标版本，但可能在此时未知。功能分支的本质是，只要功能处于开发阶段，它就会存在，但最终会被合并回develop（以便将新功能添加到即将发布的版本中）或丢弃（在实验令人失望的情况下）。  

功能分支通常仅存在于开发人员存储库中，而不存在于origin。

![alt](https://nvie.com/img/fb@2x.png)

## 创建一个功能分支

```
$ git checkout -b myfeature develop
 切换到新分支“myfeature”
```

## 在开发中加入完成的功能
完成的功能可能会合并到develop分支中，以确保将它们添加到即将发布的版本中：

```
$ git checkout develop
 切换到分支'develop'
$ git merge --no-ff myfeature
 更新ea1b82a..05e9557
（更改摘要）
$ git branch -d myfeature
 已删除分支myfeature（为05e9557）。
$ git push origin开发

```

该--no-ff标志会导致合并始终创建新的提交对象，即使可以使用快进执行合并。这样可以避免丢失有关历史上存在的功能分支的信息，并将所有一起添加的功能提交组合在一起。两者相比：

![alt](https://nvie.com/img/merge-without-ff@2x.png)

在后一种情况下，不可能从Git历史中看到哪些提交对象一起实现了一个功能 - 您必须手动读取所有日志消息。恢复整个功能（即一组提交）在后一种情况下也是一件真正令人头痛的事，而如果使用该--no-ff标志则很容易完成 。

是的，它会创建一些（空的）提交对象，但增益远远大于成本。

# 发布分支

可能会分支于：
develop
必须合并回：
develop 和 master
分支命名约定：
release-*

发布分支支持准备新的生产版本。它们允许最后一刻点缀我和交叉t。此外，它们允许修复小错误并为发布准备元数据（版本号，构建日期等）。通过在发布分支上执行所有这些工作，develop 分支将被清除以接收下一个大版本的功能。

新发布分支的关键时刻develop是开发（几乎）反映新版本的期望状态。至少所有针对要构建的版本的功能必须在此时合并到其中 。针对未来版本的所有功能可能不会 - 他们必须等到发布分支后。

正是在发布分支的开始，即将发布的版本被分配了一个版本号 - 而不是之前的版本号。直到那一刻，这个develop 分支反映了“下一个版本”的变化，但不清楚“下一个版本”最终是否会变为0.3或1.0，直到发布分支开始。该决定是在发布分支的开始时做出的，并根据项目相关版本号冲突的规则执行。

## 创建一个发布分支
发布分支是从develop分支创建的。例如，假设版本1.1.5是当前的生产版本，我们即将推出一个大版本。状态develop为“下一个版本”做好了准备，我们已经决定这将成为版本1.2（而不是1.1.6或2.0）。因此，我们为发布分支提供反映新版本号的名称：

```
$ git checkout -b release-1.2 develop
 切换到新分支“release-1.2”
$ ./bump-version.sh 1.2
 文件修改成功，版本提升到1.2。
$ git commit -a -m “Bumped version number to 1.2”
[release-1.2 74d9424] Bumped version number改为1.2
1个文件被改变，1个插入（+），1个删除（ - ）

```

在创建新分支并切换到它后，我们会修改版本号。这个bump-version.sh是一个虚构的shell脚本，它可以更改工作副本中的某些文件以反映新版本。（这当然可以手动更改 - 关键是某些文件会发生变化。）然后，该冲突版本号会被提交。

这个新的分支可能存在一段时间，直到发布可能会被真正推出。在此期间，可以在此分支中应用错误修复（而不是在develop分支上）。严禁在此处添加大型新功能。它们必须合并到develop，因此要等待下一个大版本。

## 完成一个发布分支

当发布分支的状态准备好成为真正的发布版本时，需要执行一些操作。首先，发布分支被合并到 master（因为每次提交到master的都是按照定义的新版本，请记住）。接下来，master必须标记该提交，以便将来参考此历史版本。最后，需要将发布分支上所做的更改合并回到develop，以便将来的版本也包含这些错误修复。

Git的前两个步骤：
```
$ git checkout master
切换到分支'master'
$ git merge --no-ff release-1.2
 由递归合并而成。
（更改摘要）
$ git tag -a 1.2
```

该版本现已完成，并标记以供将来参考。

> 编辑：您可能还想使用-s或-u <key>标记以加密方式对您的标记进行签名。

为了保持发布分支中所做的更改，我们需要将这些更改合并到develop。在Git中：
```
$ git checkout develop
 切换到分支'develop'
$ git merge --no-ff release-1.2
 由递归合并而成。
（变更摘要）

```

这一步很可能导致合并冲突（甚至，因为我们已经更改了版本号）。如果是这样，请修复并提交。

现在我们已经完成了，并且可能会删除发布分支，因为我们不再需要它了：

```
$ git branch -d release-1.2
 删除了分支版本1.2（ff452fe）。

```

## 修补程序分支
可能会分支于：
master
必须合并回：
develop 和 master
分支命名约定：
hotfix-*

修补程序分支非常类似于发布分支，因为它们也是为了准备新的生产版本，尽管是计划外的。它们源于必须立即实际生产版本的不良状态采取反应。当必须立即解决生产版本中的关键错误时，可以从标记生产版本的主分支上的相应标记分支修补程序分支。

实质是团队成员（在develop分支机构）的工作可以继续，而另一个人正在准备快速生产修复。

![alt](https://nvie.com/img/hotfix-branches@2x.png)

## 创建修补程序分支
从master分支创建修补程序分支。例如，假设版本1.2是当前生产版本正在运行的版本并且由于严重错误而出现了bug。但是变化在develop分支仍然不稳定。然后我们可以分支出修补程序分支并开始修复问题：
```
$ git checkout -b hotfix-1.2.1 master
 切换到新分支“hotfix-1.2.1”
$ ./bump-version.sh 1.2.1
 文件修改成功，版本提升到1.2.1。
$ git commit -a -m “Bumped version number to 1.2.1”
[hotfix-1.2.1 41e61bb] Bumped version number to 1.2.1
1个文件改变了，1个插入（+），1个删除（ - ）

```

分支后不要忘记碰撞版本号！
然后，修复错误并在一个或多个单独的提交中提交修复。

```
$ git commit -m “修复了严重生产问题”
[hotfix-1.2.1 abbe5d6]修复了严重生产问题
5个文件发生了变化，32个插入（+），17个删除（ - ）

```

## 完成一个修补程序分支
完成后，需要将错误修复合并回到master，但也需要合并回到develop，以保证错误修复程序也包含在下一个版本中。这与发布分支的完成方式完全相似。
首先，更新master并标记版本。

```
$ git checkout master
 切换到分支'master'
$ git merge --no-ff hotfix-1.2.1
 由递归合并。
（更改摘要）
$ git tag -a 1.2.1

```

> 编辑：您可能还想使用-s或-u <key>标记以加密方式对您的标记进行签名。

接下来，在develop分支中也包括错误修复：

```
$ git checkout develop
 切换到分支'develop'
$ git merge --no-ff hotfix-1.2.1
 由递归合并。
（变更摘要）

```

此处规则的一个例外是，  当发布分支当前存在时，需要将修补程序更改合并到该发布分支中，而不是develop分支。在发布分支完成时，将错误修复反向合并到发布分支中最终会导致错误修复也被合并到develop分支。（如果develop分支立即工作并涉及次错误修复并且不能等待发布分支完成，您可以安全地将错误修复合并到develop分支。）

最后，删除临时分支：

```
$ git branch -d hotfix-1.2.1
 删除了分支修补程序-12.2.1（是abbe5d6）。

```

# 摘要
虽然这个分支模型没有什么真正令人震惊的地方，但这篇文章开头的“大图”可以被证明在我们的项目中非常有用。它形成了一个易于理解的优雅模型，并能够让团队成员形成对分支和发布过程的共同理解。
