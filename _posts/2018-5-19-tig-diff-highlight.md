---
layout: post
title: "在 tig 中啟用 diff-highlight"
description: 簡單教學如何啟用 tig 原生支援的 diff-highlight。
tags: [Tool]
comments: true
---
tig 是一套有名的 git browser，大大簡化瀏覽 git commit 的複雜度，並提供漂亮乾淨的介面。

如下圖：

<img src="{{ site.baseurl }}/img/posts/2018-5-19/1.png">

但美中不足的是，tig 原生並沒有啟用 diff-highlight，本篇會簡單說明如何在 tig 中啟用 diff-highlight。

首先要能夠使用 diff-highlight 需要 tig 版本大於 2.2.1，可以透過以下指令確認 tig 版本。

```
tig --version
```

如果版本小於 2.2.1 可以先去 [tig repo release](https://github.com/jonas/tig/releases) 下載新版。

並透過以下指令編譯：

```
$ make
$ make install
```

更詳細資訊可以參考 [tig repo INSTALL.adoc](https://github.com/jonas/tig/blob/master/INSTALL.adoc)。

當確定版本夠新後就能夠來啟用 diff-highlight。

首先把 [diff-highlight](https://github.com/git/git/blob/v2.3.5/contrib/diff-highlight/diff-highlight) script 放到 PATH 中。

並記得給予執行的權限，如下：

```
chmod a+x /usr/local/bin/diff-highlight
```

之後在家目錄下的 .tigrc 中加入一行：

```
set diff-highlight = true
```

~/.tigrc 可能不存在，如果不存在就產一個。

That's it!

結果如下：

<img src="{{ site.baseurl }}/img/posts/2018-5-19/2.png">

更多詳細討論可以參考 [tig issue #313](https://github.com/jonas/tig/issues/313)。
