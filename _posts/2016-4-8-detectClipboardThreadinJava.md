---
layout: post
title: "Java 自動偵測剪貼簿"
categories: [演算法]
tags: [Java]
image_description: false
description: 運用 Java 實作一個 Thread 每隔一段時間自動偵測剪貼簿內容。
comments: true
published: true
---

## Motivation：

　　主要是最近 Ptt 的 CFantasy <a href="https://www.ptt.cc/bbs/CFantasy/M.1459536539.A.733.html">有篇文章</a>提到了幾個抓小說軟體的優缺點，其中有我有貢獻過代碼的軟體，被點評沒有偵測剪貼簿不夠給力，所以當天就研究了一下。

## Task：

　　主要需要做的事情就是：

　　1. 為了不要卡住主要 UI，需要額外有一個 Thread 重複的每隔一段時間去監視剪貼簿

　　2. 實作剪貼簿取得的方法

　　3. 偵測到之後要如何處理

## Method：

　　把上述的事情轉成程式碼其實不會很困難，這邊直接貼上程式碼並附上註解。

{% highlight Java %}
// 上述所說的額外的一個新 Thread 並且實作 Runnable，裡面就是每隔一段時間去執行 DateTask。
class DetectClipboardThread extends Thread implements Runnable {
	
	public void run() {
		Timer timer = new Timer();
		// check every 2 seconds
		timer.schedule(new DateTask(), 1000, 2000); 
	}
}

// 每次執行 DateTask，就去取剪貼簿的內容，如果內容包含 XXX 就做某些事情。
class DateTask extends TimerTask {
	
	DetectClipboard dc = new DetectClipboard();
	
	@Override
	public void run() {
		if(dc.getClipboard().contains("XXX")) {
			// do something
		}
	}
}

// 這裡 implement 了剪貼簿相關的東西，其中最重要就是 getClipboard() 這個 method。
public class DetectClipboard implements ClipboardOwner {
    private Clipboard clipboard;

    public DetectClipboard() {
    	DetectClipboard_init();
    }

    public void DetectClipboard_init(){
        clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
    }

    /**
     * get Clipboard
     * @return
     */
    public String getClipboard(){
        Transferable content = clipboard.getContents(this);
        try{
            return (String) content.getTransferData(DataFlavor.stringFlavor);
        }catch(Exception e){
            e.printStackTrace();
            //System.out.println(e);
        }
        return null;
    }
    
    public void lostOwnership(Clipboard clipboard, Transferable contents) {
        //System.out.println("lostOwnership...");
    }
}
{% endhighlight %}

　　如此就完成了自動偵測剪貼簿的功能了！

　　最後附上當時丟出去的 <a href="https://github.com/pupuliao/JNovelDownloader/pull/7">commit</a>。
