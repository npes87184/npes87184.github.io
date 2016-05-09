---
layout: post
title: "繁簡轉換實現 by Java"
categories: [演算法]
tags: [繁簡轉換, Android, Java, HashMap]
image_description: false
description: 透過 Java 實現繁簡轉換並講解其中 code
comments: true
published: true
---

_因為本篇文章有許多 Code 建議使用電腦觀看_

## 1.前言：　　
　　　　這個 library 其實一開始並不是我寫的，是 <a href="http://www.pupuliao.info/jnoveldownloader-小說下載器/">JNovelDownloader</a> 的作者 **pupuliao** 所寫的，之前偶然看到才把它拿過來稍微改寫，並弄成 Android APP 版本，這篇文章主要會講解繁簡轉換的思路，也就是這份 Library 背後的想法，透過了解背後的意義，之後如果想要寫成其他語言版本（如 c/c++）相信應該不會太難。

## 2.思路：　　
　　　　如果有人給了一份如下列這樣的繁簡對應表，那聰明的讀者們應該都會想到如何解決這個問題吧？
		{% highlight Java %}
		// 繁體
"「」萬與醜專業叢東絲丟兩嚴喪個爿豐臨為麗舉麼義烏樂喬習鄉書買亂爭於虧雲亙亞產畝親褻嚲億僅從侖倉儀們價眾優夥會傴傘偉傳傷倀倫傖偽佇體餘傭"
        {% endhighlight %}
		{% highlight Java %}
		// 簡體
"“”万与丑专业丛东丝丢两严丧个丬丰临为丽举么义乌乐乔习乡书买乱争于亏云亘亚产亩亲亵亸亿仅从仑仓仪们价众优伙会伛伞伟传伤伥伦伧伪伫体余佣"
        {% endhighlight %}

　　　　沒錯，學過基礎資料結構的人都能夠想到使用 Linear Search。

　　　　以下是 Linear Search 的 Pseudo code：
{% highlight Java %}
char s2t(char wantFind) {
    for(int i = 0;i<simple.length();++i) {
        if(wantFind==simple[i]) {
            return traditional[i];
        }
    }
    return null;
}
{% endhighlight %}

　　　　到這裡問題似乎解決了？

　　　　如果需要轉換的文字並不多，或許勉強可以使用。但是如果細想就會問題還是有的，首先完整的繁簡對應表字非常多（超過2500字），再者如果遇到要轉換小說這種字數超級多的文件檔，那速度會太慢。這時候就要來思考到底怎樣才可以加速轉換。其實這個演算法主要的問題點在於需要 Linear Search，在這裡花了太多時間了，並且我們注意到繁簡字表是一一對應的，所以我們可以使用 Key-Value 的 Map 形式來提升相當多的速度，比方說，我們可以讓 key 是“万”而 value 則是“萬”，之後查找只要丟 key 就能快速得到對應的繁體。故在這裡主要的實現方式是使用 **HashMap**。

## 3.Code：

{% highlight Java %}
import java.util.HashMap;
import java.util.Map;

/**
 * Created by npes87184 on 2015/4/10.
 */
public class Analysis {

    public Analysis() {

    }

    public static String StoT(String data) {
        return translate(data, S2T);
    }

    public static String TtoS(String data) {
        return translate(data, T2S);
    }

    private static final Map<Character, Character> T2S = new HashMap();
    private static final Map<Character, Character> S2T = new HashMap();
    static {
        final char[] UTF8T = "繁體字表"
                .toCharArray();
        ;
        final char[] UTF8S = "簡體字表"
                .toCharArray();
        ;

        for (int i = 0, n = Math.min(UTF8T.length, UTF8S.length); i < n; ++i) {
            final Character cT = Character.valueOf(UTF8T[i]);
            final Character cS = Character.valueOf(UTF8S[i]);
            T2S.put(cT, cS);
            S2T.put(cS, cT);
        }
    }

    private static String translate(String text,
                                    Map<Character, Character> dictionary) {
        final char[] chars = text.toCharArray();
        for (int i = 0, n = chars.length; i < n; ++i) {
            final Character found = dictionary.get(chars[i]);
            if (null != found)
                chars[i] = found;
        }
        return String.valueOf(chars);
    }
}

{% endhighlight %}

　　　　如果仔細去 trace 的話，就會發現其實這個 Code 本身就已經自己解釋自己了。下面的部分會簡單的講解一下細節。

{% highlight Java %}
private static final Map<Character, Character> T2S = new HashMap();
private static final Map<Character, Character> S2T = new HashMap();
static {
    final char[] UTF8T = "繁體字表"
            .toCharArray();
    ;
    final char[] UTF8S = "簡體字表"
            .toCharArray();
    ;

    for (int i = 0, n = Math.min(UTF8T.length, UTF8S.length); i < n; ++i) {
        final Character cT = Character.valueOf(UTF8T[i]);
        final Character cS = Character.valueOf(UTF8S[i]);
        T2S.put(cT, cS);
        S2T.put(cS, cT);
    }
}
{% endhighlight %}

　　　　上面這段主要是先行作業，先宣告兩個 HashMap，然後把字表中全部的東西都塞進去，以 S2T 為例，我的 key 就是簡體的，而 value 則是繁體那邊的字元，這樣之後要尋找的時候只要丟簡體，就能快速吐出繁體來。

{% highlight Java %}
private static String translate(String text,
                                Map<Character, Character> dictionary) {
    final char[] chars = text.toCharArray();
    for (int i = 0, n = chars.length; i < n; ++i) {
        final Character found = dictionary.get(chars[i]);
        if (null != found)
            chars[i] = found;
    }
    return String.valueOf(chars);
}
{% endhighlight %}

　　　　接下來這個 method 是演算法的核心，他接受一串字串跟一個字典（HashMap），先把字串轉字元陣列之後一個字一個字的丟入 HashMap 中並驗證拿回來的 value 是否有效，如果有效就一一替換，沒有找到就維持原樣，最後再回傳轉換完成的字串回去。

　　　　透過 HashMap 實現的繁簡轉換速度相當快，即使是 1 mb 大小的文字檔，在效能相對弱的手機上也只需要幾秒鐘就可以轉換完成！

## 4.實例：

　　　　除了原本就在使用的 JnovelDownloader 之外，這個繁簡轉換 Library，也有 APP 版本的上架，如上面所說，轉換速度相當快，有興趣的話可以去抓來玩玩看。

　　　　<img src="{{ site.baseurl }}/image/2015-8-8/S2TDroid.PNG">
        
　　　　[![Get it on Google Play](http://www.android.com/images/brand/get_it_on_play_logo_small.png)](https://play.google.com/store/apps/details?id=com.npes87184.s2tdroid)

<br>
　　　　最後，本次教學的 Code 都可以在 GitHub 中找到，想要使用或有興趣都可以去看看。

　　　　<a class="btn btn-default" href="https://github.com/npes87184/S2TDroid/blob/master/app/src/main/java/com/npes87184/s2tdroid/Analysis.java">Grab code now!</a>

## 5.Reference：

　　　　<a href="https://github.com/pupuliao/JNovelDownloader">JNovelDownloader</a>

