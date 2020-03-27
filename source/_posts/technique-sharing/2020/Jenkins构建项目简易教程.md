---
title: Jenkins构建项目简易教程
date: 2020-03-26 17:03:22
author: 罗三
tags:
- jenkins
- node
- git
---
## 一、背景

- 需要使用自动化构建工具jenkins构建项目到应用服务器，项目分前端后端。
- 前端使用npm构建的vue项目，后端是使用maven的springboot项目。

除了安装jenkins外，还需要额外安装tomcat、maven、jdk、git、npm。

附言：一年前我搭建时候也写过一篇，但是安装包比较零散，所以重新搭建构建系统的时候我才重新写了这篇。一年前的帖子也可以参考看看
超全git+tomcat+jenkins实现自动化构建部署教程[https://blog.csdn.net/u011456337/article/details/89303647](https://blog.csdn.net/u011456337/article/details/89303647)
<!-- more -->

## 二、安装包
步骤三四需要用的安装包较多，单独去找如果怕麻烦的话可以直接用百度云里面的这些，包含jenkins、maven、maven配置文件、jdk、git。
![](/images/20191202105632194.png)
链接：[https://pan.baidu.com/s/1wH5bx3QO4SZRi7fVqFolsA](https://pan.baidu.com/s/1wH5bx3QO4SZRi7fVqFolsA) 
提取码：7z2t 
## 三、安装java环境
**下面的工具已安装的可以跳过**

当前软件下载位置：/opt/soft/,进入该位置
### 3.1、安装jdk
安装包使用百度云下载的或者进入下载[https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
```bash
# 解压
tar -zxvf jdk-8u144-linux-x64.tar.gz
# 移动位置
mv jdk1.8.0_144/ /usr/local/java
# 配置环境变量
vi /etc/profile
# 文件末尾添加环境变量
export JAVA_HOME=/usr/local/java
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JRE_HOME=$JAVA_HOME/jre

# 使配置生效
source /etc/profile   
# 测试是否安装成功
java -version

```

### 3.2、安装tomcat

使用百度云安装包或者直接
wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.39/bin/apache-tomcat-8.5.39.tar.gz
```bash
# 解压
tar -zxvf apache-tomcat-8.5.39.tar.gz
# 创建目录
mkdir /usr/local/tomcat
# 移动
mv apache-tomcat-8.5.39 /usr/local/tomcat/
```
可选操作-修改tomcat端口并启动测试能够访问

![](/images/20191202115009288.png)

### 3.3、安装maven
使用百度云解压包或者下载maven安装包
wget [http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz](http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz)

```bash 

# 解压
tar -zxvf apache-maven-3.5.4-bin.tar.gz 
# 可以解压到/usr/local/maven,这里我的直接用了soft下面的安装包略过了该步
# 配置环境变量
vi /etc/profile
# 文件末尾添加环境变量
export MAVEN_HOME=/opt/soft/maven/apache-maven-3.5.4
export MAVEN_HOME
export PATH=$PATH:$MAVEN_HOME/bin 

# 使配置生效
source /etc/profile      
# 测试是否安装成功
mvn -v
# 默认的仓库比较慢，可以配置阿里云和华为云的中央仓库，直接看步骤二下载的setting.xml，可以直接粘贴进去或者参考

```

### 3.4、安装git
**提示**：安装git经常会遇到一些错误
使用百度云的解压包或者额外下载 [https://www.kernel.org/pub/software/scm/git](https://www.kernel.org/pub/software/scm/git)
```bash
# 解压
tar -zxvf git-2.9.5.tar.gz
# 进去解压后目录执行，
./configure  --prefix=/usr/local/git
make && make install
# 前两步如果有遇到错，要么直接百度，要么就是缺少一些包，下面给出一些常见报错依赖度的环境
yum install curl-devel
yum install zlib
yum install zlib-devel
yum install perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
yum install curl-devel

#测试是否安装成功
git --version

```
### 3.5、安装npm

进入jenkins插件中心安装nodejs，接着去系统设置→系统设置（全局设置）>找到npm，配置如下
进入jenkins插件中心安装nodejs，接着去系统设置→系统设置（全局设置）>找到npm，配置如下

![](/images/20191204175909595.png)


## 三、安装jenkins
 ### 3.1、安装jenkins
3.1.1、版本选择：2.164.1。
3.1.2、下载各个版本地址：[https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/](https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/)

3.1.3、安装方式：不用yum安装，使用tomcat容器部署jenkins，方便修改工作空间。

```
# 使用百度云提供的war包或者自行下载
wget https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/2.164.1/jenkins.war
# 移动war文件到tomcat下
mv jenkins.war /usr/local/tomcat/apache-tomcat-8.5.49/webapps
```
3.1.4、启动：直接启动tomcat方式即可启动jenkins
3.1.5、验证是否成功，访问Jenkins，http://IP地址:8080/jenkins/




 
 ### 3.2、配置初始页
3.2.1、这里有一个临时密码需要输入，在/home/tomcat/.jenkins/secrets/initialAdminPassword里面
![](/images/20191202143714163.png)
3.2.2、选择第二个，select plugin to install，这里其实不安装东西也没关系，进去主页面之后再去安装插件即可，确认
![](/images/20191202143733163.png)
 3.2.3、创建用户名密码![](/images/20191202143858955.png)
 3.2.4、进入主页
 ![](/images/20191202144007199.png)
 
 ### 3.3、插件、凭据、工具配置
 
 
1、插件安装：系统管理->插件管理>搜索过滤插件->安装
 当前需要安装的插件有：
- Git
- Git Parameter Plug-In
- GitLab Plugin
- Maven Integration plugin
- Publish Over SSH

2、凭据配置：选择凭据->系统->添加域，输入一个域名或者ip
 ![](/images/20191202145904197.png)
 点击添加一些凭据
 	![](/images/20191202150035710.png)
 添加之后账户密码信息之后保存
 ![](/images/20191202150105566.png)
 3、ssh scp 配置
系统管理->系统设置 ssh server 配置：
如果用的是统一的key或者密码，则配置一次就可以了。
如果每个服务器密码都不一样，需要点击高级按钮，把
复选框 Use password authentication, or use a different key 勾选上就行了。
- Passphrase                服务器的密码
- Path to key                  连接远程服务器密钥文件的路径
- Key                             密钥文件的内容 
- Name                         自定义服务器名
- HostName                  服务器IP外网地址
- UserName                  服务器用户名
- Remote Directory     传输文件的目录

![](/images/20191202154305682.png)
4、配置本地maven、jdk、git
maven，jdk，git、这些尽量使用本地配置
如下图
![](/images/20191202150756711.png)
![](/images/20191202150837714.png)
## 四、新建maven项目
4.1、新建选择新建一个maven项目，如果没有安装Maven Integration plugin插件，则不会出现该item。

![](/images/20191202152253689.png)
4.2、配置多条件分支参数
![](/images/20191202152418545.png)
4.3、选择git项目，选择凭据，指定分支（为空时代表any）	填写上面配置的分支参数myBranch（如果Repository URL报http错，则是http不被git支持，需要进去git目录 yum install curl-devel 安装后重新执行上面步骤3.4中的git两条编译配置命令）。

![](/images/20191202152646954.png)
4.4、构建前删除源文件和编译文件
![](/images/20191212171944159.png)选择pom.xml
![](/images/20191202153134627.png)
4.5、后置操作步骤选下拉框中的【Send files or execute commands over SSH】接着进行配置。
- Source files     项目构建后的目录
- Remove prefix    去前缀
- Remote directoty 发布的目录
- Exec command     发布完执行的命令
![](/images/20191202153239497.png)

4.6、确认构建后启动脚本是否有误

```handlebars
#! /bin/bash


echo "构建完成"
echo "停止java进程"

ps -aux | grep java|grep soso-admin| awk '{print $2}' | while read pid
do
    echo "正在杀死进程，pid=$pid"
    kill -9 $pid
    echo "kill result: $?"
done

cd /opt/project/java/soso

ls -lht

nohup java -jar soso-admin.jar -spring.profiles.active=sit > nohup.out 2>&1 &

echo "启动中"

```

![](/images/20191202154922464.png)
4.7、尝试构建
选择build with parameter
![](/images/20191202155049290.png)
选择需要构建的分支之后构建进度如下，接着点击进度条进入构建日志详情查看具体信息
![](/images/20191202155103139.png)
如下图所示则构建成功，直接进去看应用启动日志或者直接访问应用的url地址
![](/images/20191202162336106.png)
## 五、常见问题
-  ssh发送文件到远程服务器报错，一般是因为设置路径不对，可能是远程服务器设置路径，或者发送位置不正确，一般有下面两种配置错误
1、系统管理->系统设置->Publish over SSH->Remote Directory	>设置默认远程服务器根目录 /
2、构建配置中Send build artifacts over SSH->Remote directory ，为文件发送远程目标目录（相对路径）
结合1、2，最终发送文件位置是【根目录+相对路径】


可以直接在远程服务器执行如：find / -name  soso-admin.jar查找文件位置，解决路径错误

 - 遇到一些git问题可以根据具体的报错百度
 - 遇到jenkins的自己的页面没有下拉选项应该少安装了插件，需要去安装插件。
 - 修改jenkins工作空间workspace需要自行百度
## 六、构建npm前端项目简述
### 6.1.1、前端npm项目构建
1、构建一个自由风格的项目
2、【源码管理】选择git版本和分支选择同前面maven的一致
3、接下来就不一样了，
4、【构建环境】选择 Provide Node & npm bin/ folder to PATH
![](/images/20191204173751542.png)
5、构建shell

```bash
cd /var/lib/jenkins/workspace/intelligence-web
npm install -g cnpm --registry=https://registry.npm.taobao.org
rm -rf intelligence
rm -rf intelligence-web
rm -rf intelligence-web.tar.gz
cnpm install
npm run build
mv intelligence intelligence-web
tar -zcvf intelligence-web.tar.gz intelligence-web
```
6、构建后文件发送到应用服务器
![](/images/20191204174049871.png)
## 七、克隆方式创建新项目
选择构建自由风格的项目→copy from 已有项目->点击保存即可，接着按照自己需要修改版本git地址和脚本配置
![](/images/20191204180530298.png)
## 八、参考
超全git+tomcat+jenkins实现自动化构建部署教程[https://blog.csdn.net/u011456337/article/details/89303647](https://blog.csdn.net/u011456337/article/details/89303647)
Jenkins自动构建部署项目到远程服务器上
[https://blog.csdn.net/ming19951224/article/details/80958761](https://blog.csdn.net/ming19951224/article/details/80958761)
jenkins配置，一键打包,备份，部署多服务器，多环境启动
[https://blog.csdn.net/li740207611/article/details/84261430](https://blog.csdn.net/li740207611/article/details/84261430)
基于gitlab和jenkins的自动化部署实例
[https://blog.csdn.net/aaaaaab_/article/details/82012044](https://blog.csdn.net/aaaaaab_/article/details/82012044)
Jenkins自动化构建vue项目然后发布到远程Linux服务器
[https://www.cnblogs.com/djlsunshine/p/11059690.html](https://www.cnblogs.com/djlsunshine/p/11059690.html)
