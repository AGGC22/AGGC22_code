# AGGC22

## Introduction
This MATLAB ode is provided for participants of Automated Gleason Grading Challenge 2022 (https://aggc22.grand-challenge.org/) to read the original image data. The MATLAB Bio-Format toolbox (https://www.openmicroscopy.org/bio-formats/downloads/) is required to run the code.

There are 3 subsets of data in the challenge:

•	For subset 1 and 2, all cases are scanned by Vectra Polaris from Akoya BioSciences and the formats are “.qptiff”.

•	For subset 3, each case is scanned by multiple scanners and the corresponding formats are: “.qptiff” for Akoya BioSciences, “.vsi” with “.ets” for Olympus, “.czi” for Zeiss, “.svs” for Leica and KFBio, “.tiff” for Philips. 

For Philips, since the format is “.tiff”, which can be directly read by any image reading function, there is no need to run the code. The Philips images are 40x.

In the original format, there are multiple frames which correspond to different resolutions stored, while the **ground truth annotation is 20x. Please resize accordingly.**


--------------------------------------------------------------------------------------------------------------
## MATLAB function

function imRGB = fcn_read_original_format(input_folder, filename, stack_number)

Input variable: 

**iutput_folder** – folder path of the image 

**filename** – full filename of the image, must include file extension

**stack_number** – to indicate the resolution you want to read: 

•	Akoya (.qptiff):  20x: stack_number = 1, 10x: stack_number = 2, 5x: stack_number = 3.

•	Olympus (.vsi) 20x: stack_number = 16,10x: stack_number = 17,5x: stack_number = 18. 

•	Leica (.svs):  40x: stack_number = 1, 10x: stack_number = 2.

•	Zeiss (.czi):  40x: stack_number = 1, 20x: stack_number = 2; 10x: stack_number = 3; 5x: stack_number = 4. 

•	KFBio (.svs):  20x: stack_number = 1; 5x: stack_number = 2.


For example, to read file “D:\Data\ image1.vsi” which is scanned by Olympus and extract the 20x frame: 

imRGB = fcn_read_original_format(‘D:\Data\’, ‘image1.vsi’, 16)

