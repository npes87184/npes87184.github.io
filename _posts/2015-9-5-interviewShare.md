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

　　　群暉算是面試很硬的公司，過四關（其實是三關），然後當天會給 offer，為此有特別練了一下 code，希望等下分享他們面試過程跟考題可以幫助其他人。

### 第一關：

　　　主管進來之後看起來挺嚴肅的，看著履歷問了一些東西，比方說我在實習時做的事情是什麼，用了什麼方法解決等，其中有叫我講解每一個的細節，如：MFCC, BPM 等代表的涵意。之後還問一些 app 相關的，如[繁簡轉換]({% post_url 2015-8-8-tradition2simple %})是如何做到的，履歷上有寫到 1MB 的 txt 檔只需要幾秒鐘，他也問了一些如何可以這麼快。再來主管就說我現在考你一些ＯＳ之類的，不會不要用猜的，我會考很細，題目及當時的大概回答如下。

**講解一下 Process 及 Thread 的差別跟比較：**

      Process 是 OS 分配 resource 的單位，相對的 Thread 是 OS 分配 CPU-time 的單位。Process 之間的溝通相對複雜，要嘛是跟 OS 要一塊 Shared Memory，不然就是透過 OS Message passing，而 Thread 之間的溝通相對簡單，只要透過 Global Variable 即可，雖然可能會有些問題（Race Condition）不過整體是比較簡單的，再者 Thread 的切換可能不用轉到 Kernel Mode（看 Thread 如何實作）又 Process 切換需要儲存許多資料到 PCB 而 Thread 相對少，所以 Thread 的 Context Switch 也比 Process 快。

**Stack 跟 Heap 的差別：**
      
      Stack 是儲存程式呼叫時的記憶體位子跟 local variable 而 heap 是儲存動態不知道何時歸還的東西，如 new 出來的物件。

**請解釋一下 Virtual Function：**

      Virtual function 是一種 SPEC 的概念，如有個父類是衣服，且我們知道所有的衣服都要能穿，所以我們可以把“穿”設成 vitrual，那所有衣服的子類，如襯衫、外套等都需要實作“穿”這個函數，否則不能 new 出來使用。

**請解釋一下 Synchronous call 跟 Asynchronous call 的差別：**

      如果使用 Synchronous call 則呼叫的程式必須等到完成才能繼續往下做，相對的 Asynchronous call 就不用，呼叫的程式可以繼續往下執行不受影響。

　　　大體上這樣，可能還有一些題目，不過現在暫時想不起來，之後如果有想到再補。

　　　問完這些之後，主考官就笑笑地說，我們來寫一些 code 吧，對自己的指標有信心嗎？ＸＤ

　　　題目是刪除 sorted linked list 中相同的 node。

　　　比方說原始的 linked list 是 1->2->2->3，要弄成 1->2->3。

{% highlight C++ %}
ListNode* deleteDuplicates(ListNode* head) {
   if(!head) return NULL;
   while(head->next && head->val==head->next->val) {
      head = head->next;
   }
   ListNode* tmp = head;
   while(tmp->next) {
      if(tmp->next->val==tmp->val) {
          ListNode* use;
          use = tmp->next;
          tmp->next = use->next;
          delete use;
      } else {
          tmp = tmp->next;
      }
   }
   return head;
}
{% endhighlight %}

　　　一開始寫出來的 code 大體上是這樣，不過印象中更醜，還有用到 prev 之類的，但主要想法是一樣的，就是分兩個 case 先把頭相同的都刪光，在刪裡面的。主考官看了一下之後說 ok，但是他希望我改成只有一種 case 就解決。

　　　本來想直接使用 Pseudo Node 就可以一種 case，不過他希望不要用 Pseudo Node。ＸＤ

　　　寫完之後主考官看了一下說邏輯正確，但是有 Bug，請把它修好。老實說，覺得不告知 Bug 在哪，然後要去修有點難，還好最後 Trace 了幾遍之後有找到，並花一些時間修好，最後的 Code 如下。

