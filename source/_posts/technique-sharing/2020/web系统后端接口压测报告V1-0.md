---
title: web系统后端接口压测报告V1.0
date: 2020-03-26 17:04:47
author: 罗三
tags:
---

------
### 一、测试目的
针对uat环境的用户并发量和系统瓶颈，都是未知的。
本轮压力测试，抽取部分代表性查询接口，主要是为了测试后台系统UAT环境主要接口吞吐量和响应时间，初步找出系统的瓶颈。

### 二、测试内容
压测接口清单

 -  api/nonmetalPla/list（pla(post)）	
 -  api/warehouse/searchCarType	（查询基础数据(post)	）
 -  api/dict/findDictByParentCode	（根据父类编码查询下级字典(post)	）
 - 压测数据库查询m_dict数据	（jdbc连接	）

### 三、测试环境

| 环境 | 机器型号|CPU|操作系统|内存|磁盘|
| --------   |--------   | --------   | --------   | --------   |  -----:  |
| 应用服务器 | linux虚拟机|CPUIntel(R) Xeon(R) Gold 6132 CPU @ 2.60GHz<br>4个单核四线程|CentOS Linux release 7.5.1804 (Core) 单机 |total：8G ，可用内存： free+buffers/cached = 2.3G|tatal：26G used：15G  |
| 压测机器 |宏碁4750|单个双核四线程|win10 单机|8G|total:8G used:3G|

<!-- more -->


### 四、测试方法
#### 4.1、压测工具和指标
| 类别        | 说明   |
| --------   | -----  |
| 压测工具 | apache-jmeter-5.1.1（单台win环境） |
| 压测性能相关参数  |协议: http <br>方法: get/post<br>并发数 、总请求数、吞吐率(TPS)、响应时间、错误率 <br> | 
#### 4.2、测试时间
第一轮压测：
测试时间：9:00-12:00（工作时间） ，内网环境压测（**VPN内网，非完全内网**）
针对每个接口分别执行并发数10、30、90、270并发数执行120秒
第二轮压测：
测试时间：7:50-09:30（工作时间） ，内网环境压测（**VPN内网，非完全内网**）
针对每个接口分别执行并发数10、30、90、270并发数执行120秒
第三轮压测：
测试时间：09:00-09:30（工作时间） ，内网环境压测（**VPN内网，非完全内网**）
针对pla接口30并发数执行120秒


#### 五、统计指标

进行压力测试，并对产生的每秒TPS，响应时间（min，ave，max）及错误率进行统计

### 六、测试结果


#### 6.1、第一轮压测
时间：9:00-12:00（工作时间）
##### 6.1.1、聚合报告

