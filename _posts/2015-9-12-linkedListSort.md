---
layout: post
title: "Linked List Sort"
categories: [演算法]
tags: [C++, Linked list, 演算法, 排序]
image_description: false
description: 講解常見的排序方法 (Bubble sort, Selection sort, Insertion sort 跟 Merge sort) 並附上 Linked List 實作版本。
comments: true
published: true
---
## Bubble Sort：

　　泡泡排序其實非常簡單，把每一個數字想像成一個泡泡，數字的大小就是泡泡的重量，越重的會沉在越下面，那如果每次我們都把最重的沉下去，做了一定次數之後就排序完成了，如下圖。

　　<img src="{{ site.baseurl }}/image/2015-9-12/0.png">

　　５是最重的泡泡，所以每一次跟周圍比都要往下沉，最後沈到最底下，下一次開始就是由３往下沉，值得注意的是，當遇到沉不下去的時候代表下面的泡泡比較重，所以就由下面的泡泡接替往下沉，如下圖框框中的情況。

　　<img src="{{ site.baseurl }}/image/2015-9-12/1.png">

　　這樣下去再做幾輪之後就完成了，掌握了泡泡排序的核心想法之後，以下展示一些運用 Linked List 實作的泡泡排序。

{% highlight C++ %}
ListNode* bubbleSortList(ListNode* head) {
    // bubble sort
    ListNode* tail = head;
    ListNode* tmp = head;
    ListNode* curr = head;
    ListNode* prev = head;
    
    // get Linked list size first
    int size = 0;
    while(tail) {
        tail = tail->next;
        size++;
    }
    
    for(int i=size;i>0;i--) {
        curr = head;
        prev = head;
        for(int j=0;j<i-1 && curr->next;j++) {
            // Compares two elements, and swaps if current is bigger than next
            if(curr->val > curr->next->val) {
                tmp = curr->next;
                curr->next = tmp->next;
                tmp->next = curr;
                // In linked list, swap has two case. In head or not.
                if(curr == head) {
                    head = tmp;
                    prev = tmp;
                } else {
                    prev->next = tmp;
                    prev = prev->next;
                }
            } else {
                curr = curr->next;
                if(j!=0) prev = prev->next;
            }
        }
    }
    
    return head;
}
{% endhighlight %}

　　因為在 Linked List 中通常都需要考慮是不是 head，那如果不想要那麼麻煩有一個小技巧就是使用 Pseudo Node，下面也展示使用這種方法實作的泡泡排序，就可以不用管是不是在 head，最後要注意要把這個 Pseudo Node 還回去，不然會 Memory leak。

{% highlight C++ %}
ListNode* bubbleSortList(ListNode* head) {
    // bubble sort with pseudo node
    ListNode* pseudo = new ListNode(0);
    pseudo->next = head;
    
    ListNode* curr = pseudo;
    ListNode* tmp = head;
    
    int size = 0;
    
    while(tmp) {
        tmp = tmp->next;
        size++;
    }
    
    for(int i=size;i>0;i--) {
        tmp = pseudo;
        for(int j=0;j<i-1 && tmp->next && tmp->next->next;j++) {
            // If we use pseudo node, we don't need to care head
            if(tmp->next->val > tmp->next->next->val) {
                ListNode* temp = tmp->next->next;
                tmp->next->next = temp->next;
                temp->next = tmp->next;
                tmp->next = temp;
            }
            tmp = tmp->next;
        }
    }

    tmp = pseudo;
    curr = pseudo->next;

    // Care memory leak
    delete tmp;

    return curr;
}
{% endhighlight %}

　　最後就是，其實也未必要事先知道整個 Linked List 的 size 是多少，可以先設定一個 tail 初始是 NULL，只要發現下一個點是 tail 就知道這輪結束了，只要更改一下 tail 就可以進行下一輪，也是可以弄出來。

