---
layout: page
title: About me
subtitle: I seek not to know only answers, but to understand the questions.
css: "/css/aboutme.css"
---
<script async defer src="https://buttons.github.io/buttons.js"></script>

Hi, I'm Yu-Chen Lin. A software engineer who enjoy the beauty of the code.

# Community Contributions

<p class="about-text">
<span class="fa fa-code about-icon"></span>
Enjoy joining <strong>open source community</strong> to help others. In the past several years I've contributed to many open source projects.
</p>

### QEMU <a class="github-button" href="https://github.com/qemu/qemu" data-show-count="true" aria-label="Star qemu/qemu on GitHub">Star</a>

<p class="about-contribution-text">
QEMU is a generic and open source machine emulator and virtualizer.
</p>

<p class="about-contribution-text">
I found QEMU would use an uninitialized variable which will cause core-dump in some special settings when using vhost-scsi-pci. In addition, I fixed bugs in vmdk to prevent creating bad vmdk. It affects all QEMU based hypervisor in the world to produce a correct OVA for deploying virtual machine.
</p>
* [vhost-scsi: prevent using uninitialized vqs](https://github.com/qemu/qemu/commit/e6cc11d64fc998c11a4dfcde8fda3fc33a74d844) <em style="color: green;">merged</em>
* [vga_int: remove unused function protype](https://github.com/qemu/qemu/commit/e69a10f468d8f6aa6c00a4308f5a8e1f2fd6b3a1) <em style="color: green;">merged</em>
* [vmdk: align end of file to a sector boundary](https://github.com/qemu/qemu/commit/51b3c6b73acae1e3fd3c7d441fc86dd17356695f) <em style="color: green;">merged</em>
* [docs/usb2.txt: ehci has six ports](https://github.com/qemu/qemu/commit/95c94f8968325390d63b3c407584e91e6d7fb010) <em style="color: green;">merged</em>
* [vmdk: return ERROR when cluster sector is larger than vmdk limitation](https://github.com/qemu/qemu/commit/a77672ea3d95094a0cb4f974de84fb7353c67cc0) <em style="color: green;">merged</em>

### edk2/OvmfPkg <a class="github-button" href="https://github.com/tianocore/edk2" data-show-count="true" aria-label="Star tianocore/edk2 on GitHub">Star</a>

<p class="about-contribution-text">
OVMF is an EDK II based project to enable UEFI support for Virtual Machines. OVMF contains sample UEFI firmware for QEMU and KVM.
</p>

<p class="about-contribution-text">
I rewrote VMWare SVGA driver in OVMF, which will affect all virtual machines using OVMF with -std vmsvga in QEMU in the world.
</p>
* [OvmfPkg: simply use the Bochs interface for vmsvga](https://lists.01.org/pipermail/edk2-devel/2018-November/032100.html) <em style="color: orange;">reviewed</em>
* [Revert "OvmfPkg: VMWare SVGA display device register definitions"](https://github.com/tianocore/edk2/commit/328409ce8de7f318ee9c929b64302bd361cd1dbd#diff-76767f2fe9e8f4acca7cbeb049bc8152) <em style="color: green;">merged</em>
* [Revert "OvmfPkg/QemuVideoDxe: Helper functions for unaligned port I/O."](https://github.com/tianocore/edk2/commit/438ada5aa5a1174940795678c2dae07cde8f3869#diff-76767f2fe9e8f4acca7cbeb049bc8152) <em style="color: green;">merged</em>
* [Revert "OvmfPkg/QemuVideoDxe: VMWare SVGA device support"](https://github.com/tianocore/edk2/commit/98856a724c2acdc0094220d4de615a557dad0f88#diff-76767f2fe9e8f4acca7cbeb049bc8152) <em style="color: green;">merged</em>
* [Revert "OvmfPkg/QemuVideoDxe: list "UnalignedIoInternal.h" in the INF file"](https://github.com/tianocore/edk2/commit/e038bde2679bbd200086c25ab43090ad3b8b25a3#diff-76767f2fe9e8f4acca7cbeb049bc8152) <em style="color: green;">merged</em>

### scrcpy <a class="github-button" href="https://github.com/Genymobile/scrcpy" data-show-count="true" aria-label="Star Genymobile/scrcpy on GitHub">Star</a>

<p class="about-contribution-text">
scrcpy provides display and control of Android devices connected on USB (or over TCP/IP).
</p>

<p class="about-contribution-text">
In scrcpy, I implemented some useful features, including drag&drop to transfer file, detection adb when executing, etc. I also fixed some potential resource leaks.
</p>

* [input_manager: fix potential memory leak on text](https://github.com/Genymobile/scrcpy/commit/96056e3213b9f142cc39672186290b7495c1e0dd) <em style="color: green;">merged</em>
* [prevent closing console right after process error in windows](https://github.com/Genymobile/scrcpy/commit/140b1ef6a5f2de489f99c6f7f63dc2a49bc404f6) <em style="color: green;">merged</em>
* [Use specific error for missing binary on Windows](https://github.com/Genymobile/scrcpy/commit/27bed948d4ddfffbb6ea5ad80a2a58394fa96b75) <em style="color: green;">merged</em>
* [Notify adb missing](https://github.com/Genymobile/scrcpy/commit/6d2d803003c231df9df3343eb73edf97d9ac3c76) <em style="color: green;">merged</em>
* [Support drag&drop a file to transfer it to device](https://github.com/Genymobile/scrcpy/commit/66f45f9dae6a9c1a6845c4c87377c9bc235edd7f) <em style="color: green;">merged</em>
* [installer -> file_handler](https://github.com/Genymobile/scrcpy/commit/aa97eed24b7571c1c30026528eceba15f382a862) <em style="color: green;">merged</em>
* [Destroy mutex if strdup failed](https://github.com/Genymobile/scrcpy/commit/a3ab92226d96669e10b659bf559e50e64fe4a205) <em style="color: green;">merged</em>
* [remove redundant semicolon](https://github.com/Genymobile/scrcpy/commit/f8ef4f1cf77584541a001c9e22f5add32f71ded4) <em style="color: green;">merged</em>

### GravityBox <a class="github-button" href="https://github.com/GravityBox/GravityBox" data-show-count="true" aria-label="Star GravityBox/GravityBox on GitHub">Star</a>

<p class="about-contribution-text">
All-in-one tweak box - Xposed module for devices running AOSP.
</p>

<p class="about-contribution-text">
In this project, I put the AM/PM to the left of the clock by habits in Chinese area.
</p>

* [put am/pm to the left of clock in Chinese area](https://github.com/GravityBox/GravityBox/commit/bbc91e01a3d7681a0c4bc34c32195a7576eda2c0) <em style="color: green;">merged</em>

### Magisk <a class="github-button" href="https://github.com/topjohnwu/Magisk" data-show-count="true" aria-label="Star topjohnwu/Magisk on GitHub">Star</a>

<p class="about-contribution-text">
Magisk is a suite of open source tools for customizing Android.
</p>

<p class="about-contribution-text">
I fixed some potential resource leaks and memory overwrite in Magisk.
</p>

* [utils/misc.c: prevent file staying opened when function leaving](https://github.com/topjohnwu/Magisk/commit/0ab6ffefb43c38aa036e7368454a89807bfef9f7) <em style="color: green;">merged</em>
* [Prevent setting zero over than bound](https://github.com/topjohnwu/Magisk/commit/312466aaf82084b8abbbf99f6751310521f6ef64) <em style="color: green;">merged</em>

### And more...

<p class="about-contribution-text">
I also contributed to many smaller open source projects! For more detail, check my <a href="https://github.com/npes87184">GitHub</a>.
</p>

* <a class="github-button" href="https://github.com/pupuliao/JNovelDownloader" data-show-count="true" aria-label="Star pupuliao/JNovelDownloader on GitHub">Star</a> [JNovelDownloader](https://github.com/pupuliao/JNovelDownloader)
* <a class="github-button" href="https://github.com/Angads25/android-filepicker" data-show-count="true" aria-label="Star Angads25/android-filepicker on GitHub">Star</a>[android-filepicker](https://github.com/Angads25/android-filepicker)
* <a class="github-button" href="https://github.com/sh1r0/NovelDroid" data-show-count="true" aria-label="Star sh1r0/NovelDroid on GitHub">Star</a>[NovelDroid](https://github.com/sh1r0/NovelDroid)
* <a class="github-button" href="https://github.com/yanyiwu/cppjieba" data-show-count="true" aria-label="Star yanyiwu/cppjieba on GitHub">Star</a>[cppjieba](https://github.com/yanyiwu/cppjieba)
* <a class="github-button" href="https://github.com/qichuan/android-opencc" data-show-count="true" aria-label="Star qichuan/android-opencc on GitHub">Star</a>[android-opencc](https://github.com/qichuan/android-opencc)
* <a class="github-button" href="https://github.com/daattali/beautiful-jekyll" data-show-count="true" aria-label="Star daattali/beautiful-jekyll on GitHub">Star</a>[beautiful-jekyll](https://github.com/daattali/beautiful-jekyll)
* etc

<h1>Projects</h1>

<p class="about-text">
<span class="fa fa-file-text-o about-icon"></span>
This is a collection of some personal projects I’ve worked.
</p>

### S2TDroid <a class="github-button" href="https://github.com/npes87184/S2TDroid" data-show-count="true" aria-label="Star npes87184/S2TDroid on GitHub">Star</a>

<p class="about-contribution-text">
An android app for transforming Simplified Chinese to Traditional Chinese.
</p>

* More than 20,000 downloads.
* Score 4.6/5 in google play.

### PokeDict <a class="github-button" href="https://github.com/npes87184/PokeResearchDictionary" data-show-count="true" aria-label="Star npes87184/PokeResearchDictionary on GitHub">Star</a>

* Gone to rank first in tool category of Google Play when it first released.
* More than 9,900 downloads.
* Score 4.6/5 in google play.

<h1>Experiences</h1>

<p class="about-text">
<span class="fa fa-briefcase about-icon"></span>
Working as a Software Engineer in <strong><a href="https://www.synology.com/en-global">Synology</a></strong>. We are building reliable and flexible virtualization infrastructure solution. 2016 ~ Now
</p>

<p class="about-text">
<span class="fa fa-briefcase about-icon"></span>
In early 2016, I was an intern on <strong><a href="http://potentia.asia/">Potentia</a></strong>. We built a simple chat bot by using Hubot. I’m responsible for surveying and constructing a Hubot environment which can be simply deployed.
</p>

<p class="about-text">
<span class="fa fa-briefcase about-icon"></span>
In 2015 summer, I was an intern on <strong><a href="https://www.itri.org.tw/">ITRI</a></strong>. In this time, we built a simple song recommender system. I’m responsible for measuring the similarity between each song in this project.
</p>

<h1>Edutcation</h1>

<p class="about-text">
<span class="fa fa-graduation-cap about-icon"></span>
M.S. in DSP group, CMLab, CSIE, <strong>National Taiwan University</strong>. 2014 ~ 2016
</p>

<p class="about-text">
<span class="fa fa-graduation-cap about-icon"></span>
B.S. in Applied Mathematicals, <strong>National Chung Hsing University</strong>. 2010 ~ 2014
</p>

<div id="contactme-section">
<h1 id="contact">Contact</h1>

<!--
<div class="alert alert-danger" role="alert">
I will be away until Feb 6, with very limited time to work. My responses will be slow during this period.
</div>
-->



<p>You can <a href="mailto:npes87184@gmail.com?subject=Hello from npes87184.github.io">email me</a> or find me <a href="https://www.facebook.com/npes87184">on Facebook</a> if you want to get in touch.
<form action="https://formspree.io/npes87184@gmail.com" method="POST" class="form" id="contact-form">
  <p>You can also send me a quick message using the form below:</p>
  <div class="row">
    <div class="col-xs-6">
      <input type="email" name="_replyto" class="form-control input-lg" placeholder="Email" title="Email">
    </div>
    <div class="col-xs-6">
      <input type="text" name="name" class="form-control input-lg" placeholder="Name" title="Name">
    </div>
  </div>
  <input type="hidden" name="_subject" value="New submission from deanattali.com">
  <textarea type="text" name="content" class="form-control input-lg" placeholder="Message" title="Message" required="required" rows="3"></textarea>
  <input type="text" name="_gotcha" style="display:none">
  <input type="hidden" name="_next" value="./aboutme?message=Your message was sent successfully, thanks!" />
  
  <button type="submit" class="btn btn-lg btn-primary">Submit</button>
</form>
