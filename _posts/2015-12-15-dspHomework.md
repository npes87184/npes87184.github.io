---
layout: post
title: "DSP Program Homework SPEC"
categories: []
tags: []
image_description: false
description: To have hands-on experience on dictionary learning. Compare the results of MOD and K-SVD. 
comments: true
published: true
---

## Motivation：

　　<font size="3">To have hands-on experience on dictionary learning. Compare the results of MOD and K-SVD.</font>

## Task：

　　<font size="3">* texture segmentation.</font>

　　<font size="3">* Number of texture classes: 2 (woods and plants).</font>

　　<font size="3">* Number of training images: 9 in the plants class and 7 in the woods class.</font>

　　<font size="3">* Test image: 8 for each class.</font>

## Method：

1.	[Training] Separate the images into  (pixels  pixels) patches (eg., =12 is suggested in the cvpr08 paper). These patches (or blocks) are overlapping, so that many patches are used for training. More training samples usually result in better testing results. However, if the training patches are too many, the training time will be long. This is a tradeoff. Suggested pixel steps is from 2 to 6.

2.	[Training] Pre-processing: Gaussian Mask + [Laplacian filter]({% post_url 2015-10-7-ImageBlur %}) for each block (suggested in [cvpr08]), or none

3.	[Training] Train a dictionary for each class by using the following two methods:

	A.	MOD

	B.	K-SVD

4.	 [Testing] use a d*d window to scan the image. At each scanned position, represent the window based the i-th class dictionary via sparse representation (i=1, 2) by OMP. Compute the reconstruction error e_i for each class. Label this window as the c-th class with c = argmin_i e_i.

5.	[Testing] Post-processing: choose either one

	A.	Majority vote

	B.	Smooth

6.	[Testing] Compare the results obtained by KSVD and MOD.


　　<font color="#FF0000" size="4">[reminder] Do not forget to do the same pre-processing as that in training for each window in testing.</font>

## Data：

　　<font size="3">The data will include two sets. You need to train two dictionaries for each set. You will get eight test images. Each test image is built by tiling the training data. We will preserve several test images for blind testing on our side.</font>

　　<font size="4"><a href="http://www.cmlab.csie.ntu.edu.tw/~npes87184/dsp_homework.zip">Download Data</a></font>

## Grading：

　　<font size="3">The performance might not be good. As long as you have done the work according the above basic settings, you will get <u>7.5</u> from 10 (scores). You can get a higher score either by implementing more suggestions from cvpr08 (where the dictionaries are trained more discriminately), employing more dictionary learning methods for comparison, refining the methods or do anything by yourself to boost the performance. Share your findings in the report.</font>

## Codes：

　　<font size="3">You are allowed to use the codes available on the Internet. Eg., KSVD code.</font>

　　<font size="4"><a href="http://www.cs.technion.ac.il/~elad/Various/KSVD_Matlab_ToolBox.zip">Example Library</a></font>

## Contact：

　　<font size="3">If you have any problem, feel free to contact us.</font>

　　<font size="3">Teacher's E-mail:<a href="mailto:song@iis.sinica.edu.tw">song@iis.sinica.edu.tw</a></font>

　　<font size="3">TA's E-mail:<a href="mailto:r03922091@ntu.edu.tw">r03922091@ntu.edu.tw</a></font>

<font color="#FF0000" size="5">Good luck!</font>
