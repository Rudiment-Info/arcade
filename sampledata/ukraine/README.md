# Sample artillery bombardment imagery and algorithm training data: eastern Ukraine, 2014

Provided here are data on possible artillery bombardment sites [identified in eastern Ukraine by MapInvestigation and Bellingcat](http://mapinvestigation.blogspot.co.uk/2015/07/smoking-grads-evidence-of-90-cross.html), covering the period July-September 2014.

Here we provide some products based on this work:

## Sources

This contains two sets of useful material

* `mapvestigation_ukraine_dataset.zip`: the data in ESRI .shp format, for use in geographical information systems like QGIS.
* `\google_satellite_export` : large JPEG images of the underlying satellite imagery of bombardment sites (mostly from August/September 2014) from Google, drawn from OpenLayers using QGIS and exported using its Print Composer at 300DPI and scales varying from 1:5000 to 1:8000. The images cover quite large areas. The number in each filename relates to the ID number of each bombardment site included in the .shp file. The coordinates of the image corners, however, do not precisely relate to the extents of each polygon in the Mapinvestigation data.

## Positive samples

This contains a more detailed account of how to extract positive samples for using training algorithms. Rather than going through a GIS to get the imagery - which is messy and imprecise - it is better to take it direct from the Google Maps Static API.

This folder contains contains datasets, images (lots of .pngs of possible craters), metadata (including precise geographical information, divisions of possible craters into crater fields) and bounding box data for even more precise identification of the possible crater in each sample image.

The satellite imagery has formed the basis of training and testing data for ARCADE.

Google and their data providers retain all rights on this raw imagery. We have retained the ownership information on each image. We are hosting it herein good faith, not for profit, in line with [Google's Permissions pertaining to web maps](https://www.google.com/permissions/geoguidelines.html#maps-web).