<table>
   <tr>
      <td>接口名称</td>
      <td>数据量</td>
      <td>并发数</td>
      <td>持续时间</td>
      <td>samples</td>
      <td>average</td>
      <td>min</td>
      <td>max</td>
      <td>median</td>
      <td>90%Line</td>
      <td>95%Line</td>
      <td>99%Line</td>
      <td>error%</td>
      <td>tps(s)</td>
      <td>received(kb/s)</td>
      <td>sent(kb/s)</td>
   </tr>
   <tr>
      <td>pla(post)</td>
      <td>limit 10</td>
      <td></td>
      <td>120s</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td></td>
      <td>10</td>
      <td></td>
      <td>5113</td>
      <td>233</td>
      <td>73</td>
      <td>2458</td>
      <td>191</td>
      <td>345</td>
      <td>408</td>
      <td>827</td>
      <td>0</td>
      <td>42.41921434</td>
      <td>1672.45209</td>
      <td>21.91383241</td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td></td>
      <td>30</td>
      <td></td>
      <td>5323</td>
      <td>673</td>
      <td>146</td>
      <td>8692</td>
      <td>543</td>
      <td>1196</td>
      <td>1561</td>
      <td>2619</td>
      <td>0</td>
      <td>43.96775313</td>
      <td>1733.505954</td>
      <td>22.71380996</td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td></td>
      <td>90</td>
      <td></td>
      <td>6224</td>
      <td>1737</td>
      <td>161</td>
      <td>26447</td>
      <td>1262</td>
      <td>3238</td>
      <td>4445</td>
      <td>8283</td>
      <td>0</td>
      <td>49.34982556</td>
      <td>1945.703621</td>
      <td>25.49419699</td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td></td>
      <td>270</td>
      <td></td>
      <td>7586</td>
      <td>4298</td>
      <td>155</td>
      <td>44290</td>
      <td>3359</td>
      <td>7611</td>
      <td>9445</td>
      <td>15606</td>
      <td>0</td>
      <td>59.22213375</td>
      <td>2334.936724</td>
      <td>30.59424683</td>
   </tr>
   <tr>
      <td>查询基础数据(post)</td>
      <td>limit 10</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>/api/warehouse/searchCarType</td>
      <td></td>
      <td>10</td>
      <td></td>
      <td>2602</td>
      <td>459</td>
      <td>113</td>
      <td>3458</td>
      <td>393</td>
      <td>692</td>
      <td>937</td>
      <td>1496</td>
      <td>0</td>
      <td>21.5274388</td>
      <td>1078.600366</td>
      <td>11.28929163</td>
   </tr>
   <tr>
      <td>/api/warehouse/searchCarType</td>
      <td></td>
      <td>30</td>
      <td></td>
      <td>4456</td>
      <td>805</td>
      <td>105</td>
      <td>7980</td>
      <td>670</td>
      <td>1369</td>
      <td>1712</td>
      <td>2686</td>
      <td>0</td>
      <td>36.9694355</td>
      <td>1852.298689</td>
      <td>19.38729186</td>
   </tr>
   <tr>
      <td>/api/warehouse/searchCarType</td>
      <td></td>
      <td>90</td>
      <td></td>
      <td>5044</td>
      <td>2150</td>
      <td>172</td>
      <td>11822</td>
      <td>1781</td>
      <td>3441</td>
      <td>4277</td>
      <td>6622</td>
      <td>0</td>
      <td>41.092654</td>
      <td>2058.886432</td>
      <td>21.54956562</td>
   </tr>
   <tr>
      <td>/api/warehouse/searchCarType</td>
      <td></td>
      <td>270</td>
      <td></td>
      <td>6504</td>
      <td>5022</td>
      <td>154</td>
      <td>79084</td>
      <td>3997</td>
      <td>8100</td>
      <td>10222</td>
      <td>17749</td>
      <td>0</td>
      <td>51.1437356</td>
      <td>2562.480956</td>
      <td>26.82049416</td>
   </tr>
   <tr>
      <td>根据父类编码查询下级字典(post)</td>
      <td>limit 10</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>/api/dict/findDictByParentCode</td>
      <td></td>
      <td>10</td>
      <td></td>
      <td>652</td>
      <td>1842</td>
      <td>225</td>
      <td>12681</td>
      <td>1505</td>
      <td>2617</td>
      <td>5084</td>
      <td>6542</td>
      <td>0</td>
      <td>5.201643464</td>
      <td>3.682313378</td>
      <td>2.722735251</td>
   </tr>
   <tr>
      <td>/api/dict/findDictByParentCode</td>
      <td></td>
      <td>30</td>
      <td></td>
      <td>1942</td>
      <td>1861</td>
      <td>267</td>
      <td>11447</td>
      <td>1489</td>
      <td>3467</td>
      <td>4896</td>
      <td>6968</td>
      <td>0</td>
      <td>15.58337346</td>
      <td>10.10484372</td>
      <td>8.156922043</td>
   </tr>
   <tr>
      <td>/api/dict/findDictByParentCode</td>
      <td></td>
      <td>90</td>
      <td></td>
      <td>5464</td>
      <td>1986</td>
      <td>284</td>
      <td>23215</td>
      <td>1604</td>
      <td>2840</td>
      <td>5219</td>
      <td>6941</td>
      <td>0</td>
      <td>43.72669217</td>
      <td>28.97468862</td>
      <td>22.88819043</td>
   </tr>
   <tr>
      <td>/api/dict/findDictByParentCode</td>
      <td></td>
      <td>270</td>
      <td></td>
      <td>16931</td>
      <td>1921</td>
      <td>72</td>
      <td>14632</td>
      <td>1505</td>
      <td>3356</td>
      <td>5021</td>
      <td>6597</td>
      <td>1.07</td>
      <td>131.6268411</td>
      <td>88.65045632</td>
      <td>68.13092412</td>
   </tr>
   <tr>
      <td>jdbc连接</td>
      <td>limit 10</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>压测数据库查询m_dict数据</td>
      <td></td>
      <td>10</td>
      <td></td>
      <td>17390</td>
      <td>66</td>
      <td>10</td>
      <td>13343</td>
      <td>40</td>
      <td>116</td>
      <td>179</td>
      <td>312</td>
      <td>0</td>
      <td>145.2</td>
      <td>145.46</td>
      <td>0</td>
   </tr>
   <tr>
      <td>压测数据库查询m_dict数据</td>
      <td></td>
      <td>30</td>
      <td></td>
      <td>18909</td>
      <td>181</td>
      <td>10</td>
      <td>8165</td>
      <td>118</td>
      <td>351</td>
      <td>474</td>
      <td>845</td>
      <td>0</td>
      <td>157.5</td>
      <td>157.78</td>
      <td>0</td>
   </tr>
   <tr>
      <td>压测数据库查询m_dict数据</td>
      <td></td>
      <td>90</td>
      <td></td>
      <td>15052</td>
      <td>709</td>
      <td>13</td>
      <td>12010</td>
      <td>538</td>
      <td>1106</td>
      <td>1566</td>
      <td>6648</td>
      <td>0.48</td>
      <td>125.1</td>
      <td>124.78</td>
      <td>0</td>
   </tr>
   <tr>
      <td>压测数据库查询m_dict数据</td>
      <td></td>
      <td>270</td>
      <td></td>
      <td>19391</td>
      <td>1681</td>
      <td>13</td>
      <td>10848</td>
      <td>1517</td>
      <td>2593</td>
      <td>3232</td>
      <td>7707</td>
      <td>0</td>
      <td>158.1647635</td>
      <td>158.47</td>
      <td>0</td>
   </tr>

