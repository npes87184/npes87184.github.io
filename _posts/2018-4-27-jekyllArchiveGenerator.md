---
layout: post
title: "在 GitHub Page 中新增 Archive"
description: 簡單運用 Jekyll Liquid 來產出 GitHub Page 部落格的 Archive。
tags: [Jekyll, GitHub Page, Code]
comments: true
---
看到別人的部落格都有美美的 Archive 就萌生在自己的 GitHub Page 中也產出一個的想法。

簡單研究一下發現要在 Jekyll 中實現並不難。大體上想法就是列出所有的文章的日期，再根據日期分，每一年都產出一個 Header，並在下面用 a tag 來產出文章連結。

簡單實現如下：
{% highlight liquid linenos %}
{% raw %}
{% for post in site.posts %}
  {% assign currentDate = post.date | date: "%Y" %}
  {% if currentDate != myDate %}
      {% unless forloop.first %}</ul>{% endunless %}
      <h1>{{ currentDate }}</h1>
      <ul>
      {% assign myDate = currentDate %}
  {% endif %}
  <li><a href="{{ post.url }}"><span>{{ post.date | date: "%B %-d, %Y" }}</span> - {{ post.title }}</a></li>
  {% if forloop.last %}</ul>{% endif %}
{% endfor %}{% endraw %} 
{% endhighlight %}

最終結果：

------

# 2018
      
  <li><a href="/2018-04-17-PyM3UGenerator/"><span>April 17, 2018</span> - Walkman 播放清單</a></li> 
  <li><a href="/2018-03-04-zx300WithCKR100/"><span>March 4, 2018</span> - ZX300 + CKR100 心得</a></li>
  
# 2017
      
  <li><a href="/2017-07-30-TheCruelWorld/"><span>July 30, 2017</span> - 百元分配問題</a></li>
  <li><a href="/2017-05-06-vim8/"><span>May 6, 2017</span> - vim 8 升級紀錄</a></li>
  <li><a href="/2017-03-11-EnumTest/"><span>March 11, 2017</span> - c++11 constexpr + static_assert 來做 enum 測試</a></li>
  
# 2016 
  
  <li><a href="/2016-11-11-fitbitCharger2/"><span>November 11, 2016</span> - fitbit charger 2 開箱</a></li>
  <li><a href="/2016-07-08-hubotExample/"><span>July 8, 2016</span> - Hubot 聊天機器人簡單架設教學</a></li>
  <li><a href="/2016-05-09-GooglePlayonReceivedSslError/"><span>May 9, 2016</span> - Google Play onReceivedSslError 安全性警示</a></li>
  <li><a href="/2016-04-08-detectClipboardThreadinJava/"><span>April 8, 2016</span> - Java 自動偵測剪貼簿</a></li>
  
# 2015
      
  <li><a href="/2015-11-25-WhatIsCSIE/"><span>November 25, 2015</span> - 資工系在學什麼？</a></li>
  <li><a href="/2015-11-21-DuckySecretRGB/"><span>November 21, 2015</span> - Ducky Secret RGB 滑鼠開箱</a></li>
  <li><a href="/2015-10-07-ImageBlur/"><span>October 7, 2015</span> - Image Blur</a></li>
  <li><a href="/2015-09-25-JointEncryptCompressionChaotic/"><span>September 25, 2015</span> - Chaos-Based Joint Compression and Encryption</a></li>
  <li><a href="/2015-09-12-linkedListSort/"><span>September 12, 2015</span> - Linked List Sort</a></li>
  <li><a href="/2015-09-05-interviewShare/"><span>September 5, 2015</span> - 群暉及聯發科研替面試分享</a></li>
  <li><a href="/2015-08-23-raceCondition/"><span>August 23, 2015</span> - Race Condition</a></li>
  <li><a href="/2015-08-16-waterVSdataHiding/"><span>August 16, 2015</span> - Watermarking VS Data Hiding</a></li>
  <li><a href="/2015-08-10-macInternetAdapter/"><span>August 10, 2015</span> - Macbook thunderbolt 網路轉接頭開箱</a></li>
  <li><a href="/2015-08-08-tradition2simple/"><span>August 8, 2015</span> - 繁簡轉換實現 by Java</a></li>
  <li><a href="/2015-08-04-csie/"><span>August 4, 2015</span> - 第一次跨考資工所就上手!</a></li>
  <li><a href="/2015-08-01-hello-world/"><span>August 1, 2015</span> - Hello World!</a></li>

------

Live Demo 可以直接參考本部落格的 <strong>[Archive]({{ site.url }}/archive)</strong>。

附上當時的 <strong>[Commit](https://github.com/npes87184/npes87184.github.io/commit/3b63b94cca5d41595888c23a059d339f4b75ffd1)</strong> 有興趣可以參考看看。
