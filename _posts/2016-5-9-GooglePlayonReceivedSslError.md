---
layout: post
title: "Google Play onReceivedSslError 安全性警示"
categories: [演算法]
tags: [Android, onReceivedSslError]
image_description: false
description: 解決 Google Play onReceivedSslError 安全性警示
comments: true
published: true
---

## Motivation：

　　最近為了替自己的 APP 提供 Paypal 捐贈功能，在 APP 中使用了 webview。但是上架沒多久就被 Google Play 警告這樣實作不安全等，如下圖。

　　<img src="{{ site.baseurl }}/image/2016-5-9/1.png">

## Task：

　　解決這個問題。

## Method：

　　研究了一下之後再 stackoverflow 中找到這個註解：

> The problem is in your code. When you call handler.proceed(); like that, it effectively removes all the security from your connection.
> You should remove your onReceivedSslError method. The default implementation will reject insecure connections.

　　找到方法之後就是要改 code 了，以下附上我改的地方作為參考。

{% highlight Java %}
mWebView.setWebViewClient(new WebViewClient() {
    @Override
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        //設置點擊網頁裡面的鏈接還是在當前的webview裡跳轉
        view.loadUrl(url);
        return true;
    }
    // remove thie override
    /*
    @Override
    public void onReceivedSslError(WebView view,
                                   SslErrorHandler handler, android.net.http.SslError error) {
        //設置webview處理https請求
        handler.proceed();
    }
    */
 });
{% endhighlight %}

　　如此就解決這個問題了！

　　最後附上當時丟出去的 <a href="https://github.com/npes87184/S2TDroid/commit/9dda7ce3080b625bc3ae09b78c32c0c960556ad7">commit</a>。

## Reference：

　　<a href="http://stackoverflow.com/questions/35218775/google-play-warning-webviewclient-onreceivedsslerror-handler">stackoverflow</a>
