# ARtillery Crater Analysis and Detection Engine (ARCADE)

An experiment by Rudiment.info with the Centre for Visual Computing, University of Bradford

Version: 1.0

[What is ARCADE?](#what)

[Installing ARCADE](#install)

[How to use ARCADE](#use)

[Feature status](#feature)

[Known issues](#issues)

[Who are you again?](#who)


## What is ARCADE? <a id="what"></a>

ARCADE is an prototype computer vision tool designed to assist with the analysis of satellite images
thought to contain artillery blast craters. It draws on methods specified by the American
Association for the Advancement of Science (AAAS) and Bellingcat in their respective 
investigations of artillery bombardment in [Sri Lanka](http://www.aaas.org/geotech/sri_lanka_2009#B.Possible%20Craters) and [eastern Ukraine](https://www.bellingcat.com/news/uk-and-europe/2015/02/17/origin-of-artillery-attacks/). 

Detailed information about the ARCADE project and its authors is available on [Rudiment's website](https://rudiment.info/project/arcade). 

## Installing ARCADE <a id="install"></a>

ARCADE is currently only available for use on computers running recent versions of Windows
(realistically, 8 and 10). If you want to create a binary installer for OSX or Linux, the
source code is provided so you are welcome to do so (and contribute it - let us know please!)

### Installation on Windows

* Download the MATLAB Compiler Runtime (MCR) (version 8.3, 2014a) for your computer and platform [from here](https://www.mathworks.com/products/compiler/mcr/). Install it. If you install the wrong MCR, ARCADE will not work.
* Download the current ARCADE installer [from here](https://www.dropbox.com/s/0xlp1cksvuca3qa/ARCADE_installer_20151022_v_0_0_1.zip?dl=0). Unzip it. Install it in a directory of your choice (something like C:\Program Files\ARCADE)
* If you've installed ARCADE in `Program Files` you will probably need to use Adminstrator priviledges to perform the next steps.
* In the installation directory you chose, go to the sub-directory called "application". Grab copies of the following files from this repository (in `config`), and place them straight in the `application` directory:
 * [ReadCraters.txt](https://raw.githubusercontent.com/Rudiment-Info/arcade/master/config/ReadCraters.txt) - This is where you tell ARCADE where to get imagery and georeferences.
 * [craterDetector.xml](https://raw.githubusercontent.com/Rudiment-Info/arcade/master/config/craterDetector.xml) -  This is the current training data which tells ARCADE what a crater is.
 * [Settings.txt](https://raw.githubusercontent.com/Rudiment-Info/arcade/master/config/Settings.txt) - This enables you to control how much work ARCADE does to create outlines of things it considers to be blast craters.
* Your `application` directory should look like this:

  ```
  application
  │   arcade.exe
  │   craterDetector.xml
  │   ReadCraters.txt
  │   Settings.txt
  │   splash.png
  ```
* You should now be all set to go!

## How to use ARCADE <a id="use"></a>

First, gather the following data:

* a JPEG/JPG file of the satellite imagery you want to examine;
* the exact latitude and longitude of:
 * the upper right corner of the source image; and,
 * the lower left corner of the source image.
 
Why? ARCADE's calculations are made in pixels on the source image. It needs the two pairs of coordinates to convert its calculations into geographical coordinates.

Next, follow these steps:

* Upload the satellite imagery to a webserver (or use a web server running on your local machine)and make a note of the full URL (including `https://www ...` etc) 
* If you've installed ARCADE in `Program Files` you willneed to use Windows' [adminstrator priviledges](http://windows.microsoft.com/en-gb/windows7/how-do-i-run-an-application-once-with-a-full-administrator-access-token)to perform the below steps.
* Open `~\application\ReadCraters.txt` in your most beloved text editor. 
* In a single row enter the following, with a single tab between each value:
  * The full URL where ARCADE can find the image
  * The latitude of the upper right corner, expressed as a decimal coordinate
  * The longitude of the upper right corner, expressed as a decimal coordinate
  * The latitude of the lower left corner, expressed as a decimal coordinate
  * The longitude of the lower left corner, expressed as a decimal coordinate
* Your ReadCraters.txt file should look like this:

  ```
  http://s29.postimg.org/rxj235qyv/image.jpg	12.590418	9.669342	11.486417	8.147736
  ```
  
* ARCADE can process multiple images in sequence. Place each in a separate row.
* IMPORTANT! If you miss out any of the required data or include spaces or non-printable characters other than a line break in `ReadCraters.txt`, ARCADE will fail and give you an unhelpful error message.
*  Run `arcade.exe` with [administrator priviledges](http://windows.microsoft.com/en-gb/windows7/how-do-i-run-an-application-once-with-a-full-administrator-access-token). 
*  A window with a boring splash page will open. This is all the indication that ARCADE gives you that it is doing something. There is no progress bar to make you feel more comfortable.
*  Depending on the size of the image and the number of detections it makes, ARCADE could be processing for quite a long time (+10 minutes easily).
* As ARCADE is about to finish, a window showing the segmented view with plotted centroids will pop up. Just close it! 
* When ARCADE has completed, you will have a number of outputs for each item you asked it to process.  We discuss these below. 

### ARCADE's Outputs

If the filename of your input image is named `image.jpg`, ARCADE will create five outputs:

* `detected_image.jpg`: This is a version of the image, in greyscale, marked with the boxes that match ARCADE's training on what a crater is.
* `segmented_image.jpg`: A version of the input image, showing ARCADE's attempt to create crater outlines, segment them from the remaining imagery
* `segmented_image_centroids.jpg`: a version of the segmented image, with the centre points of the the segmented shapes plotted on top
* `image_1.csv`: a file with tabular data outlining the latitude and longitude of the crater centre-point, its area (in pixels) and its perimeter (in pixels)
* `image_1.txt`: the same as image_1.csv, just in txt format

###Configuation

* `Settings.txt` contains a single number used to control the number of iterations used in segmentation. We recommend 500, but increase it if you think the 

* `craterDetector.xml` is just a holder for detection paramters, and can be swapped out for a file based on different training data. We'll update the repository with better training data as we create it.

## Feature status <a id="feature"></a>

In this version the below work reasonably well:

* Image pre-processing: ARCADE currently converts all input imagery to greyscale before running any analysis.
* Detection:  ARCADE will ingest imagery, and using a cascade object detector will  place a labelled bounding box around areas that match the parameters of whatever training data it is using (contained in craterDetector.xml)
* Segmentation: The shape in each bounding box is segmented from its background and its edge detected.
* Feature extraction: The centroid of the segmented shape, it's latitude and longitude, and area are calculated and outputted.

The following feature is under development:

* Trajectory analysis using template matching: though the research work on the feature is complete, this is not yet implemented in this version.

## Known issues with version 0.0.1 <a id="issues"></a>

ARCADE is a prototype, and it has issues:

* Pixel matching to latitude and longitude is error prone and needs attention. 
* ARCADE is sensitive to treecover and ploughed fields. If you like, crop that out of the input imagery. Better training data should help limit this problem
* The input method is fairly cumbersome. It would be better to use the Google Static API as an input.

Please use the issues areas of this repository to discuss add new problems, or discuss any issues to do with ARCADE.

## Who are you again? <a id="who"></a>

[Rudiment.info](https://rudiment.info) is a nonprofit group which supports innovation in human rights research. [The Centre for Visual Computing](http://www.bradford.ac.uk/research/rkt-centres/visual-computing/) at University of Bradford carries out research and development in visual image data processing. Technical feasiblity work on ARCADE was funded by the Yorkshire Innovation Fund.

Copyright (c) 2015 Rudiment.info, released under a BSD Simplified License
