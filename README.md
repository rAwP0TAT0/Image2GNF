# Image2GNF
Script to convert images into gnf file

## Overview
This guide explains how to extract frames from a video using `ffmpeg` (an open-source tool) and convert them into a GNF file (a proprietary PlayStation texture format) using a PowerShell script with the PS5 SDK’s `image2gnf` tool. The process is for **licensed PS5 developers only** and requires the PS5 SDK, which is not provided here.

**Prerequisites**:
-Access to the PS5 SDK tools, which i will not provide.
- `ffmpeg` installed (download from [ffmpeg.org](https://ffmpeg.org)).
- ImageMagick installed for resizing (optional, [imagemagick.org](https://imagemagick.org)).

Requirements:

PS5 SDK installed, with image2gnf.exe accessible(which i will not provide)

JPEG files named test1_000.jpg, test1_001.jpg, etc., in the input directory.

All images must have the same dimensions (e.g., 1024x512 or 640x360).

Use the provided PowerShell script to convert JPEG frames into a GNF file for PS5. The script dynamically detects the number of test1_*.jpg files and creates a 2DArray texture.


First you need to use ffmpeg to grab frames from a video or you can use free online tool if you want ie: (https://image.online-convert.com/convert/mp4-to-jpg)


# Video and JPG conversion using FFMPEG
- by @rlan on Github(https://github.com/rlan)

## Grab one frame from video

```sh
#!/bin/sh -x
# $1 - input video file, e.g. video.mp4
# $2 - timestamp, e.g. 00:33
# $3 - output image file, e.g. output.jpg
ffmpeg -ss $2 -i $1 -vframes 1 -q:v 2 $3
```

## Grab all frames from video

```sh
#!/bin/sh -x
# $1 - input file, e.g. input.mp4
ffmpeg -i "$1" -q:v 2 %06d.jpg
```

## Combine jpg files into one video

```sh
ffmpeg -f image2 -framerate 30 -i %06d.jpg -c:v libx264 out.mp4
```

After getting the frames from a video (i used 101 frames to generate a gnf file) you will be using a Powershell script to create the file.

## Test with patience ~~if you want to add frames more than 101~~ (the more frames, more heavier file it gets and might not work in PS5)

*UPDATE:**
It is not recommended to use **300 images** as the program will crash. 

You will ALSO need the PS5 SDK tools for this to work. I will not provide it, only the way to make gnf files using this Powershell script.

## Renaming the file

Rename the output.gnf into "Sce.Vsh.ShellUI.BGLayer.Particle0.gnf"


## Uploading into Playstation
Finally you can test the output.gnf by inserting it into 
```
system_ex/vsh_asset/output.gnf 
```
after renaming.


**IMPORTANT:**
*I have not tested this but to only have both of them modified with the same output.gnf file, like "..Particle0.gnf, ..Particle1.gnf"
More tests are needed here.**

## Here's a Video demonstrating the modified file:

[![Watch the video](https://raw.githubusercontent.com/rAwP0TAT0/Image2GNF/main/assets/Demo1.jpg)](https://raw.githubusercontent.com/rAwP0TAT0/Image2GNF/main/assets/Demo1.mp4)

**Source for the video I used from Youtube:**
[![Video Title](https://img.youtube.com/vi/c3abfWsQk-M/0.jpg)](https://youtu.be/c3abfWsQk-M)

## TODO:
- [x] Publish script
- [ ] Make a Tool from this script
- [ ] Include MP4 to JPG Converter into the tool
- [ ] Make a GNFViewer app for PS5
- [ ] More ideas needed ..


**Disclaimer: The author does not provide the PS5 SDK or any proprietary Sony tools. Users must be licensed PS5 developers with legal access to the SDK. The script assumes 101 frames (or any count) named test1_XXX.jpg. 
This script is in alpha stage and it will need more work for progression. It is provided for free-to-use and in as is.**
