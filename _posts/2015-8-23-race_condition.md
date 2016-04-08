---
layout: post
title: "Race Condition"
categories: [作業系統]
tags: [作業系統, Race Condition, Share Memory, Critical Section]
image_description: false
description: 探討 Share Memory ，並討論其衍生的 Race Condition 問題及講解常見的三種演算法。
comments: true
published: true
---
## 1. 由來：

　　　從簡單的 Process 定義開始，所謂的 Process 其實可以看作正在執行中的程式碼。在作業系統中，同時執行的 Process 通常不只一個，Process 可以大致分成兩類。

　　　**1. 獨立(independent process)：**

　　　　　　這類的 Process 可以想做是獨行俠，他們彼此之間各自做各自的，互相不干擾，所以基本上只要作業系統可以確保 Process 可以正常執行，不會因為切換 Process 而導致一些問題的話，不會有什麼狀況發生。

　　　**2. 合作(cooperating process)：**

　　　　　　第二種我們稱作合作 Process，如果一個 Process 可以影響別人，或是可能被其他 Process 影響，我們就稱這些 Process 為 合作 Process。這時候就出現一些問題了，比方說有 word 要列印，印表機必須要等到 word 都把資料傳完才能開始列印。顯而易見的兩個問題是，一，資料要傳到哪？這裏顯然需要 Process 之間的溝通。二，如何確保印表機不會讀到舊的資料？

　　　如何讓兩個 Process 之間溝通並傳資料常見的方法有，Share Memory(分享記憶體)及 Message Passing（訊息傳遞），本篇主要探討的是 Share Memory 的部分，並討論其衍生的 Race Condition 問題以及常見的三種解法討論。


## 2. Share Memory：

　　　所謂的 Share Memory 代表的是如果兩個 Process 需要溝通，則他們跟老大哥作業系統要一塊共同的記憶體空間，並透過這塊共同擁有的記憶體空間溝通。

　　<img src="{{ site.baseurl }}/image/2015-8-23/0.png">

　　　如上圖所示， Process A 先把想要給 Process B 的資料，放進 Shared Memory 中，之後 Process B 再去拿出來使用。一切看似很完美，卻還是藏著一些問題，也就是 Process B 如何知道資料是最新的？如何可以確保 Process B 不會拿到改到一半的資料？更複雜一點來說，要是兩個 Process 同時對同一個變數進行更改會怎樣？如下圖，兩個 Process 同時要對 count 加一，會如何？

　　　<img src="{{ site.baseurl }}/image/2015-8-23/1.png">

　　　這時候就會出現一個奇妙的狀況，程式最後執行的結果會跟程式之間運行的順序有關，以下面這個例子來看，我們假定 count 一開始為 4 ，並根據下面的順序執行。

　　　<img src="{{ site.baseurl }}/image/2015-8-23/2.png">

　　　count 最後結果是 5，而正確結果卻應該是 6 才對。

　　　這種因為執行順序不同而導致結果不同的現象稱作 **Race Condition**，也是我們今天要討論的問題。

## 3. Race Condition：

　　　講了這麼多，現在終於要進入今天的主角 Race Condition 了，仔細觀察剛剛的例子會發現，會出現 Race Condition 現象主要是因為放在 Share Memory 中的共用變數被**同時存取**了。換句話說，要是我們可以限制共用變數一次只能被一個 Process 所使用，Race Condition 就迎刃而解了。

　　　那要如何讓共用變數一次只被一個 Process 所使用呢？主要有兩種方法：

　　　**1. Disable Interrupt (停止使用中斷)：**

　　　　　　即使現在的作業系統看起來都可以同時執行好多程式，但實際上作業系統還是只能一次執行一個程式，只是透過中斷、排班等技術快速在不同程式間切換。所以只要作業系統不要因為需要處理某些突發事件而中斷現在的 Process 並切換到其他 Process，這樣就不會有機會讓其他 Process 同時存取到同一個變數了。如下圖這般設計：

　　<img src="{{ site.baseurl }}/image/2015-8-23/3.png">

　　　乍看之下很像很完美，但其實有很多缺陷，比方說這個方法不太適用於多核心處理器，因為只停用某一顆 CPU 的中斷沒意義，但全部停用，花費的代價太高，再者停用中斷其實很危險，如果有很緊急的狀況出現就不能馬上處理。

　　　**2. Critical Section Design (臨界區間設計)：**

