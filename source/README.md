##写文章

### 1.新建文章

`$ hexo new "test"`

当输入命令后，就会在 source/_post 文件夹下创建一个文件，命名为：test.md


### 2.编写文章
编写文章格式基于 Markdown


### 3.首页显示摘要
Next样式的首页模块默认是会显示全文的，这样查看很不方便，所以我们只需要显示部分摘要，具体方法如下：

#### 修改配置
首先需要在Next主题的_config.yml中把设置打开：(默认安装时就打开了)

```yaml
# Automatically excerpt description in homepage as preamble text.

excerpt_description: true
```

#### 方法一：

在文章的front-matter中添加description，其中description中的内容就会被显示在首页上，其余一律不显示。

```yaml

title: test
date: 2020-03-23 22:55:10
description: 吧啦吧啦吧啦。。。。

```


#### 方法二:文章截断

在你写文章里面加上<!-- more -->，这之前的内容都会显示为摘要
