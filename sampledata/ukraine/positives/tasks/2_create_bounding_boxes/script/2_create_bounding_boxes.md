# Outline for 2_create_bounding_boxes

* Matlab requires that positive samples have bounding boxes specifying the region of interest. This involves defining a x,y as a starting point from which height and width in pixels are specified, enabling a box to be drawn. 
 ** This is because of the way that the `trainCascadeObjectDetector` ([man page](http://uk.mathworks.com/help/vision/ref/traincascadeobjectdetector.html)) works
* The positive samples generally require clipping as close to the crater area as possible, removing extra material from the image.
* A convenient way to do this is using [Zooniverse's Project Builder](https://www.zooniverse.org/lab), particularly if you have a large number of samples and want help with the task.
 ** The Zoonverse project used to do this work is [here](https://www.zooniverse.org/projects/ltom/artillery-crater-analysis-and-detection-engine-arcade)
 ** Note that the samples clipped from Google Maps are too small to use in Zooniverse. The annotation UI becomes too fiddly.
 ** Use Imagemagick to blow them up 400% for use in Zooniverse. This creates a 200x200px from the 50x50px images, which are far easier to annotate. This can be done by iterating over the directory with `convert foo.png -resize 400% foo_400.png` (or somesuch) ([man page for convert](http://www.imagemagick.org/script/convert.php)) 
 ** The data on bounding boxes can be downloaded from Zooniverse and the relevant bits parsed out.
* It's an open question as to whether the larger files could themselves be used to train the object detector. If not, the bounding box data can be divided down to fit the original image size.
* To get a usable dataset, take the following steps with the classification data outputted from Zooniverse:
    ** Check that all the samples files have a valid classification, reconciling those that may have more than one.
    ** Merge this with the csv containing the crater id, crater field id, lat, lon