　　　　　　所謂的臨界區間就是就是會對共用變數存取的程式碼區域。而設計臨界區間，主要就是設計進去的條件跟出來的條件解除，使其可以保證在離開臨界區間之前，即使換其他 Process 執行也不能進去存取同樣變數的臨界區間去存取共用變數。


　　　　　　大體上臨界區間會長這樣，首先會有一個區域來判斷 Process 可不可以進去，要離開的時候再把進入條件更改，讓其他想進來的人可以進來。
{% highlight Java %}
//管制 Process 可否進入臨界區間
entrySection();

// critical section

//解除入口管制，讓其他 Process 可以進去
exitSection();
{% endhighlight %}

　　　如果以我們之前的例子來看，我們就是要把更改 count 這行當成臨界區間，所以在之前要先判斷是否可以進去，離開時也要給予其他 Process 機會。

　　<img src="{{ site.baseurl }}/image/2015-8-23/4.png">

## 4. Critical Section：

　　　再來就是 Critical Section Design 所需要的要求了，要達成一次只有一個程式進去，且不會造成大家都進不去需要滿足三個條件，分別是 **Mutual Exclusion**、**Progress** 以及 **Bounded Waiting**。

　　　**1. Mutual Exclusion：**

　　　　　　這也是臨界區間的最基本要求，一次最多只能有一個 Process 在裡面存取共用變數。

　　　**2. Progress：**

　　　　　　Progress 有兩個要求。

　　　　　　＋ 不想進入臨界區間的 Process 不可以阻礙其它 Process 進入 

　　　　　　　(即：不可參與進入臨界區間的決策過程)

　　　　　　＋ 必須在有限的時間內，自那些想進入的 Process 中，挑選出一個 Process 進入。

　　　　　　　(即：不可以出現 DeadLock)

　　　**3. Bounded Waiting：**

　　　　　　當 Process 申請要進入臨界區間到真正進入這段等待時間是有限的，即：若有n個 Processes 想進入，則任一 Process 至多等待n-1次，即可進入。

　　　臨界區間設計有很多種方式，如透過演算法設計的方式，或是硬體保證不會被中斷的進入判斷，還有高階資料結構的 Semaphore、Monitor 等，本篇主要集中在兩個 Processes 的軟體演算法設計的三種著名方法。雖然其中有兩種是錯誤的，且最後一種在現今的架構之下也未必能保證正確，但可由這三個例子明白 Critical Section Design 所需要的三個要求的重要性及其精神。

## 5. 軟體演算法：

　　　以下三個演算法皆是討論只有兩個 Processes Ｐi，Ｐj 的情況之下要如何設計，其中展現出來的 Pseudo Code 都是代表Ｐi 的。

{% highlight Java %}
// Algorithm 1

/*
* 一個共用整數變數 turn，其值可能是 i 或 j，代表誰能進臨界區間。
* 整個演算法的核心是，如果能進去才進去。
*/

// Entry Section
while(turn!=i) {
   // do nothing
}

// critical section

// Exit Section
turn = j;
{% endhighlight %}

　　　讓我們來分析三個條件是否有滿足：

　　　　　　1. Mutual Exclusion：

　　　　　　　　　　　　滿足，因為 turn 只能是 i 或 j 所以一次最多只能有一個 Process 進去臨界區間。

　　　　　　2. Progress：

　　　　　　　　　　　　不滿足，假設 turn 的初始值是 i，但是 Ｐi 完全沒有想要進去，換句話說沒有機會把 turn 改成 j，這時如果Ｐj 想進去就沒辦法進去。

　　　　　　3. Bounded Waiting：

　　　　　　　　　　　　滿足，因為每一個 Process 在離開之時會把 turn 設成另外一個的，相當於把優先權讓出去，即使馬上想要在進入，也只能等待另外一個 Process 出來把 turn 改過後才能進去。換句話說，每一個 Process 至多等待一次就可以進入。

{% highlight Java %}
// Algorithm 2

/*
   flag[n]: Boolean陣列，其中 n 的値為 i 或 j 。當布林値為 true，表示該 Process 有意願進入自已的臨界區間;若為  false，則表示無意願進入。 flag[i] 與 flag[j] 的初始値皆設為 false。

   可以想成只有兩個 Process 其中 i = 0, j = 1，所以 flag 其實是 boolean flag[2]，這樣。

   整個演算法的精髓在於，如果別人想進，就先讓給他進去。
*/

