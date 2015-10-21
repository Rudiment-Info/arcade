# ARtillery Crater Analysis and Detection Engine (ARCADE)
An experiment by Rudiment.info

Version: 0.0.1

## What is it?

ARCADE is an experiment computer vision tool designed to assist with the analysis of satellite images
thought to contain artillery blast craters. It draws on methods specified by the American
Association for the Advancement of Science (AAAS) and Bellingcat in their respective 
investigations of artillery bombardment in [Sri Lanka](http://www.aaas.org/geotech/sri_lanka_2009#B.Possible%20Craters) and [eastern Ukraine](https://www.bellingcat.com/news/uk-and-europe/2015/02/17/origin-of-artillery-attacks/).

Detailed information about the ARCADE project is available on [Rudiment's website](https://rudiment.info/project/arcade). 

## Installing ARCADE

* Download MATLAB MCV and install it
* Download ARCADE installer and run it
* Put craterDetector.xml in ARCADE application directory
* Put readCraters.txt in ARCADE application directory
* Create settings.txt in ARCADE application directory

## How to use ARCADE

###Steps

If you have installed ARCADE in /program files you'll need to do all the below with admin privs in Windows

* Upload imagery to a local webserver
* Edit readcraters.txt and input the url of then image, along with lat/lon of upper right and lower left corners of the image (in that order). Each value is tab separated. ARCADE will fail, and give you a cryptic error if you include any non-printable characters or spaces in readcraters.txt
*  Run ARCADE with admin privs
*  A window with a splash page will open. This is all the indication that ARCADE gives you that it is doing something (no progress bar as yet).
*  Depending on the size of the image, and the number of detections it makes, ARCADE could be processing for quite a long time (+15 minutes easily)
* When it's done you will have a number of outputs, which we discuss below.

###Outputs

Todo

###Settings

* Iterations - for performance, you can control the number of iterations used in segmentation. We recommend 500.

## Feature status

In this version the below work reasonably well:

* Image pre-processing: ARCADE currently converts all input imagery to grayscale before running any analysis.
* Detection:  ARCADE will ingest imagery, and using a cascade object detector will  place a labelled bounding box around areas that match the parameters of whatever training data it is using (contained in craterDetector.xml)
* Segmentation: The shape in each bounding box is segmented from its background and its edge detected.
* Feature extraction: The centroid of the segmented shape, it's lat/lon, and area are calculated and outputted.

The following feature is under development:

* Trajectory analysis using template matching: though the research work on the feature is complete, this is not yet implemented in this version.


Copyright (c) 2015 Rudiment.info, released under a BSD Simplified License
