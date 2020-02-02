---
layout: post
title: "pthread_cancel 與 C++ 解構子的坑"
description: 簡單描述之前工作上遇到的 phtread_cancel 與 C++ 解構子的坑。
tags: [Code, C++]
comments: true
---

### 前言

停 thread 有幾種常見的方式，其中一種就是 `pthread_cancel`，而之前工作上就是使用 `pthread_cancel` 來停 thread，
但偶爾會發現 daemon  core dump 在奇怪地方，深入研究之後發現 `pthread_cancel` 有坑，本篇簡單記錄下此坑，希望可以幫到之後的人。

### pthread_cancel 實作

POSIX 並沒有定義 `pthread_cancel` 該如何實作，可以用 signal 也可以用其他方式，比方說 exception。
而此次遇到的情況就是 `pthread_cancel` 是透過 exception 實作的。

### c++ 解構子

在 c++ 11 之後，所有解構子預設都是 `noexcept(true)`。

### pthread_cancel 加上 c++ 解構子

既然 `pthread_cancel` 是透過 exception 實作的，那如果碰上程式正在執行 `noexcept(true)` 部份 （比方說解構子）會發生什麼事情呢？

答案是會觸發 `std::terminate()`，從 [cppreference](https://en.cppreference.com/w/cpp/error/terminate) 中指出 `std::terminate()` 將會被呼叫如果

> a noexcept specification is violated

最終造成 core dump。

### 例子

```c++
#include <unistd.h>
#include <pthread.h>

#include <iostream>

class TestClass {
public:
	~TestClass() {
		sleep(3);
	}
};

void *ThreadFunc(void *)
{
	{
		TestClass c;
	}
	pthread_exit(nullptr);
}

int main()
{
	pthread_t t;
	pthread_create(&t, nullptr, ThreadFunc, nullptr);
	sleep(1);
	pthread_cancel(t);
	pthread_join(t, nullptr);
	return 0;
}
```

並且使用以下 command 編譯

```shell
g++ --std=c++17 -pthread -o pthread_test pthread_test.cp
```

之後執行 `pthread_test` 就會發生以上的 core dump。

### Reference

1. [stackoverflow](https://stackoverflow.com/questions/59082973/terminate-called-without-an-active-exception-after-pthread-cancel)
2. [gcc mailing list](https://gcc.gnu.org/ml/gcc-help/2015-08/msg00040.html)