// Entry Section
flag[i] = true;
while(flag[j]==true) {
   // do nothing
}

// critical section

// Exit Section
flag[i] = false;
{% endhighlight %}

　　　同樣的，來分析看看三個條件：

　　　　　　1. Mutual Exclusion：

　　　　　　　　　　　　滿足，因為在進去之前就會把自己的 flag 改成 true 所以其他人無法進入。

　　　　　　2. Progress：

　　　　　　　　　　　　不滿足，如下面這個順序執行，則最終大家都進不去。

<img src="{{ site.baseurl }}/image/2015-8-23/5.png">

　　　　　　3. Bounded Waiting：

　　　　　　　　　　　　滿足，因為是讓別人先進去的概念，所以如果我出來之後想馬上再進去，要先讓之前在等待的先進去。換句話說，每一個 Process 至多等待一次就可以進入。

{% highlight Java %}
// Algorithm 3

/*
   * flag[n]: Boolean陣列，其中 n 的値為 i 或 j 。當布林値為 true，表示該 Process 有意願進入自已的臨界區間;若為  false，則表示無意願進入。 flag[i] 與 flag[j] 的初始値皆設為 false。

   可以想成只有兩個 Process 其中 i = 0, j = 1，所以 flag 其實是 boolean flag[2]，這樣。

   * 一個共用整數變數 turn，其值可能是 i 或 j，代表誰能進臨界區間。

   整個演算法的精髓在於，先把優先權讓給別人，如果別人想進去，因為拿到優先權，馬上可以進去，而一旦對方不想進入或是對方把優先權讓回來時，自己能立刻進入。
*/

// Entry Section
flag[i] = true;
turn = j;
while(flag[j]==true && turn==j) {
   // do nothing
}

// critical section

// Exit Section
flag[i] = false;
{% endhighlight %}

　　　分析看看三個條件，就能明白這個方法可以保證臨界區間正確：

　　　　　　1. Mutual Exclusion：

　　　　　　　　　　　　滿足，若 Ｐi 與 Ｐj 皆想進入自已的臨界區間，代表 flag[i] = flag[j] = true，而且會分別執行到 turn = i 及 turn = j 之設定 (只是先後次序不同)。因此,turn 値僅會是 i 或 j，絶不會兩者皆是。 ∴ Mutual Exclusion得以確保。

　　　　　　2. Progress：

　　　　　　　　　　　　滿足

　　　　　　　　　　　＋ 若 Ｐi 不想進入臨界區間，則表示 flag[i] = false。此時若 Ｐj 想進入自已的臨界區間，必可進入，而不會被 Ｐi 阻礙。

　　　　　　　　　　　＋ 若 Ｐi 與 Ｐj 皆想進入自已的臨界區間，則在有限的時間內，Ｐi 與 Ｐj 會分別執行到 turn = i 及 turn = j 之設定 (只是先後次序不同)，turn値必為 i 或 j。∴ Ｐi (或 Ｐj ) 會在有限的時間內進入自已的臨界區間。

　　　　　　3. Bounded Waiting：

　　　　　　　　　　　　滿足，假設兩個 Process 同時都想進入自己的臨界區間，如果最後是Ｐi 順利進入而Ｐj 等待。假如 Ｐi 在執行完臨界區間之後想馬上再進去，但因為在進入前會把 turn 設成 j 且因為 Ｐj 在等待中而無法進入，相當於無法搶先 Ｐj，換句話說，每一個 Process 至多等待一次就可以進入。

　　　其實第三個演算法叫 Peterson's algorithm (或 Peterson's solution) 是一個純粹靠軟體而不使用硬體提供的 Test and Set 或 Swap 來實現臨界區間設計的方法，此方法是 1981 年由 Gary L. Peterson 提出的。

　　　最後，其實臨界區間設計還有很多方法，比方硬體保證不會被中斷的驗證指令（Test and Set 或 Swap），或是可以減輕程式員負擔的高階資料結構 Semaphore 或 Monitor 等，這些之後有機會會在撰文說明及討論。

## 6. Reference：

　　　1. 許多圖跟例子來自<a href="http://sjchen.im.nuu.edu.tw/OS_Final.html">杰哥作業系統數位教室</a>

　　　2. <a href="https://en.wikipedia.org/wiki/Peterson%27s_algorithm">wikipedia</a>
