---
layout: post
title: "不要用 dd 產生 Windows 開機 USB"
description: 留下個踩坑紀錄，希望後人不要踩，或是踩到可以找到相關資料...
tags: [3C, Tool]
comments: true
---
在 Linux 的世界中，有個很有名的指令叫 `dd`，大體上就是 `data duplicator`。

其作用就是無視檔案格式的讀寫 block。

因 ISO 檔案本身就是一個有開機磁區，有分割表，有檔案系統的的一個檔案。
所以理論上我們只要完整的把 ISO dd 進 USB 的 device，就可以使用此 USB 來開機。

假設 USB 為 /dev/usb1 ，那透過 `dd` 產生可開機的 USB 指令大體上如下：

```
dd if=~/Downloads/linux-mint-19.iso of=/dev/usb1 bs=1M
```

因昨天買了新電腦，需要安裝 Windows 10 以及 Linux mint。

就順手在 macbook 上使用了 `dd` 來產生可開機 USB。

事實證明使用 `dd` 來產生可開機的 Linux USB。真的可以使用。

但是...

當使用 `dd` 產生 Windows 10 1803 的可開機 USB 後，在安裝時會卡在下圖：

<img src="{{ site.baseurl }}/img/posts/2018-7-21/1.jpg">

一開始以為是 Windows 沒有包含主機板上的 SATA 控制器，所以都找不到硬碟之類的。
一度要因為沒有光碟機而放棄 Windows 了。

最後死馬當活馬醫，使用 rufus 製作開機 USB。

沒想到就成功了...

不確定 Windows iso 是不是有什麼特殊的格式或 mac 的 `dd` 行為不如預期所導致的。

先留個踩坑日記...