</table>

##### 6.1.2、接口压测实况图（90并发）
下面抽取并发量为90的情况下各个测试接口的资源情况，分别是内存和cpu状况图、响应时间、tps
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113234912948.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113234957571.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)


一、api/nonmetalPla/list((post)）

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235056332.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235109271.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235117777.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
二、/api/warehouse/searchCarType （查询基础数据(post) ）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235151972.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235157418.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235210655.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
三、/ api/dict/findDictByParentCode （根据父类编码查询下级字典(post) ）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235239301.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019111323524764.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235258683.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
四、压测数据库查询m_dict数据 （jdbc连接 ）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235443992.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235327335.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191113235344162.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)

##### 6.1.3、第一轮压测分析

- 带宽、内存、内存、磁盘等指标在网页查看一直表现的比较正常，在命令行直接进去服务器查看，cpu有超过100%的几次状况。
- 并发数在90以内时，接口响应时间基本能保证在2s内
- 普通数据库查询接口tps有提升空间，pla接口在10-270的并发下均能保持40tps以上
- warehouse查询(post)	接口相比pla接口仍较慢，可做进一步优化，考虑字段过多，sql查询方面的问题
- 根据父类编码查询下级字典(post)接口耗时非常严重，需要比较优先优化，考虑索引和sql方面的问题
- 数据库压测tps只有120-150左右，需要进一步提高，考虑服务器性能方面和mysql配置问题，在非工作时间有尝试压测
- 对于接口耗时较长的情况，目前引入了redis，但是目前用的地方很少，redis几乎闲置，接口可以考虑结合使用redis

 
 一次压测数据不一定是准确的，有主要以下几点
 - 服务器网络变化
 - 服务器性能改变
 - 压测主机网络变化
 - DB数据量的变化
 - 压测过程中部分请求 error / 超时影响 
 