{% highlight C++ %}
ListNode* bubbleSortList(ListNode* head) {
    // bubble sort with no size
    ListNode* tmp;
    ListNode* curr = head;
    ListNode* prev = head;
    ListNode* tail = NULL;
    
    while(head!=tail) {
        curr = head;
        prev = head;
        while(curr && curr->next && curr->next!=tail) {
            if(curr->val > curr->next->val) {
                tmp = curr->next;
                curr->next = tmp->next;
                tmp->next = curr;
                if(curr==head) {
                    prev = tmp;
                    head = tmp;
                } else {
                    prev->next = tmp;
                    prev = prev->next;
                }
            } else {
                if(curr!=head) {
                    prev = prev->next;
                }
                curr = curr->next;
            }
        }
        // In each iteration, we need to adjust tail. And we know curr->next = tail, so we let tail = curr here.  
        tail = curr;
    }
    return head;
}
{% endhighlight %}

## Insertion Sort：

　　Insertion Sort 的想法很簡單，想像在玩撲克牌的時候，除了最可憐的發牌者，其他人會在牌發到一半的時候就先拿起來整理手牌，這時候我們整理的方式就是把新發過來的牌按照大小插入手中。插入排序的想法也是這樣，假設我們已經有一串已經排序完成的，這時候新進來的就按照他應該的位子把它插進去即可。

　　一開始假設第一個數字是已經排序好的，之後第二個數字往前插，這樣就有兩個位子是排序好的，再來第三個數字再去找適當的地方放進去，以此類推即可完成排序，如下圖。

　　<img src="{{ site.baseurl }}/image/2015-9-12/2.png">

　　藍色是已經排序完成的地方，乍看之下很像插入排序很快，只要幾步就完成了。其實不然，因為在尋找要差在哪裡也是需要時間的，所以整體時間跟泡泡排序差不多快。

{% highlight C++ %}
ListNode* insertionSortList(ListNode* head) {
    // insertion sort
    if(!head) return NULL;
    ListNode* temp = head;
    
    // get size first
    int size = 0;
    while(temp) {
        size++;
        temp = temp->next;
    }
    // curr is the next element of sorted list 
    ListNode* curr = head->next;
    // prev->next == curr
    ListNode* prev = head;
    // tail indicates the tail of sorted list
    ListNode* tail = head;

    for(int i=1;i<size;i++) {
        temp = head;
        prev = head;
        // find the location to be inserted
        for(int j=0;j<i && temp->val < curr->val;j++) {
            temp = temp->next;
            if(j!=0) prev = prev->next;
        }
        // insert
        if(temp==head) {
            tail->next = curr->next;
            curr->next = head;
            head = curr;
        } else if(temp==curr) {
            tail = tail->next;
        } else {
            prev->next = curr;
            tail->next = curr->next;
            curr->next = temp;
        }
        curr = tail->next;
    }
    
    return head;
}
{% endhighlight %}

## Selection Sort：

　　選擇排序的想法也很簡單，每次選擇最大或最小的元素排到正確的位子，不同於泡泡排序，他不會有一個往下沉或往上浮的情況，而是就是找最小或最大的拉過去，所以可以得到最小交換次數，對於要根據一個很大的表格的某一項排序是很好用的，原因是因為表格很大，造成交換的時間需要很久，選擇排序可以盡量減少交換次數。

　　<img src="{{ site.baseurl }}/image/2015-9-12/3.png">

　　其中藍色是本次最小，而綠色則是已經排序完成的地方，每次都選一個最小去跟適當的位子交換，只要做適當的次數就可以完成排序。

