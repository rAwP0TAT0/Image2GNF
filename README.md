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


First you need to use ffmpeg to grab frames from a video

by @rlan on Github(https://github.com/rlan)
# Video and JPG conversion using FFMPEG

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

You will ALSO need the PS5 SDK tools for this to work. I will not provide it, only the way to make gnf files using this Powershell script.


Rename the output.gnf into "Sce.Vsh.ShellUI.BGLayer.Particle0.gnf"

Finally you can test the output.gnf by inserting it into system_ex/vsh_asset/ after renaming.

IMPORTANT:
I have not tested this but to only have both of them modified with the same output.gnf file, like "..Particle0.gnf, ..Particle1.gnf"

More tests are needed here.

Here's a GIF demonstrating the app:

[App Demo]
<p align="center">
  <video src="assets/Demo1.mp4" width="500px"></video>
</p>

<video src="assets/Demo1.mp4" width="320" height="240" controls></video>

![non working video](assets/Demo1.mp4)




Disclaimer: The author does not provide the PS5 SDK or any proprietary Sony tools. Users must be licensed PS5 developers with legal access to the SDK. The script assumes 101 frames (or any count) named test1_XXX.jpg. 