#### 6.2、第二轮压测
压测时间：07:50-9:30（工作时间）
##### 6.2.1、聚合报告
<table>
   <tr>
      <td>接口名称</td>
      <td>数据量</td>
      <td>并发数</td>
      <td>持续时间</td>
      <td></td>
      <td>samples</td>
      <td>average</td>
      <td>min</td>
      <td>max</td>
      <td>median</td>
      <td>90%Line</td>
      <td>95%Line</td>
      <td>99%Line</td>
      <td>error%</td>
      <td>tps(s)</td>
      <td>received(kb/s)</td>
      <td>sent(kb/s)</td>
   </tr>
   <tr>
      <td>pla(post)</td>
      <td>limit 10</td>
      <td></td>
      <td>120s</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td></td>
      <td>10</td>
      <td></td>
      <td>TOTAL</td>
      <td>4038</td>
      <td>296</td>
      <td>95</td>
      <td>9299</td>
      <td>233</td>
      <td>496</td>
      <td>630</td>
      <td>934</td>
      <td>0</td>
      <td>33.49841965</td>
      <td>1330.286362</td>
      <td>17.30533593</td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td></td>
      <td>30</td>
      <td></td>
      <td>TOTAL</td>
      <td>5134</td>
      <td>698</td>
      <td>76</td>
      <td>7882</td>
      <td>602</td>
      <td>921</td>
      <td>1107</td>
      <td>3601</td>
      <td>0</td>
      <td>42.68835175</td>
      <td>1695.236156</td>
      <td>22.05286921</td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td></td>
      <td>90</td>
      <td></td>
      <td>TOTAL</td>
      <td>5830</td>
      <td>1873</td>
      <td>157</td>
      <td>12518</td>
      <td>1717</td>
      <td>2293</td>
      <td>3515</td>
      <td>5551</td>
      <td>0</td>
      <td>47.52472019</td>
      <td>1887.297604</td>
      <td>24.55134471</td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td></td>
      <td>270</td>
      <td></td>
      <td>TOTAL</td>
      <td>5130</td>
      <td>6483</td>
      <td>459</td>
      <td>26515</td>
      <td>5727</td>
      <td>10125</td>
      <td>11911</td>
      <td>16345</td>
      <td>0</td>
      <td>40.1323664</td>
      <td>1593.733086</td>
      <td>20.73244319</td>
   </tr>
   <tr>
      <td>basedata(post)</td>
      <td>limit 10</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>/api/warehouse/searchCarType</td>
      <td></td>
      <td>10</td>
      <td></td>
      <td>TOTAL</td>
      <td>4272</td>
      <td>451</td>
      <td>94</td>
      <td>17898</td>
      <td>426</td>
      <td>615</td>
      <td>676</td>
      <td>853</td>
      <td>0.002340824</td>
      <td>22.09544695</td>
      <td>2040.372722</td>
      <td>11.56003959</td>
   </tr>
   <tr>
      <td>/api/warehouse/searchCarType</td>
      <td></td>
      <td>30</td>
      <td></td>
      <td>TOTAL</td>
      <td>3028</td>
      <td>1186</td>
      <td>187</td>
      <td>4492</td>
      <td>1120</td>
      <td>1586</td>
      <td>1807</td>
      <td>2567</td>
      <td>0</td>
      <td>25.12883924</td>
      <td>2325.840943</td>
      <td>13.17791667</td>
   </tr>
   <tr>
      <td>/api/warehouse/searchCarType</td>
      <td></td>
      <td>90</td>
      <td></td>
      <td>TOTAL</td>
      <td>2146</td>
      <td>5096</td>
      <td>264</td>
      <td>37961</td>
      <td>3563</td>
      <td>10678</td>
      <td>14950</td>
      <td>24020</td>
      <td>0</td>
      <td>16.60528026</td>
      <td>1536.928958</td>
      <td>8.708042481</td>
   </tr>
   <tr>
      <td>/api/warehouse/searchCarType</td>
      <td></td>
      <td>270</td>
      <td></td>
      <td>TOTAL</td>
      <td>2916</td>
      <td>11779</td>
      <td>257</td>
      <td>55320</td>
      <td>10512</td>
      <td>17029</td>
      <td>20018</td>
      <td>27637</td>
      <td>0</td>
      <td>21.09649694</td>
      <td>1952.620886</td>
      <td>11.06329966</td>
   </tr>
   <tr>
      <td>根据父类编码查询下级字典(post)</td>
      <td>limit 10</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>/api/dict/findDictByParentCode</td>
      <td></td>
      <td>10</td>
      <td></td>
      <td>TOTAL</td>
      <td>31344</td>
      <td>37</td>
      <td>19</td>
      <td>3256</td>
      <td>28</td>
      <td>37</td>
      <td>56</td>
      <td>245</td>
      <td>0</td>
      <td>261.1586499</td>
      <td>392.5030881</td>
      <td>136.7002308</td>
   </tr>
   <tr>
      <td>/api/dict/findDictByParentCode</td>
      <td></td>
      <td>30</td>
      <td></td>
      <td>TOTAL</td>
      <td>69339</td>
      <td>51</td>
      <td>21</td>
      <td>7120</td>
      <td>42</td>
      <td>58</td>
      <td>132</td>
      <td>215</td>
      <td>0</td>
      <td>577.6083969</td>
      <td>868.1048074</td>
      <td>302.3418952</td>
   </tr>
   <tr>
      <td>/api/dict/findDictByParentCode</td>
      <td></td>
      <td>90</td>
      <td></td>
      <td>TOTAL</td>
      <td>87335</td>
      <td>122</td>
      <td>22</td>
      <td>14538</td>
      <td>94</td>
      <td>219</td>
      <td>274</td>
      <td>500</td>
      <td>0</td>
      <td>727.2886254</td>
      <td>1093.063666</td>
      <td>380.6901398</td>
   </tr>
   <tr>
      <td>/api/dict/findDictByParentCode</td>
      <td></td>
      <td>270</td>
      <td></td>
      <td>TOTAL</td>
      <td>94655</td>
      <td>339</td>
      <td>22</td>
      <td>6125</td>
      <td>296</td>
      <td>451</td>
      <td>496</td>
      <td>1331</td>
      <td>0</td>
      <td>786.713432</td>
      <td>1182.374973</td>
      <td>411.7953121</td>
   </tr>
   <tr>
      <td>jdbc连接</td>
      <td>limit 10</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>压测数据库查询m_dict数据</td>
      <td></td>
      <td>10</td>
      <td></td>
      <td>查询</td>
      <td>43653</td>
      <td>24</td>
      <td>9</td>
      <td>4549</td>
      <td>18</td>
      <td>30</td>
      <td>44</td>
      <td>139</td>
      <td>0</td>
      <td>363.6689299</td>
      <td>364.3792208</td>
      <td>0</td>
   </tr>
   <tr>
      <td>压测数据库查询m_dict数据</td>
      <td></td>
      <td>30</td>
      <td></td>
      <td>查询</td>
      <td>19069</td>
      <td>187</td>
      <td>20</td>
      <td>22843</td>
      <td>83</td>
      <td>341</td>
      <td>521</td>
      <td>981</td>
      <td>0</td>
      <td>158.7694101</td>
      <td>159.0795066</td>
      <td>0</td>
   </tr>
   <tr>
      <td>压测数据库查询m_dict数据</td>
      <td></td>
      <td>90</td>
      <td></td>
      <td>查询</td>
      <td>31774</td>
      <td>333</td>
      <td>10</td>
      <td>9448</td>
      <td>231</td>
      <td>576</td>
      <td>805</td>
      <td>1814</td>
      <td>0</td>
      <td>264.096682</td>
      <td>264.6124958</td>
      <td>0</td>
   </tr>
   <tr>
      <td>压测数据库查询m_dict数据</td>
      <td></td>
      <td>270</td>
      <td></td>
      <td>查询</td>
      <td>27057</td>
      <td>1196</td>
      <td>26</td>
      <td>15632</td>
      <td>902</td>
      <td>2004</td>
      <td>2398</td>
      <td>4520</td>
      <td>0</td>
      <td>222.8252366</td>
      <td>223.2604421</td>
      <td>0</td>
   </tr>