{% highlight C++ %}
ListNode* deleteDuplicates(ListNode* head) {
     if(!head) return NULL;
     ListNode* curr = head;
     ListNode* tmp;
     
     while(curr && curr->next) {
         if(curr->val==curr->next->val) {
             tmp = curr->next;
             curr->next = tmp->next;
             delete tmp;
         } else {
             curr = curr->next;   
         }
     }
     return head;
}
{% endhighlight %}

　　　寫完並且主考官看完沒問題之後就叫我等一下，並出去了，約略等十到十五分鐘第二關就開始了。

### 第二關：

　　　第二關的面試官是一個女生的ＲＤ，一開始先問學過哪些資料結構，其實這時候就想到他可能等下會要求比較剛說過的，所以只講印象最深的。ＸＤ

**比較 Stack 跟 Queue 的差別：**

      Stack 是後進先出，就像堆盤子一樣，最晚堆上去的反而是最先被拿走的。而 Queue 則是排隊，先排的人可以先走。

　　　再來希望我實作一下 Stack。

{% highlight C++ %}
/*
*  Struct ListNode {
*     ListNode* next;
*     int val;
*  };
*/
int size = 0;
ListNode* top = NULL;

void push(int a) {
   ListNode* node = new ListNode(a);
   node->next = top;
   top = node;
   size++;
}

int pop() {
   if(size==0) {
      return INT_MIN; //error
   }
   ListNode* tmp = top;
   int val = tmp->val;
   top = top->next;
   size--;
   delete tmp;
   return val;
}

ListNode* top() {
   return top;
}

int size() {
   return size;
}

bool empty() {
   return size==0;
}
{% endhighlight %}

　　　大體上到這裡已經實作完畢，不過主管表示，如果不需要 size 這個函數，可不可以不要用 size 這個變量，答案是可以的，只是 empty 那邊要改成 return top==NULL。

　　　再來就是如果希望可以直接取到 stack 中的最大值要怎樣實作。一開始的想法是使用另外一個 stack 只放 max 並在 push 跟 pop 的時候修改維護這個 stack 就可以，大體上如下。

{% highlight C++ %}
/*
*  Struct ListNode {
*     ListNode* next;
*     int val;
*  };
*/
ListNode* top = NULL;
stack<int> s;

void push(int a) {
   if(s.empty() || s.top() <= a) {
      s.push(a);
   }
   ListNode* node = new ListNode(a);
   node->next = top;
   top = node;
   size++;
}

int pop() {
   if(size==0) {
      return INT_MIN; //error
   }
   ListNode* tmp = top;
   int val = tmp->val;
   if(val==s.top()) {
      s.pop();
   }
   top = top->next;
   size--;
   delete tmp;
   return val;
}

int getMax() {
   return s.top();
}

ListNode* top() {
   return top;
}

bool empty() {
   return top==NULL;
}
{% endhighlight %}

　　　這時候主管表示如果不能使用額外的 stack 該怎麼辦？想到的方法是使用一個 Max 指到最大的那個 node 如果這個 node 被 pop 就在找一次，缺點是 pop 的複雜度提高，最後解法是在多一個 nextMax，去指下一個 max 然後省下 pop 要尋找的時間。

　　　再來是實作一些 multi-thread 的程式，不過這部分答的不太好，最後只有回答 semaphore 跟 mutex 的差別。

      mutex 只適用 resource 只能給一個人使用的情況，而 semaphore 則更加靈活都可以。

　　　之後是考二維陣列搜尋，這個陣列有一些條件就是，左邊比右邊小，上面比下面小，如下面這個例子。暴力法的話是 O(mn)，希望可以比這個快。

{% highlight C++ %}
[
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]
{% endhighlight %}

　　　我的解法是去實作一個 binary search，然後對每一列都做 binary search 這樣就可以在 O(mlogn) 完成。