{% highlight C++ %}
ListNode* selectionSortList(ListNode* head) {
    // selection sort
    if(!head) return NULL;
    ListNode* temp = head;
    // tail indicates the tail of sorted list
    ListNode* tail = head;
    // get size first
    int size = 1;
    while(tail->next) {
        tail = tail->next;
        size++;
    }
    ListNode* curr = head;
    ListNode* prev = head;
    ListNode* min_Prev = head;
    ListNode* minNode = head;
    for(int i=size;i>0;i--) {
        curr = head;
        prev = head;
        min_Prev = head;
        minNode = head;
        // find the min
        for(int j=0;j<i;j++) {
            if(curr->val < minNode->val) {
                minNode = curr;
                min_Prev = prev;
            }
            curr = curr->next;
            if(j!=0) prev = prev->next;
        }
        // let tail->next = min, because tail is last min.
        if(minNode==head) {
            tail->next = head;
            head = head->next;
            tail = tail->next;
            tail->next = NULL;
        } else {
            tail->next = minNode;
            min_Prev->next = minNode->next;
            tail = tail->next;
            minNode->next = NULL;
        }
    }
    return head;
}
{% endhighlight %}

## Merge Sort：

　　Merge Sort 的想法比較複雜一點，先看圖在講解應該會比較有感覺。

　　<img src="{{ site.baseurl }}/image/2015-9-12/4.png">

　　想像如果有兩個已經排序好的串列，要把他接成一個已經排序完成的應該不會太難。Merge Sort 的概念就是這樣，先把每一個元素當成一個已經排序好的，之後依序往上接，就能排序完成。

　　實作上比起上面三種都還有容易理解，且因為複雜度為 O(nlogn) 所以速度比起上面三種快非常多，在 <a href="https://leetcode.com/problems/insertion-sort-list/">leetcode</a> 上，運用 Merge Sort 大概只需要 20ms 可以跑完的情況，如果運用上面三種都需要到 200ms 左右。

{% highlight C++ %}
ListNode* merge(ListNode* l1, ListNode* l2) {
    // merge with pseudo node
    ListNode* temp = new ListNode(0);
    ListNode* q = temp;
    
    while(l1 && l2) {
        if(l1->val < l2->val) {
            temp->next = l1;
            temp = temp->next;
            l1 = l1->next;
        } else {
            temp->next = l2;
            temp = temp->next;
            l2 = l2->next;
        }
    }
    
    if(l1) temp->next = l1;
    if(l2) temp->next = l2;
    
    ListNode* head = q->next;
    delete q;
    return head;
}

ListNode* mergeSortList(ListNode* head) {
    // merge sort
    if(!head || !head->next) return head;
    
    ListNode* fast = head->next;
    ListNode* slow = head;
    
    // split list
    while(fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }
    fast = slow->next;
    slow->next = NULL;
    
    // sort each list
    ListNode* l1 = mergeSortList(head);
    ListNode* l2 = mergeSortList(fast);
    
    // merge sorted l1 and sorted l2
    return merge(l1, l2);
}
{% endhighlight %}

　　同樣也可以不要使用 Pseudo Node 實作，以下是使用遞迴的方式弄 merge。

{% highlight C++ %}
ListNode* merge(ListNode* l1, ListNode* l2) {
    // merge with recursive
    if(!l2) return l1;
    if(!l1) return l2;
    
    if(l1->val<l2->val) {
        l1->next = merge(l1->next, l2);
        return l1;
    } else {
        l2->next = merge(l1, l2->next);
        return l2;
    }
}

ListNode* mergeSortList(ListNode* head) {
    // merge sort
    if(!head || !head->next) return head;
    
    ListNode* fast = head->next;
    ListNode* slow = head;
    
    // split list
    while(fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
    }
    fast = slow->next;
    slow->next = NULL;

    // sort each list
    ListNode* l1 = mergeSortList(head);
    ListNode* l2 = mergeSortList(fast);
    
    // merge sorted l1 and sorted l2
    return merge(l1, l2);
}
{% endhighlight %}

## 結語：

　　有任何問題，或是 code 有更好寫法，歡迎提出。也感謝 <a href="https://leetcode.com/problems/insertion-sort-list/">leetcode</a> 提供環境方便測試 code 的正確性。：Ｄ