</table>

##### 6.2.2、接口压测实况图（90并发）
下面抽取并发量为90的情况下各个测试接口的资源情况，分别是内存和cpu状况图、响应时间、tps
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115175636405.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115175648288.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
一、api/nonmetalPla/list((post)）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163809271.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163817864.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163831910.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
二、/api/warehouse/searchCarType （查询基础数据(post) ）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163900384.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163917977.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163926648.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
三、/ api/dict/findDictByParentCode （根据父类编码查询下级字典(post) ）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163953431.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115164005365.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115164016844.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
四、压测数据库查询m_dict数据 （jdbc连接 ）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163601826.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019111516372689.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115163741562.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
##### 6.2.3、第二轮压测分析
- 二轮压测发现pla接口和warehouse接口都是比较相近的tps结果数据，
- 数据字典接口翻了将近10倍，其数据也是不多的，但是结果差别如此的大。
- 压测数据库查询tps也翻了一倍，
根据以上几个现象，首先能确定的是虽然内网环境，但是走vpn的情况下，网络存在不稳定，当前数据库仅该后台系统在使用，说明数据传输的耗时主要受网络方面的影响大。
结合第一轮压测出现的一些问题，两轮下来，需要第三轮的测试，
第三轮主要是判断数据量大小的网络传输，是否明细影响压测结果
#### 6.3、第三轮压测
##### 6.3.1、聚合报告
<table>
   <tr>
      <td>接口名称</td>
      <td>数据量</td>
      <td>并发数</td>
      <td>持续时间</td>
      <td>samples</td>
      <td>average</td>
      <td>min</td>
      <td>max</td>
      <td>median</td>
      <td>90%Line</td>
      <td>95%Line</td>
      <td>99%Line</td>
      <td>error%</td>
      <td>tps(s)</td>
      <td>received(kb/s)</td>
      <td>sent(kb/s)</td>
   </tr>
   <tr>
      <td>pla(post)</td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td>10</td>
      <td>30</td>
      <td>120s</td>
      <td>5207</td>
      <td>689</td>
      <td>74</td>
      <td>5609</td>
      <td>608</td>
      <td>1054</td>
      <td>1356</td>
      <td>2167</td>
      <td>0</td>
      <td>43.3</td>
      <td>1717.91</td>
      <td>22.35</td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td>1</td>
      <td>30</td>
      <td>120s</td>
      <td>17408</td>
      <td>205</td>
      <td>48</td>
      <td>5707</td>
      <td>113</td>
      <td>317</td>
      <td>472</td>
      <td>2120</td>
      <td>0</td>
      <td>144.8</td>
      <td>629.9</td>
      <td>74.65</td>
   </tr>
   <tr>
      <td>api/nonmetalPla/list</td>
      <td>0</td>
      <td>30</td>
      <td>120s</td>
      <td>47035</td>
      <td>75</td>
      <td>24</td>
      <td>21001</td>
      <td>52</td>
      <td>120</td>
      <td>187</td>
      <td>321</td>
      <td>0</td>
      <td>391.8</td>
      <td>171.41</td>
      <td>208.88</td>
   </tr>

</table>

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115170304747.png)
##### 6.3.2、接口压测实况图（30并发）
**下面抽取并发量为30压测**的情况下各个测试接口的资源情况，分别是内存和cpu状况图、响应时间、tps
压测接口：api/nonmetalPla/list((post)
并发量：30
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191118083953456.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191118084007563.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)

