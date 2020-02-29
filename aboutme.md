---
layout: page
title: About me
subtitle: I seek not to know only answers, but to understand the questions.
css: "/css/aboutme.css"
---
<script async defer src="https://buttons.github.io/buttons.js"></script>

Hi, I'm <strong>Yu-Chen Lin</strong>. A software engineer experienced in building reliable and flexible virtualization infrastructure solutions.

<h1>Experiences</h1>

<p class="about-text">
<span class="fa fa-briefcase about-icon"></span>
Working as a Software Engineer in <strong>Synology</strong>. We are building reliable and flexible virtualization infrastructure solutions on DiskStation Manager (DSM, An operating system that Synology developed). 2016 ~ Now
</p>

### Main contributions:

* Independent designed and implemented a license system for Synology Virtual Machine Manager.
* Cooperated with Active backup team to provide the ability of instant restore to Synology Virtual Machine Manager in Active Backup for Business.
* Experienced in the design and implementation of Virtual Machine and Virtual Machine Cluster.
* Integrated Virtual DSM into Synology Demo Site.
* Designed and implemented Virtual Machine Manager public API.

### Highlight:

* Improved the performance of importing/exporting VM by modifying QEMU. We save 48% time in importing and 38% time in exporting. It also reduces the extra space requirement.
* Improved the performance of company's internal automated testing framework about 9% without modifying CI testing code by letting it be able to run TestSuite parallelly.
* It has been more than a year since the Synology Demo Site was integrated into the Virtual DSM independently, and it has been operating stably without any problems.

<p class="about-text">
<span class="fa fa-briefcase about-icon"></span>
In early 2016, I was an intern on <strong>Potentia</strong>. We built a simple chat bot by using Hubot. I’m responsible for surveying and constructing a Hubot environment which can be simply deployed.
</p>

<p class="about-text">
<span class="fa fa-briefcase about-icon"></span>
In 2015 summer, I was an intern on <strong>ITRI</strong>. In this time, we built a simple song recommender system. I’m responsible for measuring the similarity between each song in this project.
</p>

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
In emulation area, I found QEMU would use an uninitialized variable which will cause core-dump in some special settings when using vhost-scsi-pci. In addition, I fixed an unexpected behavior on e1000 which will cause Windows VM hangs on booting sometimes.

On the other hand, I fixed several bugs in virtual disk formats. In virtual disk format vmdk, I found there are some problems about creating vmdk in corner case. It affects all QEMU based hypervisor in the world to produce a correct OVA for deploying virtual machine. I also fixed the wrong reading behavior on dmg format, QEMU can correctly read apple disk image now.

Additionally, I repaired a compatible issue between noVNC and qemu in websocket.
</p>

### edk2/OvmfPkg <a class="github-button" href="https://github.com/tianocore/edk2" data-show-count="true" aria-label="Star tianocore/edk2 on GitHub">Star</a>

<p class="about-contribution-text">
OVMF is an EDK II based project to enable UEFI support for Virtual Machines. OVMF contains sample UEFI firmware for QEMU and KVM.
</p>

<p class="about-contribution-text">
I rewrote the VMWare SVGA driver in OVMF, all virtual machines using OVMF with -device vmware-svga in QEMU in the world will use it.
</p>

### scrcpy <a class="github-button" href="https://github.com/Genymobile/scrcpy" data-show-count="true" aria-label="Star Genymobile/scrcpy on GitHub">Star</a>

<p class="about-contribution-text">
scrcpy provides display and control of Android devices connected on USB (or over TCP/IP).
</p>

<p class="about-contribution-text">
In scrcpy, I implemented some useful features, including drag&drop to transfer file, detection adb when executing, etc. I also fixed some potential resource leaks and added some unittest.
</p>

### qr-filetransfer <a class="github-button" href="https://github.com/sdushantha/qr-filetransfer" data-show-count="true" aria-label="Star sdushantha/qr-filetransfer on GitHub">Star</a>

<p class="about-contribution-text">
Transfer files over WiFi from your computer to your smartphone from the terminal
</p>

<p class="about-contribution-text">
I am a <strong>collaborator</strong> of this project. In this project, I totally rewrote the core part. I also implemented the upload file server and several minor fixs.
</p>

### And more...

<p class="about-contribution-text">
I also contributed to many other open source projects! For more detail, check my <a href="https://github.com/npes87184">GitHub</a>.
</p>

* <a class="github-button" href="https://github.com/topjohnwu/magisk" data-show-count="true" aria-label="Star topjohnwu/magisk on GitHub">Star</a> Magisk
* <a class="github-button" href="https://github.com/GravityBox/GravityBox" data-show-count="true" aria-label="Star GravityBox/GravityBox on GitHub">Star</a> GravityBox
* <a class="github-button" href="https://github.com/dddomodossola/remi" data-show-count="true" aria-label="Star dddomodossola/remi on GitHub">Star</a> remi
* <a class="github-button" href="https://github.com/Angads25/android-filepicker" data-show-count="true" aria-label="Star Angads25/android-filepicker on GitHub">Star</a> android-filepicker
* <a class="github-button" href="https://github.com/yanyiwu/cppjieba" data-show-count="true" aria-label="Star yanyiwu/cppjieba on GitHub">Star</a> cppjieba
* <a class="github-button" href="https://github.com/daattali/beautiful-jekyll" data-show-count="true" aria-label="Star daattali/beautiful-jekyll on GitHub">Star</a> beautiful-jekyll
* etc

<h1>Projects</h1>

<p class="about-text">
<span class="fa fa-file-text-o about-icon"></span>
This is a collection of some personal projects I’ve worked.
</p>

### S2TDroid <a class="github-button" href="https://github.com/npes87184/S2TDroid" data-show-count="true" aria-label="Star npes87184/S2TDroid on GitHub">Star</a>

<p class="about-contribution-text">
An android app for transforming between Simplified Chinese and Traditional Chinese.
</p>

* More than 20,000 downloads.
* More than 4,500 live users.
* Score 4.7/5 in google play.

### ScreenShareTile <a class="github-button" href="https://github.com/npes87184/ScreenShareTile" data-show-count="true" aria-label="Star npes87184/ScreenShareTile on GitHub">Star</a>

<p class="about-contribution-text">
Take a screenshot and share it quickly from Android quick setting tile.
</p>

### PokeDict <a class="github-button" href="https://github.com/npes87184/PokeResearchDictionary" data-show-count="true" aria-label="Star npes87184/PokeResearchDictionary on GitHub">Star</a>

* Gone to rank first in tool category of Google Play when it first released.
* More than 10,000 downloads.
* Score 4.6/5 in google play.
* Has a web interface for showing pokemon mission as well as reporting new mission by user.

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

<p>You can <a href="mailto:npes87184@gmail.com?subject=Hello from npes87184.github.io">email me</a> or find me on <a href="https://www.linkedin.com/in/yu-chen-lin-2813b5101/">Linkedin.</a> if you want to get in touch.
