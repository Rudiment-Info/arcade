# Getting to a better crater detection alg

6150 images of suspected artillery craters found in Ukraine using open source intelligence techniques on Google Maps. Useful for training ARCADE or a convolutional neural net to help with analysis of future imagery.

## Tasks

The tasks in this folder work through the process of getting positive samples to train ARCADE or other algorithms which find artillery craters. 

Each task is a step in the process, and we've tried to make them sort-of-self-documenting. Each task contains three folders:

* `input`: usually a list of source files, images or a dataset
* `script`: either some code, or a description of the steps taken
* `output`: the results of the script/instructions on the input

## Specifics

### 0_plot_coordinates

This task takes us from the raw investigative material - .kml files - to a point layer detailing every suspected artillery crater. This gives us a big list of coordinates for each crater, assigns each an id number, and keeps the relationship between each crater and the "crater field" identified by the investigator (which contains the suspected date of shelling, and gives guidance on the satellite imagery publication date)

The output of this step are KML and csv files containing the geographical coordinates (the CRS is Pseudo Mercator WGS84)

### 1_grab_raw

Armed with a list of coordinates, we create a little script to visit the Google Maps Static API (for which you will  need an API key). The script creates a new folder with the name of the timestamp, moves into it, then goes out to Google Maps Static API to the locations specified in the coordinate list, grabs a 50x50px image (enough for the crater, at the appropriate scale and resolution), then clips off the top/bottom 35px to remove the Google watermark (to make the next step easier). 

The data in this repo has the following characteristics:

* it creates 6150 small .png files corresponding to each entry in the coordinate file
* there's also a folder containing the unmodified versions (with Google watermark)
* The script was run on 2016-01-08 at 19:26 GMT. The image clipped will be the imagery served by Google at that time. When using the Google Maps Static API, the image date cannot be specified (like, for example, in Google Earth)

### 2_create_bounding_boxes

For cascadeObjectDetector style tools like ARCADE, we need to give it positive samples AND a Region of Interest. In Matlab, this is a bounding box. So, that means hand-annotating each positive sample. We chose to set up  a Zooniverse project to do it. 

The result of this step is a dataset (`arcade_ukraine_data_processed.csv`) containing the following:

* `filename`: name of the positive sample, found in the relevant `/input` folder
* `x_bound`: x coordinate of starting point for bounding box (px)
* `y_bound`: y coordinate of starting point for bounding box (px)
* `w_bound`: width of bounding box (px)
* `h_bound`: height of bounding box (px)
* `c_id`: id number for each crater (unique, integer)
* `lat`: latitude of the crater
* `lon`: longitude of the crater
* `cfield_id`: id of the crater field, as defined by the original investigator

This should be sufficient for training and analysis purposes. Usual caveat apply: the image data is Google's - we're working nonprofit, and we feel within the ToS.
