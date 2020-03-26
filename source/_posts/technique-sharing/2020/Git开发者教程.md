---
title: Git开发者教程
date: 2020-03-26 17:01:56
author: 罗三
tags:
- git
---
## 一、什么是git？
 ### 1.1、简介
 git是一个分布式版本控制软件，最初由林纳斯·托瓦兹创作也就是伟大的Linux创始人Linus创作。
 ### 1.2、常见代码托管平台
- 全世界最大的代码托管网站: [https://github.com/](https://github.com/)。
- 国内较多用户使用的网站：[https://gitee.com](https://gitee.com)。
- 可以免费搭建自己的代码托管网站的 gitLab
- 版本控制工具还有cvs、svn
 <!-- more -->

 ### 1.2、对比svn
简单列举一些和svn的比较：
- svn是集中式版本控制系统，git是分布式版本控制系统
- svn是直接与服务器进行交互，git是将文件存到本地然后再推送到服务器
- svn必须在连网的情况下工作，git可以不连网开发
- svn易发生冲突，git相对于svn不易发生冲突
- svn适用于多项目并行开发，git适用于单项目开发
- git内容完整性要优于svn，git内容存储使用的是SHA-1哈希算法，这能确保代码内容的完整性，确保在遇到磁盘故障和网络问题时降低对版本库的破坏。
- 相比svn，git对分支的隔离是逻辑隔离而不是物理隔离，这意味着创建分支非常快速、存储分支不会占用过多磁盘空间

---

## 二、git分支介绍
### 2.1、概念
- 分支(branch)可以理解为是仓库(repository)的一种隔离视图。
分支的目的为了支持多人、多版本开发。

- Git支持多分支开发，并鼓励使用本地多分支，这些分支之间是彼此完全独立的。
- 常见的分支操作包括：创建分支、切换分支、合并分支、删除分支。
### 2.2、常见分支操作
2.2.1. 创建分支：给分支名取一个简短且有意义的名字。
2.2.2. 提交改动：填写有意义的commit message: what & why，推荐的commit message格式为 <issue id>: <description> ，比如：512: 增加了对NFS的支持。
2.2.3. 发起合并请求：同时发起code review和讨论，不经过review的代码不允许合并进public branch。
2.2.4. 代码评审和讨论：
-  审查代码是否满足功能、规范、测试结果、测试覆盖等要求。
-  审查合格才允许合并合进public branch，不合格的代码退回重新修改。
-  鼓励使用同行评审（Peer Review）而不是上下级评审，鼓励积极反馈、互动。
- 评审对事不对人，多建议，不批评，不指责。
- 评审过程对reviewer和代码提交者双方都是一个学习提升的过程。
- 部署：使用经过完整测试的分支来部署到生产环境，部署后发生问题需要回退时，用上一个版本进行回退。
- 合并回master分支。

部署成功，没有问题后才合并到master分支。
## 三、分支策略
用git首先得了解项目需要采用哪一种分支策略。
目前主流的git工作流模式有[git flow、github flow、gitlab flow](https://www.jianshu.com/p/1889b0fe073b)，需要根据软件集成方式和团队规模和协作方式，调整自己团队的分支策略。
几种模型各有所长，下面简述一下

- git flow：出现时间最早，基于git的workflow的开山鼻祖，可以说给出了一个git flow的最佳实践，缺点是流程比较复杂，release branch和hotfix branch几乎没人使用，另外需要长期维护master和dev两个分支，在规模不大的场景下维护成本比较高
- github flow：相当精简，只有master主干和feature branch这两种，结构相当清晰，缺点是master默认为当前上线的最新版本，在对于版本管理要求比较复杂的场景下灵活性不足
- gitlab flow：出现的最晚，可以说集合了前两家的长处，既保证只有一个长期主干，结构清晰，同时也定义了不同场景下的branch，增强了灵活性。

### 3.1、git flow简介
大多数公司都基于[git flow]((https://www.jianshu.com/p/1889b0fe073b))的模式，并在此基础上做了调整。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191119163946896.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
### 3.2、其他工作流模式
工作流模式每个公司的不一样，都可能在gitflow的基础上做了很大改动
下面列举三种基于gitflow的改造后模式。
#### 3.2.1、模式一
模式一简要描述：
- 功能模块的同一个feature分支开发人员共同开发（也可额外创建自己的分支定期push到feature）
- 一个feature对应一个测试环境
- 功能分支sit测试完成后，直接到release版本
- release版本验收成功之后发生产。
-  hotfixes直接基于master进行修改和上线。
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019111917451583.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)

#### 3.2.2、模式二
每个开发者都有自己的分支，时不时地往dev分支上合并就可以了。跟模式一的区别在于，模式一的测试环境主要以feature为准，到测试基本完成后发布到develop的基本是小改动，小改动验收完成后直接develop到生产，而模式而强调每个人一个分支，测试主要以develop为准。

所以，团队合作的分支看起来就像这样：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191120205011829.png)
对于多个业务模块并行开发的具体场景如下
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121153605711.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
#### 3.2.3、模式三
模式三和模式一、模式二很类似，主要区别在于不需要每个开发者创建分支，共同在一个feature分支上面去做开发。模式三和模式一的区别在于，模式一强调以feature分支作为开发和测试的分支，而模式一稳定版本后直接发布到release分支，而模式三强调所有修改以develop为测试基准，测试完成直接发布到master。
- 开发【feature分支】：从develop拉新分支，命名feature/迭代版本号_功能说明，不可以从feature分支再拉新分支
- 测试【develop分支】：将feature分支合并到develop分支，再部署到测试环境
- 发布【master分支】：将develop测试后的稳定版本合并到master分支，打版本标签，再进行发布，未经测试的不稳定代码不可以合并到master
- 修复线上问题【hotfix分支】：从master分支拉新分支，命名hotfix/xxx，修复bug后合并到master分支，再将修复从master分支合并到develop分支
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191120214424390.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)

#### 3.2.4、几种模式对比

模式名称 | 本地分支 |  测试环境分支|预生产环境|线上分支|
|-|-|-|-|-|
|模式一 |feature/** | feature/** |release|master|
|模式二 | blob/john | develop |无|master|
|模式三 | feature/** | develop |无|master|
--- 
## 四、安装和运行
登录git官网: [https://git-scm.com/](https://git-scm.com/) 下载git for windows，安装后有3个程序：

- git bash （模拟linux终端）- git cmd (windows终端)
- git gui (windows界面)

推荐使用git bash，git cmd和git gui可以忽略。

在linux和mac上使用git和在windows上使用git bash一样，不再赘述。
现在主流的ide（比如intellij idea和eclipse) 都对git有非常好的支持。
推荐通过ide + git bash 方法来使用git。

## 五、git开发操作流程
### 5.1、基本操作概览

```bash
# master创建新分支：
git checkout master
# 创建并切换到 issues1234
git checkout -b  issues1234
# 推送新分支到远程仓库
git push origin issues1234
# 添加所有本地修改文件
git add ..
# commit所有本地修改文件到本地仓库
git commit -m "***"
# push到远程仓库
git push origin issues1234
```

如下两图，主要区别在于
- 图一直接拉取git现有代码，
- 图二初始化之后关联远程空仓库
### 5.2、操作流程步骤

基本开发流程如：
1. 建立远程仓库
2. 拉取远程仓库代码同步到本地仓库和workspace
3. 创建分支
4. 基于分支开发
5. 提交开发代码并同步到仓库（提交前先pull远程代码，如果有冲突则需要比对并解决冲突）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191120223308550.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019112022483230.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)


##  六、常用命令
常用命令比如：拉取、提交、添加、对比、提交、删除、创建分支、合并分支、merge、强制回退、还原、部分还原、查看历史，设置全局用户名密码、git免登陆、代码审查

### 6.1、命令文档
- git no deep shit:
 [http://rogerdudler.github.io/git-guide/](http://rogerdudler.github.io/git-guide/)
- 常用Git命令清单（阮一峰）: [http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html](http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)
- git操作规范(Miss_Ye): [https://segmentfault.com/a/1190000014461898](https://segmentfault.com/a/1190000014461898)
- 命令大全
[https://www.jianshu.com/p/31fa525d0853](https://www.jianshu.com/p/31fa525d0853)

### 6.2、git help
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121115435585.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
### 6.3、git常用命令速查表

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121115259366.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
git：http和ssh的区别
## 七、常见场景
 ### 7.1、在gitlab上新建一个项目（repository）
 7.1.1、 操作步骤
 1. 打开gitlab首页
 2. 点击new project按钮
 3. 进入blank project填写 项目名、项目描述（选填）、是否公开的项目
 4. 点击 create project。
 
7.1.2、创建完成之后，
1. 进入新建项目的首页
2. 找到clone 按钮
3. 查看git 地址，分为http方式和ssh方式两个地址

地址分为SSH和HTTP(S)两种方式如:
- http方式：[https://github.com/lufei222/san-aitoubao.git](https://github.com/lufei222/san-aitoubao.git)
- ssh方式：git@github.com:lufei222/san-aitoubao.git

**SSH和HTTP(S)两种方式的主要区别是：**

- SSH方式需要将本地的SSH public key添加到GitLab账号的setting中，比较安全。
- HTTP(S)方式第一次push到GitLab时需要提供用户名和密码登陆，操作比较简单。
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/2019112108591345.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121090535256.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
 ### 7.2、远程gitlab项目clone到本地
 7.2.1、设置git config的user.name 和 user.email :

```bash
# 查看git config
git config --list

# 设置Global的user.name和user.email
git config --global user.name user_name
git config --global user.email user_email

# 查看git config确认
git config --list
```
7.2.2、从gitLab上clone一个repository到本地：

```bash
# SSH 方式
git clone <repo_git_url>

# HTTP 方式
git clone <repo_http_url>
```

### 7.3、分支管理
#### 7.3.1、本地创建、切换分支

从master分支创建dev分支并切换到dev分支

```bash
# 切换到master分支
git checkout master
# 基于master分支，创建并切换到dev分支
git checkout -b dev
```

其中，git checkout -b dev 等价于:


```bash
# 创建dev分支
git branch dev
# 切换到dev分支
git checkout dev
```
查看本地当前的分支
```bash
# 查看本地当前的分支，分支前面带“*”表示当前分支，剩下的分支表示本地有的分支。
git branch
# 查看远程全部的分支，白色的表示本地有的，红色的表示本地没有，仅在远程存在。
git branch -a
```




![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121092151919.png)
#### 7.3.2、分支常见操作

```bash
 
# 列出所有本地分支
$ git branch
 
# 列出所有远程分支
$ git branch -r
 
# 列出所有本地分支和远程分支
$ git branch -a
 
# 新建一个分支，但依然停留在当前分支
$ git branch [branch-name]
 
# 新建一个分支，并切换到该分支
$ git checkout -b [branch]
 
# 新建一个分支，指向指定commit
$ git branch [branch] [commit]
 
# 新建一个分支，与指定的远程分支建立追踪关系
$ git branch --track [branch] [remote-branch]
 
# 切换到指定分支，并更新工作区
$ git checkout [branch-name]
 
# 切换到上一个分支
$ git checkout -
 
# 建立追踪关系，在现有分支与指定的远程分支之间
$ git branch --set-upstream [branch] [remote-branch]
 
# 合并指定分支到当前分支
$ git merge [branch]
 
# 选择一个commit，合并进当前分支
$ git cherry-pick [commit]
 
# 删除分支
$ git branch -d [branch-name]
 
# 删除远程分支
$ git push origin --delete [branch-name]
$ git branch -dr [remote/branch]

```

### 7.4、提交本地代码修改到gitlab（开发日常）
#### 7.4.1、本地代码提交流程
本地开发流程如下图步骤，中间可能涉及到文件对比、代码冲突合并解决见其他场景
1. pull最新的远程代码
2. add本地修改的文件
3. commit到本地仓库
4. push到远程仓库

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121094814727.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)


#### 7.4.2、命令行方式提交

```bash
# 更新working directory
git pull

# 改动代码...此处省略2048个字

# 查看working tree状态
git status

# 比较改动前后，查看改动了什么 (用IDE来比较更加直观)
git diff <file>

# 添加新建的文件到Git Stage中
git add <file>

# 或添加全部新建的文件到Git Stage中
git add .

# 提交改动到local repository
git commit -m "<commit_message>"

# 推送到remote repository，创建remote new branch，并设置upstream reference
git push -u origin <new_branch>

# 如果第一次push时不通过-u 来push新的branch，在git pull时会提示要先设置upstream reference
# 设置upstream reference
git branch --set-upstream-to=origin/<branch> <branch>

#之后的push可以不需要再加-u参数：
git push origin <branch>


```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121094107966.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
#### 7.4.3、idea方式提交
1. 确认当前所在分支
2. pull远程最新代码到本地
3. 查看本地的local changes代码改动，和改动前做比对
4. 选中要提交的代码，右键点击commit
5. 进入commit的窗口，再次确认是否勾选刚刚勾选的文件
6. 也可以在这个窗口中进行文件对比，比local changes中对比更方便
7. 填写commit信息，尽量描述清楚本次修改点，以便bug修复跟踪和代码review或者回退
8. 去除勾选的右边代码分析之类的操作，加快提交速度
9. 下拉commit选项，选择commit and push，**即可完成提交**。（如果没有信心是否提交成功，或者只commit到本地了仓库了，那么可以去顶部菜单栏找到VCS-->Git->Push。点击push即可查看本地仓库未推送的提交记录，并点击推送），也可以去gitlab的项目页面去查看最新提交记录）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121100923693.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019112110101585.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121101906684.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
### 7.5、 增加/删除文件
7.5.1、命令行方式
```bash
 
# 添加指定文件到暂存区
$ git add [file1] [file2] ...
 
# 添加指定目录到暂存区，包括子目录
$ git add [dir]
 
# 添加当前目录的所有文件到暂存区
$ git add .
 
# 添加每个变化前，都会要求确认
# 对于同一个文件的多处变化，可以实现分次提交
$ git add -p
 
# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...
 
# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]
 
# 改名文件，并且将这个改名放入暂存区
$ git mv [file-original] [file-renamed]

```

7.5.2、idea的方式
- 直接常规操作复制到本项目即可，idea自动把文件添加到git的local changes中
- 删除同添加一样删除后在local changes中会变成灰色的文件

![在这里插入图片描述](https://img-blog.csdnimg.cn/2019112110344444.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
### 7.6、 本地新项目上传到git

7.6.1、（先进入项目文件夹）通过命令 git init 把这个目录变成git可以管理的仓库
```
git init
```
7.6.2、把文件添加到版本库中，使用命令 git add .添加到暂存区里面去，不要忘记后面的小数点“.”，意为添加文件夹下的所有文件
```
git add .
```
7.6.3、用命令 git commit告诉Git，把文件提交到仓库。引号内为提交说明

```
git commit -m "first commit"
```
6.6.4、关联到远程库
```
git remote add origin 你的远程库地址
如：
git remote add origin https://github.com/githubusername/demo.git
```
7.6.5、获取远程库与本地同步合并（如果远程库不为空必须做这一步，否则后面的提交会失败）

```
git pull --rebase origin master
```
7.6.6、把本地库的内容推送到远程，使用 git push命令，实际上是把当前分支master推送到远程。执行此命令后会要求输入用户名、密码，验证通过后即开始上传。

```
git push -u origin master
```
7.6.7、状态查询命令

```
git status
```

---

### 7.7、 配置.gitignore忽略提交文件
在项目根目录下创建.gitignore文件。.gitignore 文件内容如下

```bash
/.idea/
/target/
/log/
application-uat.yml
!.mvn/wrapper/maven-wrapper.jar

### STS ###
.apt_generated
.classpath
.factorypath
.project
.settings
.springBeans
.sts4-cache
.lst
### IntelliJ IDEA ###
.idea
*.iws
*.iml
*.ipr

### NetBeans ###
/nbproject/private/
/build/
/nbbuild/
/dist/
/nbdist/
/.nb-gradle/
```

在项目目录下执行该命令
```
git rm -r --cached .
git add .
git commit -m "update .gitignore"
```
### 7.8、 reset/revert版本回退
#### 7.8.1、reset/revert比对

假设有一次提交a文件前commit id 为 34719a7，提交的commit id为34719a8，接着又有人提交了b、c文件，提交的commit id为34719a9，如下表：
tag| commit id |  commit 的文件| 操作|
|-|-|-|-|
| | 34719a7|  |
 || 34719a8| a.java |把数据库地址从192变成了127|
 |head| 34719a9| b.java、c.java|b、c的查询db方法都改成查询redis，a地址变为localhost
 基于34719a9进行回退到34719a8

- revert：仅会把a文件回退到34719a8变更前的内容，其他文件不会变动，
即：34719a7提交后a文件=revert后的a文件，最终a的内容还是192。
- reset：回退到那次commit id=34719a8提交后的样子，后面的b、c文件也全盘回退，即34719a8 commit后项目内容=reset 到 34719a8项目内容，最终b、c还是查询db，a数据库地址为127。

如下表
操作|回退前commit id|回退版本commit id|操作前 | 操作后|
|:-|:-|:-|:-|:-|
 | revert|34719a9| 34719a8|a为127，b、c连接redis |a变为192，b、c的不变，查询redis|
 | reset|34719a9 |34719a8|a为127，b、c连接redis	|a变为127，b、c的变化，查询db方法

#### 7.8.2、版本回退
对于本次变动的回退，一般情况建议使用revert，以防使用reset把其他开发人员提交的代码给回退了。

7.8.2.1、在本地改动后，在git add 前回退，撤销本地改动：
```
git checkout -- <file>
```
推荐使用idea的revert功能，更加简单直观。
控制台-> local changes -> 右键 -> revert

7.8.2.2、在本地改动后，在git push 前回退，这里直接用远程覆盖可以直接用**reset**
用远程repository强制替换本地文件：
```
git fetch origin
git reset --hard origin/<branch>
```
推荐使用idea的reset功能，更加简单直观。
version control->log -> 右键选择最后一次提交-> Reset current branch to here -> select “Hard”

7.8.2.3、在本地改动后，在git push后回退
- 方法一：手工回退后，重新提交改动去覆盖remote branch。

- 方法二：使用idea的revert功能。**（推荐）**
version control ->log -> 右键点击revert -> 填写commit的message。
- 方法三：根据commit id 手动回退
方法三如下操作
```bash
#查看git commit log，复制要回退的版本commit id
git log --graph --oneline --decorate --all
#将本地回退到指定版本
git reset --hard <commit_id>


# 查看working tree状态，此时本地落后于远程1个commit
git status

# 强制用本地覆盖远程（危险操作！！）
git push -f origin <branch>

# 再次查看working tree状态，此时本地和远程应该同步
git status
```
推荐使用方法二

方法三比较危险，不推荐使用；强烈建议通过protect branch来防止强制用本地覆盖远程分支。

### 7.9、 查看文件修改历史

```bash
# 按树形结构显示
git log --graph --oneline --decorate --all [file]

# 按列表显示
git log --pretty=oneline [file]

# 简单粗暴显示
git log [file]
```
### 7.10、文件对比与解决冲突
#### 7.10.1、命令行文件对比

```bash
# 比较改动前后，查看改动了什么 (用idea来比较更加直观)
git diff <file>

# 显示暂存区和工作区的差异
$ git diff
 
# 显示暂存区和上一个commit的差异
$ git diff --cached [file]
 
# 显示工作区与当前分支最新commit之间的差异
$ git diff HEAD
 
# 显示两次提交之间的差异
$ git diff [first-branch]...[second-branch]
 
# 显示今天你写了多少行代码
$ git diff --shortstat "@{0 day ago}"
# 显示出所有有差异的文件列表
git diff branch1 branch2 --stat 

# 显示指定文件的详细差异
git diff branch1 branch2 具体文件路径

# 显示出所有有差异的文件的详细差异
git diff branch1 branch2                   
```

#### 7.10.2、idea中文件对比
如图可见，可以与历史版本或者其他分支的该文件进行对比，比命令行更加直观
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121141708503.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
#### 7.10.3、命令行解决文件冲突
7.10.3.1、发生冲突的文件
```
<<<<<<< HEAD
Creating a new branch is quick & simple.
=======
Creating a new branch is quick AND simple.
>>>>>>> feature1
```
其中，git使用<<<<<<<，=======，>>>>>>>标记文件中自己和别人产生冲突的部分。

在<<<<<<<，=======之间为自己的代码；
=======，>>>>>>>之间为别人的代码。

如果保留自己的代码，将别人的代码删掉即可。

7.10.3.2、冲突解决后提交

```bash
git status

git add ***

git commit -m "fix conflict"

git push origin 分支名
```
--- 
#### 7.10.4、idea解决文件冲突
产生冲突的场景
- accept yours:代表以自己的为准；

- accept theris:代表以更新下来的文件为准；

- merge:代表手动合并

- 一般解决冲突我们都是选择merge

将需要的内容点击：">>"既可以合并内容到result中，不需要的内容点击“x”即可，合并完成后点击apply即可。

值得注意的是，最将所有的“x >>”符号都要处理完，不需要的点击“x”,需要的点击“>>”
最后，不论是什么场景下产生的冲突解决方法是一样的。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121141254421.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121141405593.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
### 7.11、合并分支
#### 7.11.1、命令行合并
对于复杂的系统，我们可能要开好几个分支来开发，具体git合并操作如下

```bash
1、进入要合并的分支（如本地分支luo合并到develop，则进入develop目录）
git checkout develop
git pull

2、使用merge合并luo分支到develop
git merge luo

3、查看合并之后的状态
git status

4、有冲突的话，通过idea解决冲突，比命令行直观；

5、解决冲突之后，将冲突文件提交暂存区
git add 冲突文件

6、提交merge之后的结果
git commit

如果不是使用git commit -m "备注" ，那么git会自动将合并的结果作为备注，提交本地仓库；

7、本地仓库代码提交远程仓库
git push
```
将develop合并到开发者本地分支、开发分支合并到master操作相同，合并慎重，避免错误提交导致频繁回退的麻烦。
#### 7.11.2、idea合并
把2.1.0分支合并到master步骤
1、拉取最新代码
2、切换到master
3、如果有冲突或者其他异常，则再一次拉取代码，直到确保切换到最新的master
4、选择origin/2.1.0分支
5、点击merge into current。
6、如果有冲突，则文件比对解决冲突
7、完成了2.1.0合并到master的操作
8、push代码到远程仓库，选择vsc->git->push
9、完成
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121143848154.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121143802313.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191121144331474.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
## 八、代码review

- 代码审查，通过merge request。
- 审查代码是否满足功能、规范、测试结果、测试覆盖等等。
- 借助工具来提升代码审查的效率。
- 审查合格才允许合进public branch，不合格的代码退回重新修改。
- 鼓励使用同行评审（Peer Review）而不是上下级评审，鼓励积极反馈、互动。
--- 
## 九、参考文档

git flow
[https://nvie.com/posts/a-successful-git-branching-model/](https://nvie.com/posts/a-successful-git-branching-model/)
git版本控制、分支策略与代码评审
[https://blog.csdn.net/nklinsirui/article/details/80303605](https://blog.csdn.net/nklinsirui/article/details/80303605)
常用git命令
[https://blog.csdn.net/web_csdn_share/article/details/79243308](https://blog.csdn.net/web_csdn_share/article/details/79243308)
idea中的解决git文件冲突
[https://www.cnblogs.com/newAndHui/p/10851807.html](https://www.cnblogs.com/newAndHui/p/10851807.html)
git操作
[https://segmentfault.com/a/1190000014461898](https://segmentfault.com/a/1190000014461898)
其他
[https://www.cnblogs.com/hezhiying/p/9292314.html](https://www.cnblogs.com/hezhiying/p/9292314.html)
[https://www.cnblogs.com/aylin/p/6042653.html](https://www.cnblogs.com/aylin/p/6042653.html)
[https://www.jianshu.com/p/c2aefcf6b2b7](https://www.jianshu.com/p/c2aefcf6b2b7)
[https://www.cnblogs.com/Gaoqiking/p/11116380.html](https://www.cnblogs.com/Gaoqiking/p/11116380.html)
[https://www.jianshu.com/p/1889b0fe073b](https://www.jianshu.com/p/1889b0fe073b)