{% highlight C++ %}
bool search(int[] A, int start, int end, int val) {
   while(true) {
      int i = (start+end)/2;
      if(A[i]>val) {
         end = i-1;
      } else if(A[i]<val) {
         start = i+1;
      } else {
         return true;
      }
      if(start>end) {
         return false;
      }
   }
}
{% endhighlight %}

　　　不過做完之後主管表示可以在 O(m+n) 完成，想想看如果不要從左上那個角出發去找的話。最後我有解釋如果從右上大概要怎樣完成，關鍵大概是如果從右上往下找，只要找過一個，上面那一大半都可以不用看，原因如下。

　　<img src="{{ site.baseurl }}/image/2015-9-5/0.png">

　　當找到 Now 的時候，左上那堆藍色的區域通通比 Now 小，所以都可以忽略，大體上就可以先在右邊找到區間，再往左邊找這樣。

　　最後面試官表示 code 還需要再磨練，本來以為大概沒機會了。

　　還好再等待一段時間之後進來的不是人資，但因為在群暉研替是一定要二面，所以第三關考官進來之後就說麻煩我再跑一趟這樣，就帶我去坐電梯了。並且在當天下午就收到人資電話約下次面試時間。

### 第三關：

　　這次考官也是先問問如何實作[繁簡轉換]({% post_url 2015-8-8-tradition2simple %})，並且詢問是否有改進的方法，之後一樣要我解釋 Thread 是什麼。

　　複習一下。ＸＤ

**講解一下 Process 及 Thread 的差別跟比較：**

      Process 是 OS 分配 resource 的單位，相對的 Thread 是 OS 分配 CPU-time 的單位。Process 之間的溝通相對複雜，要嘛是跟 OS 要一塊 Shared Memory，不然就是透過 OS Message passing，而 Thread 之間的溝通相對簡單，只要透過 Global Variable 即可，雖然可能會有些問題（Race Condition）不過整體是比較簡單的，再者 Thread 的切換可能不用轉到 Kernel Mode（看 Thread 如何實作）又 Process 切換需要儲存許多資料到 PCB 而 Thread 相對少，所以 Thread 的 Context Switch 也比 Process 快。

　　之後還有一些ＯＳ，不過想不起來，一樣之後要是有想到再補。

　　白板題則是考對某副檔名的讀取及操作，這檔案的規格是前 ３２ bits 有一些資訊不用管，之後每一個都是 key=value'\0'key1=value1'\0' ... 這樣下去，然後檔案結束的時候是 '\0''\0' 兩個結束符號這樣。考題是如果給一個 key 那詢問他的 value 是多少或是找不到。再來就是如果想要修改某一個 key 的值要怎樣修改？其中修改方法是覆蓋掉它原先的地方，並把它塞在最後面。

　　一開始是用 split 去弄，後來面試官希望不要這樣弄，得益於之前寫過 jpeg decoder 寫起來還算得心應手， 靠一個 char 一個 char 的去處理，找出每一個字串的 key 值跟 value 在弄上去。

{% highlight C++ %}
string get(string key) {
  int start = 0;
  int end = 0;
  int tmp = 0;

  for(int i=0;i<ch.size();i++) {
    if(ch[i]!='\0') {
      end++;
    } else {
      tmp = start;
      for(int j=start;j<end;j++) {
        if(ch[j]!='=') {
          tmp++;
        }
      }
      string result = "";
      for(int j=tmp+1;j<end;j++) {
        result += ch[j];
      }
      return result;
    } 
  }
  return "can't find";
}
{% endhighlight %}

　　大體上是這樣，而修改的部分也是差不多，先用類似的方法找到對應的 key，之後把後面的覆蓋上來，再補在最後面。 

　　最後有問一下面試官覺得我哪裡表現最差，他表示 code 的可讀性太差。ＸＤ

　　聽說群暉很喜歡考 Linked List 的排序相關，這邊也附上：[Linked List Sort]({% post_url 2015-9-12-linkedListSort %})

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




