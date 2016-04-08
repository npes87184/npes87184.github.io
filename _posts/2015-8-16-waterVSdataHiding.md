---
layout: post
title: "Watermarking VS Data Hiding"
categories: [研究雜記]
tags: [Watermarking, Data Hiding, Image Processing]
image_description: false
description: 探討 Watermarking 及 Data Hiding 的特性，並討論其相同跟不同的地方。
comments: true
published: true
---
## 1. 前言：

　　　之前一直在困惑 Watermarking 跟 Data Hiding 的差別，兩個不都是放一些看不到東西進去數位資料（如影像檔、聲音檔）中嗎？為什麼還要特地分成兩個不同的名詞？某個機會之下跟學長討論並加上自己思考過後，得到一些結論。這篇會寫下當時討論的結果，並列出表格直接明確指出相同及不同的地方，方便以後有同樣困惑的人參考，也讓自己以後可以快速查詢。

## 2. Watermarking：

　　　浮水印的使用主要是用來保護智慧財產權，最常見的例子大概就是在補習班的講義上，通常在講義的背景可以看到浮水印。下圖是一個有浮水印的圖。

　　　<img src="{{ site.baseurl }}/image/2015-8-16/0.jpg">

　　　因為是為了保護智慧財產權，顯然有一個要求就是不能夠很輕鬆的就消除掉浮水印，比方如果我把浮水印用在某一個小角落，那麼可以很輕鬆的把那部分裁掉，整張圖看起來就是沒有加過浮水印的樣子了。這個基本要求我們在學術上稱作 **Robust** 在大陸那邊稱作**魯棒性**，順帶一提，老實說個人覺得這個完全靠音譯的翻譯不太好，根本無法理解他是要表達什麼意思。

　　　話題轉回來，在這時就引出一個矛盾，如果我們希望圖上的 Watermarking 有比較好的 Robust 相對的圖的美觀程度會明顯下降。以上圖的例子來說，他的 Robust 一定超好，畢竟整張圖都被浮水印覆蓋了，但是圖的整體也幾乎被破壞了。

　　　所以在學術界上就有一些人在研究如何在不破壞圖的情況之下藏一個浮水印進去，且又夠 Robust，其中最成功的一支就是使用 Spread Spectrum 技術的浮水印，如下圖就是運用 Spread Spectrum 藏浮水印的結果。
　　　<img src="{{ site.baseurl }}/image/2015-8-16/1.png">

　　　下面圖表的意思是，用其他 999 個隨機產生的假 Watermarking 去比對相似度都很低，只有那個真正個 Watermarking 能夠得到很高的相似度。

　　　可以看出在不怎麼影響圖的外觀的情況之下就只有一個很明顯的 Watermarking 在數據上。

　　　這個方法有很強的 Robust，即使我把圖剪掉 3/4 還是能夠偵測出來，主要的缺點大概就是 Watermarking 不太能夠明確看出是什麼，只能用這樣的圖表來加上解釋來表示。

　　　在之後我會找時間再撰文詳細解釋這個方法如何實作及背後的數學，現在先讓我們看看 Data Hiding。

## 3. Data Hiding：

　　　最早期的 Data Hiding 大概就是檸檬汁了，大家一定都有聽過或玩過隱形墨水吧？電影中總是會有人使用隱形墨水來傳遞隱藏的資料，收到方在使用蠟燭小心的烤就能得到真實資料。另一個例子就是古代還會有人把頭髮剃光，在上面刻字之後等頭髮長出來再去送密這樣的情況。我們可以說這些就是早期的 Data Hiding。

　　　而到了數位的時代，要如何做到 Data Hiding 呢？看了剛剛浮水印的介紹，是不是想到可以把資料用類似的方法來藏呢？沒錯，這也是我一開始最困惑的地方，這樣來看兩個不是根本就是類似的東西？其實不然，兩個雖然類似，但是跟浮水印不同的是，Data Hiding 的要求不是 Robust，而是容量（Capacity）以及資料的還原程度等，因為 Data Hiding 顧名思義就是要藏資料進去，資料本體才是重點。可以藏多少，以及可不可以百分之一百的還原資料跟放資料的圖片或音樂才是相對重要的。但是這樣是不是表示 Robust 不重要？其實也不然，如果沒有 Robust 那麼資料很容易經過一些自然的過程就消失了，所謂的自然過程就是數位資料必然會經過的步驟，最常見就是壓縮跟網路傳輸等。

　　　以下是一個 Data Hiding 的例子。
　　　<img src="{{ site.baseurl }}/image/2015-8-16/2.png">
　　　左圖其實有藏一些資訊在裡面，右邊則是把左圖稍微改圖之後的樣子。

　　　<img src="{{ site.baseurl }}/image/2015-8-16/3.png">
　　　左圖就是從上面右邊拿出來的資訊，右邊則是可以偵測出哪裡被修改過。

　　　同樣的，在之後我會找時間再撰文詳細解釋這個方法如何實作及背後的數學，現在先讓我們看看比較跟結論。

## 4. 比較：
　　　<img src="{{ site.baseurl }}/image/2015-8-16/4.png">

## 5. Reference：

　　　[1] Secure Spread Spectrum Watermarking for Multimedia
Ingemar J. Cox, Senior Member, IEEE, Joe Kilian, F. Thomson Leighton, and Talal Shamoon, Member, IEEE

　　　[2] A Maximum Entropy-Based Chaotic Time-Variant Fragile Watermarking Scheme for Image Tampering Detection
Young-Long Chen, Her-Terng Yau, and Guo-Jheng Yang
