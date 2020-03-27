---
title: 生产java.io.IOException Too many open files排查过程和解决方案
date: 2020-03-26 17:05:47
author: 罗三

tags:
- java
---
## 一、背景
2020-03-23 08:10:07生产突然系统异常。
在系统重新之后恢复暂时恢复使用。一个比较诡异的错误，经过一番排查，最终才定位到问题代码，错误如下：

```bash
2020-03-20 08:10:07.039 [http-nio-8050-Acceptor-0] ERROR org.apache.tomcat.util.net.Acceptor - Socket accept failed
java.io.IOException: Too many open files
	at sun.nio.ch.ServerSocketChannelImpl.accept0(Native Method)
	at sun.nio.ch.ServerSocketChannelImpl.accept(ServerSocketChannelImpl.java:422)
	at sun.nio.ch.ServerSocketChannelImpl.accept(ServerSocketChannelImpl.java:250)
	at org.apache.tomcat.util.net.NioEndpoint.serverSocketAccept(NioEndpoint.java:446)
	at org.apache.tomcat.util.net.NioEndpoint.serverSocketAccept(NioEndpoint.java:70)
	at org.apache.tomcat.util.net.Acceptor.run(Acceptor.java:95)
	at java.lang.Thread.run(Thread.java:748)
```

<!-- more -->


## 二、第一波排查
### 1、问题持续时间
8:10 - 8：25

### 2、错误日志
第一次出现错误是在

```handlebars
2020-03-20 08:10:07.039 ITGC [http-nio-8050-Acceptor-0] ERROR org.apache.tomcat.util.net.Acceptor - Socket accept failed
java.io.IOException: Too many open files
```

![](/images/20200323100419479.png)


### 3、tcp连接数
8:10:07的时候tcp连接数也是不多的，在200左右非常小，已经过了访问高峰

```handlebars
netstat -nat|grep -i "8050"|wc -l

2020-03-20 08:10:05
169
2020-03-20 08:10:07
177
2020-03-20 08:10:09
184
2020-03-20 08:10:11
188
2020-03-20 08:10:13
199
```
### 4、句柄打开数
 对于打开的句柄发现大量未成功释放的文件

```bash
查看进程打开的资源情况
ls -l /proc/13544/fd/
发现有大量tmpip.db未释放
查看进程打开的tmpip.db 的数量
ls -l /proc/13544/fd/ | grep tmpip.db |wc -l
ls -l /proc/13544/fd/ | grep tmpip.db 
```

  ![](/images/20200323094839824.png)
附上：
查看进程打卡的各个资源数量排序前八位
```bash
lsof -p 13544 |awk '{print $9}'| sort|uniq -c |sort -nr | head -n 8
```
### 5、 分析
目前除了重启应用解决外，具体原因还未确认

1、当时的打卡人数每分钟不超过20人。

2、对于tcp连接是有记录实时日志的，连接数不到200。

3、对于当前打开文件数量是没有记录的。13544是进程pid，可以 ps -ef |grep java 查看或者直接 jps 查看。

```bash

 ls -l /proc/13544/fd/  | wc -l 
 
 ```

4、Linux的文件句柄数设置是正常的。ulimit –n 是65534
5、根据上面步骤4，看得出有大量未释放的。

### 6、结论
因为持续了很多天没有发布重启过应用，在累计几周的情况下。应用突然崩溃。

1、打开的文件数没有做日志记录。在文件打开关闭有问题上面不排除有异常，因为lsof查看到每天有打开/tmpip.db文件但是一直未正确关闭，导致累计。

2、属于累计达到一定量之后崩溃的系统，那么在jvm上面也不排除有堆栈异常导致。

3、其他异常也正在排查

 

## 三、第二波排查
### 1、分析
根据以上结论进行第二波：
首先针对最多未释放的资源tmpip.db进行排查，因为代码里面日志记录代码有使用该文件。每次打卡都会插入日志，日志里面记录ip地址解析对应的中文地址会使用 tmpip.db，接着进行排查。

查看每个用户允许打开的最大文件数  ulimit -a 或者 ulimit -n 查看
open files                      (-n) 65534 

```bash

65534
[root@CN07ATT01NGX01V ~]#  ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 14996
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 65534  
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 14996
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

open files       (-n) 65534


```

查看系统允许打开的最大文件数 cat /proc/sys/fs/file-max

```bash
root@CN07ATT01NGX01V ~]# cat /proc/sys/fs/file-max
379184
[root@CN07ATT01NGX01V ~]# 
```

基于这个问题是日积月累之后突然爆发的，于是对比中午打卡和下午打卡人数和未释放的文件句柄数对比，发现基本是能对应的上的。

截止2020-03-20 19:24分

```bash
中午打卡日志数量 334条
下午打卡日志数量 530条
中午打卡后
[root@CN07ATT01NGX01V ~]# ls -l /proc/13544/fd/ | wc -l
835
下午打卡后
[root@CN07ATT01NGX01V ~]# ls -l /proc/13544/fd/ | wc -l
1368
```
相差1368-835=533

可见，未释放的资源几乎是和打卡日志相同数量递增的，
接着从今天出现问题前的最后一次启动，到今天出现问题时候启动时间段内，把日志做了一次查询统计：

```bash
select count(1) from t_log where  create_time>"2020-03-03 21:29:00" and create_time<="2020-03-20 08:10:07"  order by create_time desc
```

![](/images/20200323094542768.png)

如上图，启动后一共产生打卡日志64001条。

每个用户允许打开的最大文件数65534

差额为65534-64001 =1533个文件打开数。

 

### 2、结论
因此结论一时正确的，附上具体结论内容：

[root@CN07ATT01NGX01V ~]# ls -l /proc/13544/fd

/tmpip.db的资源占用未及时释放导致系统的文件句柄数量越来越大。在今天超出。报异常

java.io.IOException: Too many open files


### 3、解决
1、日志方法记录ip的时候调用了AddressUtil的getCityInfo(String ip)
根据传入去得到对应的中文地址，内部逻辑使用了tmpip.db。因此针对这部分代码进行核查。看是否有未释放，果然对于dbsearch使用之后是没有释放的，于是添加dbSearch.close方法进行关闭资源。
![](/images/20200323102106440.png)
2、在代码修改前，我们先在测试系统也还原到了这个问题，添加释放方法之后，资源释放问题得以解决！


## 四、参考文献
java.io.IOException: Too many open files问题常用命令[https://blog.csdn.net/liyuguanguan/article/details/90716709](https://blog.csdn.net/liyuguanguan/article/details/90716709)
对于高并发的产生：java.io.IOException: Too many open files(打开文件句柄过多问题) 
[https://my.oschina.net/czpdjx/blog/2980869](https://my.oschina.net/czpdjx/blog/2980869)
java.io.IOException: Too many open files问题
[https://blog.csdn.net/liyuguanguan/article/details/90716709](https://blog.csdn.net/liyuguanguan/article/details/90716709)
linux进程数和句柄数
[https://blog.csdn.net/Poetic_Vienna/article/details/87621371?depth_1-utm_source=distribute.pc_relevant.none-task&utm_source=distribute.pc_relevant.none-task](https://blog.csdn.net/Poetic_Vienna/article/details/87621371?depth_1-utm_source=distribute.pc_relevant.none-task&utm_source=distribute.pc_relevant.none-task)