一、查询0条
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115164934968.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115165635519.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115164911940.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115164900320.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
二、查询1条
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115170052928.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115170109834.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115170118752.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
三、查询10条
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115165616709.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115165743751.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191115165752503.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE0NTYzMzc=,size_16,color_FFFFFF,t_70)
##### 6.3.3、第三轮压测分析
- 数据量大小的网络传输影响非常大
- 数据量越小传输越快，当前VPN的内网受VPN或内网网速影响较大
- 接口的数据量有必要缩减，会有明细的tps提升

### 七、结论
结合压测一、二、三分析，得到以下一些结论和建议：
- 主要问题在网络环境，网络的提升对压测tps的影响非常大。
- 工作时间的早上刚上班期间，服务器和带宽都是比较宽裕的状况，这几个目标接口的压测结果tps都提高了很多，vpn连接的内网压测对数据的准确性仍然有一定的影响
- 在网络正常的情况下，接口tps仍然只能在50左右。
- 服务器性能不是非常稳定，虚拟linux多个地方共用主机导致有波动，也影响接口性能，单独部署到一台服务器会事比较好的选择
- 数据库压测tps120-150，200+均出现，从二轮压测可以看出，除了网络之外，数据库tps仍可以继续提高，本地机器能达到1000tps，可以向着这个目标接近。
- 所有接口不需要的字段尽量缩减不返回到前端，可做进一步优化，考虑字段过多，sql查询方面的问题

- 对于接口耗时较长的情况，目前引入了redis，但是目前用的地方很少，redis几乎闲置，接口可以考虑结合使用redis

- 考虑下一轮的压测中直接在机房另一台linux/win下专门压测，并使用命令行方式直接导出报告的方式节省工作量