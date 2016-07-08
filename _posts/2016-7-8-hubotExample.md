---
layout: post
title: "Hubot 聊天機器人簡單架設教學"
categories: [研究雜記]
tags: [Hubot, bot, chat, 聊天機器人, Line 聊天機器人]
image_description: false
description: 透過開源的 Hubot，簡單架設 Line 聊天機器人。
comments: true
published: true
---

## 概論：

　　<a href="https://github.com/github/hubot">Hubot</a> 是由 GitHub 開源的一個聊天機器人框架，因其非常方便架設使用再加上有相當高的彈性，讓想要開發聊天機器人的開發者可以專注於演算法開發，而不用思考這些系統上的問題。

　　大體上來說，Hubot 的架構如下圖：

　　<img src="{{ site.baseurl }}/image/2016-7-8/1.png">

　　最左半邊是通訊軟體，透過一個 adapter 來跟通訊軟體提供的 API 進行串接，而 Hubot 會把串接完之後的事情諸如取得訊息，傳送訊息等都完成，又常見的通訊軟體的 adapter 幾乎都有人寫了，開發者只需專注於 Script 即可。

　　如此彈性的架構，幾乎可以說是機器人架設一次，就可以透過更換 adapter 來變成不同通訊軟體的機器人，且因為是用同一架構，也可以吃同樣的 Script 大大的降低開發成本。

## 環境架設：

　　概略的說明了 Hubot 的特性之後，我們就從架設其環境開始說起吧。在此說明一下，我架設 Hubot 的環境為 OS X 10.11.5，理論上 Ubuntu 等 Linux 發行版都是沒問題的，而 Windows 我就不確定是否可以照此說明跑。

　　要使用 Hubot 要先有 <a href="https://docs.npmjs.com/getting-started/installing-node">node.js 跟 npm</a> 如果沒有安裝這兩個東西，可以先參考網頁安裝。

　　因為我們之後要透過 yo 去產生出 Hubot 我們需要先透過 npm 安裝 yo，以及 Hubot 的產生器。

{% highlight shell %}
%  npm install -g yo generator-hubot
{% endhighlight %}

　　下一步就是要產生 Hubot，我們先創造一個新資料夾，以防止產生一堆檔案不好整理。

{% highlight shell %}
% mkdir myhubot
% cd myhubot
% yo hubot
{% endhighlight %}

　　下完 yo hubot 之後，產生器會開始詢問一些問題，如機器人的名字，要使用什麼 adapter 等，如下圖：

　　<img src="{{ site.baseurl }}/image/2016-7-8/2.png">

　　到了這一步，基本上一個簡單的 shell 機器人就完成了，可以透過以下指令開啟機器人：

{% highlight shell %}
% bin/hubot
{% endhighlight %}

　　開啟之後是不是會發現不管打什麼 Hubot 都不理人？其實這是因為裡面還沒有任何 Script 的緣故，下一個部分要來講解簡單的 Script 要怎樣撰寫，來讓他看起來有點智慧！

## 撰寫 Script：

　　Hubot 的 Script 基本上是要用 coffeeScript 來撰寫，不過我個人是都用 javaScript 來寫，Hubot 的 Script 需要 export 一個函數，如下面這樣：

{% highlight JavaScript %}
module.exports = function(robot) {
 // your code here
}
{% endhighlight %}

　　再來為了要讓 Hubot 可以知道我們是在叫他，我們需要給他一個聽(hear) 的函數，如下面的例子：

{% highlight JavaScript %}
module.exports = function(robot) {
  robot.hear(/* key words */, function(response) {
    // your code here
    response.send(/* the replied message */);
  });
}
{% endhighlight %}

　　其中 key words 表示 Hubot 聽到什麼話，會執行下面的函數，這部分會使用 regular expression，所以可以讓 Hubot 去做 match，這樣只要句子中有包含某些關鍵字，他就會去執行。而 response.send(/* the replied message */); 這函數會回傳一個字串，此回傳結果就是機器人回覆在通訊軟體上的結果。

　　有了這樣的概念之後，我們就趕緊來讓 Hubot 可以跟我們問好跟打招呼吧！

{% highlight JavaScript %}
module.exports = function(robot) {
  robot.hear(/(Hello|hello|Hi|hi|你好|安安|早安|午安|晚安|哈囉|安)/, function(response) {
    re = ['Hello', 'hello', 'Hi', 'hi', '你好', '你好啊', '安安', '哈囉',response.match[1]];
    response.send(response.random(re));
  });
}
{% endhighlight %}

　　這個 Script 非常簡單，當他 match 到 Hello 等字眼的時候，會從 re 這個陣列中隨機挑選一個回覆，並且為了讓機器人有機會可以回覆早安等，讓他把 match 到的結果也放進陣列中，最後回傳的是這個陣列中的隨機一個。

　　寫完此 Script 之後把它存在剛剛建出來的目錄的 Scripts 下，如 scripts/hello.js，重新啟動 Hubot 就能跟他打招呼囉！

　　<img src="{{ site.baseurl }}/image/2016-7-8/3.png">

　　其中這些 Script 還能支援常見的 npm，這樣搭配下來能做的事情非常多，如搭配 cheerio 的話，就能讓 Hubot 在聽到如新聞，電影這類詞的時候，幫我們去某些網頁尋找關鍵內容，回傳到聊天室中，相當有可擴充性，這部分就要發揮讀者的想像力跟實力，來創造厲害的 Script 了！

## Line adapter：

　　可是這樣架完也只能夠在 shell 中自嗨。很沒有聊天機器人的感覺。為了解決這個問題，這裡也說明如何套上 Line 的 adapter 並放到 heroku 等 server 上完成 Line 的聊天機器人，其中 Line 的 adapter 我是參考此開源軟體 <a href="https://github.com/notok/hubot-line-trial">Line adapter</a>。

　　首先透過 npm 安裝 Line 的 adapter：

{% highlight shell %}
% npm install hubot-line-trial --save
{% endhighlight %}

　　再來去 Line 官方申請一個開發者帳號：

　　<a href="https://business.line.me/ja/products/4/introduction">https://business.line.me/ja/products/4/introduction</a>

　　開發者帳號中最重要的是：

* LINE_CHANNEL_ID

* LINE_CHANNEL_SECRET

* LINE_CHANNEL_MID

　　如果直接要在這個 server 中跑，那可以透過 export 把這些環境變數設定，也可以透過 env 來弄一個環境執行 Hubot。最後在弄好這些環境變數之後可以透過以下指令執行 Hubot。

{% highlight shell %}
% bin/hubot -a line-trial
{% endhighlight %}

　　如果是要放到 heroku 上跑，同樣需要設定 heroku 上的環境變數，並且更改 Procfile 為上述指令，最後再提交上去即可。

　　最後結果如下圖：

　　<img src="{{ site.baseurl }}/image/2016-7-8/4.png">

## Reference：

　　<a href="https://hubot.github.com/docs/">Hubot Documentation</a>

　　<a href="http://huli.logdown.com/posts/417258-hubot-a-bot-framework">[心得] Hubot, 一套 bot framework</a>

　　<a href="https://github.com/twtrubiks/mybot">使用Hubot建立屬於自己的機器人</a>
