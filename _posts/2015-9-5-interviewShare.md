---
layout: post
title: "群暉及聯發科研替面試分享"
categories: [雜記]
tags: [研替, 面試心得, 群暉, MTK, 聯發科]
image_description: false
description: 分享面試群暉及聯發科時被問的問題及自己當時的解答等。
comments: true
published: true
---
## 群暉：

　　make an all-out effort！

## 聯發科：

　　聯發科參加的是他們的校園訪談，校園訪談有一些好處是：

　　　　1.一日可面談多種類正職職缺

　　　　2.當日即可獲知錄取結果

　　　　3.用人主管親自到校，節省同學往返交通時間成本

　　關鍵是不用像一般面試聯發科要考英文跟上機考，個人覺得很棒的活動。

　　這邊我是有準備投影片，其中包含寫過的幾個 APP（３個），還有一些上課寫過的功課或 final project（８個），其中 APP 有介紹２個，Project 大概有介紹４個左右。然後照慣例問了如何實現[繁簡轉換]({% post_url 2015-8-8-tradition2simple %})，跟速度，這邊比較特別的是有問如果有記憶體限制要如何實現。並且他們會對 Project 提出一些疑問等。

　　之後開始照成績單問，像是有修過ＯＳ，就問了什麼是ＯＳ。

**什麼是ＯＳ：**

      確保 Process 可以正確執行，不會讓 Process 跟 Process 之間互相干擾，並透過 kernel mode 跟 user mode 保護硬體，並提供 high level 的 system call 讓使用者不能直接操作硬體，簡化操作，也更加有效率等。

　　同樣也有問 Process 跟 Thread 的差別，再次複習一下。ＸＤ

**講解一下 Process 及 Thread 的差別跟比較：**

      Process 是 OS 分配 resource 的單位，相對的 Thread 是 OS 分配 CPU-time 的單位。Process 之間的溝通相對複雜，要嘛是跟 OS 要一塊 Shared Memory，不然就是透過 OS Message passing，而 Thread 之間的溝通相對簡單，只要透過 Global Variable 即可，雖然可能會有些問題（Race Condition）不過整體是比較簡單的，再者 Thread 的切換可能不用轉到 Kernel Mode（看 Thread 如何實作）又 Process 切換需要儲存許多資料到 PCB 而 Thread 相對少，所以 Thread 的 Context Switch 也比 Process 快。

**講解一下如何避免 Race Condition：**

      ＯＳ本身有提供 Semaphore 跟 Monitor 只要使用得當就可以避免這樣的問題。

　　之後看到有修過計算機組織就問了一題計算機組織的問題。

**講解一下什麼是 Hazard：**

      分三種，Structural hazards, Data hazards, Control hazards。其中 Structural hazards 是先天限制，如記憶體一次就只能給一個人讀取。而 Data hazards 會發生在 lw 後面直接接 add 或是 branch 等，在資料就緒之前就要使用，就會出現 Data hazards。最後 Control hazards 會在執行到 branch 的時候出現，因為在執行完 branch 之前無法判斷要執行哪些指令，所以會有猜錯的可能性等。

　　之後照慣例有問了一些今天哪裡表現最差，本來以為還是會有很多需要改進的地方，沒想到主管說，沒有，今天你是表現最好的，很 Impressive！

## 結語：

　　其實是有點運氣不錯，考的題目剛好比較簡單，建議要去面試之前可以 Google 看看這家公司之前面試的情況，可以比較有心理準備，或許還能被問到相同的題目，然後ＯＳ蠻重要的，如果有時間可以翻閱拿回記憶比較好。有一題被問了三遍，相信有認真看的讀者都知道重點在哪。ＸＤ

　　最後推薦一個網站 <a href="https://leetcode.com">LeetCode</a> 裡面有蠻多題目可以練習，覺得蠻有幫助的。

　　有任何問題歡迎提問：Ｄ




