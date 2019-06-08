---
layout: post
title: "C++ 內部如何實現多型"
description: 簡單描述 C++ 內部如何成就多型，更加認識程式語言。
tags: [Code, C++]
comments: true
---

### 前言

最近在工作上使用蠻多 C++ 的多型，有點好奇如何實作，稍微查詢一下，並稍做整理在這篇文章中。

紀錄一下，方便之後有人有相同疑問的人可以參考。

這邊先釐清一個概念，Spec 僅定義了需要有多型這樣的能力，如何實現多型是可以各顯神通的，這篇文章僅說明最常見的方法。

### vtable

C++ 替每一個有 virtual function 的 class 產生一個隱藏 member `__vptr`，這東西會指到一個表格。

這表格或者說 struct 中的每一個成員都是一個標記為 virtual 的 function 的 function pointer。我們稱這東西叫 vtable。

每個 class 的 vtable 建立原則為，每個 entry 放 most-derived 版本的 function。當 class 建立 object 時，此 ptr 將會指到自己 class 的 virtual table。

舉個例子來說，如果 code 寫成下面這樣。

```
class Base
{
public:
    virtual void function1() {}
    virtual void function2() {}
    void function3() {}
};
 
class D1: public Base
{
public:
    virtual void function1() {}
};

int main()
{
    D1 d1;
    Base *dPtr = &d1;
}
```

當這樣寫的時候，因 function1 跟 functino2 為 virtual 但 function3 不是，所以 `__vptr` struct 會長成這樣：

```
struct __vptr {
	void (*function1)();
	void (*function2)();
}
```

而 d1 的 `__vptr` 會指到 D1 的 vtable。我們可以根據上述規則填 D1 的 vtable struct。

從規則可以看出，因 function1 的 most-derived 版本為 D1，所以 function1 會指到 D1 的，而 function2 因沒有覆寫，所以還是保持原本的。大體上如下：

```
struct D1_vptr {
	function1 = D1_function1;
	function2 = base_function2;
}
```

最後因為 `__vptr` 是在 base 中就有的成員。當用 Base 來觀看 derived class 時， 還是能看到，所以能 access `__vptr`，但這個 pointer 會指到 D1 的 vtable，所以可以呼叫到正確的 function。

### Reference

1. [ref 1](https://www.learncpp.com/cpp-tutorial/125-the-virtual-table/)
2. [ref 2](https://stackoverflow.com/questions/4548145/low-level-details-of-inheritance-and-polymorphism)