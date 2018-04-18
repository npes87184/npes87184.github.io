---
layout: post
title: "Walkman 播放清單"
categories: [研究雜記]
tags: [python, m3u, m3u8, walkman]
image_description: false
description: 運用 Python + PyQt5 簡單實作一個程式來幫忙產生 Walkman 能用的播放清單。
comments: true
published: true
---
最近失心瘋買了 Sony Walkman zx300 來聽音樂，音質確實是沒話說，但是管理起播放清單不是那麼方便。尤其當音樂中包含純音樂跟含人聲的歌曲的時候更不好整理。有時候就是想聽只有純音樂，而有時候又只想聽 High 歌。最初想到的方法是透過資料夾把歌曲都如下分類好。

```
/music/純音樂/RO_OST/*.mp3
/music/音樂/周杰倫/*.mp3
/music/音樂/梁靜茹/*.mp3
/music/音樂/*.mp3
...
```

乍看之下這時候想聽純音樂就播放純音樂的資料夾，想聽音樂就播放音樂的資料夾。但運用 Walkman 內建的從資料夾播放卻有個大問題。 **Walkman 不會播放子資料夾內的音樂。** 因為這個缺點導致每次聽音樂都要花許多時間翻找，實在不是那麼方便。

最後萌生了寫個簡單的程式幫忙產生播放清單。簡單研究一下發現比想像中簡單，所謂的播放清單檔案 (*.m3u, *.m3u8) 其實就只是一列一列的相對路徑而已。透過 python 可以很簡單的走過資料夾跟子資料夾。就決定使用 python 來攥寫。

大體上程式會如下：

```python
m3uList = []
for root, subdirs, files in os.walk(selectDir):
    for filename in files:
        relDir = os.path.relpath(root, selectDir)
        # m3u does not support ./music.mp3
        if relDir == ".":
            path = filename
        else:
            path = os.path.join(relDir, filename)
        if isMusic(path):
            m3uList.append(path)
return m3uList
```

其中要注意的只有播放清單檔案是不支援類似 ./music.mp3 這樣的寫法的。所以就簡單判斷一下，當是根目錄就直接顯示檔名，不然就是加上相對路徑。

最後在把陣列中的值一行一行的寫到檔案中即可。為了更好的相容這邊是選擇使用 *.m3u8，他跟 *.m3u 的差別只有差在他是 unicode 的。

```python
f = open(m3uPath, 'w', encoding='utf-8')
for music in m3uList:
    f.write(unicodedata.normalize('NFC', music) + '\n')
f.close()
```

其中在寫檔案的地方要注意的是 Unicode 在對於像是日文這種有濁音之類包含符號的表示方式有兩派。經過測試 Walkman 是支援寫在一起的這派。所以為了避免 Walkman 讀不到要在做個 unicode normalize。

最後最後在用 PyQt5 包個簡單 UI 就能輕鬆用了。

[![Screenshot](https://raw.githubusercontent.com/npes87184/PyM3UGenerator/master/screenshots/1.png)](https://github.com/npes87184/PyM3UGenerator/blob/master/screenshots/1.png)

**完整項目程式碼在：[GitHub](https://github.com/npes87184/PyM3UGenerator)**

有興趣或有需要可以上去看看，有幫助的話也可給個星星鼓勵。

感謝。
