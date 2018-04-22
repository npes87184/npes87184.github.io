---
layout: post
title: "c++11 constexpr + static_assert 來做 enum 測試"
description: c++11 constexpr + static_assert 來完成 enum 測試，當 enum 新增或修改時，如沒有處理使用地點，將會使其編譯錯誤。
tags: [C++, c++11, constexpr, static_assert, enum test]
comments: true
---
## 前言：

　　寫程式的時候常常會有 enum，來代表某些種類等，但如果是在多人一起合作，常常會有某些人改了一個很重要的 enum，但是改的人沒有注意到其他地方有用到這個 enum 這樣某些功能可能就會壞掉或出現不如預期的行為。本篇教學會運用 c++11 引入的 constexpr 及 static_assert 來保證使用 enum 的地方要被檢查，否則會 compile 錯誤。

## 演示：

　　首先先展示 enum.hpp 檔，內容就是一個小小的 enum。

{% highlight C++ %}
typedef enum {
    TEST_MODE_0 = 0,
    TEST_MODE_1,
    TEST_MODE_2,

    TEST_MAX,
} TEST;
{% endhighlight %}

　　再來則是 enum.cpp 檔，主要的核心就是在這裡。

{% highlight C++ %}
#include "enum.hpp"

constexpr TEST LookUpTable[] = {
    TEST_MODE_0,
    TEST_MODE_1,
    TEST_MODE_2,

    TEST_MAX,
};

constexpr bool checkEnum(TEST test) {
    return (-1 == test)
            ? true
            : LookUpTable[test] == test && checkEnum((TEST)((int)test - 1));
}

static_assert(checkEnum(TEST_MAX), "TEST enum should be synced with LookUpTable.");

int main()
{
    return 0;
}
{% endhighlight %}

　　我們知道 constexpr 為在 compile time 就能明確得知的變數，而 static_assert 則是在 compile time 就能進行驗證的方法，結合起來就可以判斷 enum 是不是有被新增或修改過。

　　主要的 function 為 checkEnum，他主要做的事情就是當走完整個 enum 就回傳正確，否則就要看一下這次的值是不是跟 enum 一樣，然後再往上比。

　　如果有一個人改了 enum.hpp 新增一項：

{% highlight C++ %}
typedef enum {
    TEST_MODE_0 = 0,
    TEST_MODE_1,
    TEST_MODE_2,
    TEST_MODE_3,

    TEST_MAX,
} TEST;
{% endhighlight %}

　　則就會因為 checkEnum(TEST_MAX) out of bound 而編譯錯誤。

　　如果有一個人修改了 enum.hpp：

{% highlight C++ %}
typedef enum {
    TEST_MODE_0 = 0,
    TEST_MODE_2,
    TEST_MODE_1,

    TEST_MAX,
} TEST;
{% endhighlight %}

　　則在 checkEnum(TEST_MAX) 會因為往上比的時候 LookUpTable[TEST_MODE_1] != TEST_MODE_2，而出錯。

　　只要在每個使用到 enum 的地方加入上面那段，就可以保證修改過列表必須要來觀看使用列表地方的 code。

　　但這也是有限制的，如果有人把列表改成這樣：

{% highlight C++ %}
typedef enum {
    TEST_MODE_0 = 0,
    TEST_MODE_1,
    TEST_MODE_2,

    TEST_MAX,

    TEST_HAHA,
} TEST;
{% endhighlight %}

　　因為只會比較 TEST_MAX 之上是不是順序都一樣且無新增，所以其實這樣是可以編譯過的，這部分就要靠 Reviewer 了，看到有人把列表加在 MAX 之下就要揪出來。

　　程式碼：[GitHub](https://github.com/npes87184/Exercise/tree/master/c_cpp/enum_test)

## 結語：

　　希望對大家有幫助，有任何問題，或是 code 有更好寫法，歡迎提出。：Ｄ
