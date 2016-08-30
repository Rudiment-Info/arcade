#!/bin/bash

# CraterClipper
#
# Very dirty bash script to acquire images of specific coordinates 
# from Google Static Maps API and clip out non-map stuff for training 
# ARCADE algorithm 
# API Documentation at https://developers.google.com/maps/documentation/static-maps/intro#URL_Parameters
# Make sure you've got imagemagick installed

# Define function to create and move to new directory

mkcd(){
       	mkdir -p "$*" 
	cd "$*"
}

# Define variable for current time

current_time=$(date "+%Y-%m-%d-%H-%M-%S")

# Create and navigate to new directoy with current timestamp
# Image capture will be downloaded into this directory

mkcd capture-"$current_time"

# Define and populate variables to construct 
# URL for Google Static Maps API

apikey="YOUR_API_KEY_SHOULD_GO_HERE" # Put your API key here - stick to Google ToS
baseurl="https://maps.googleapis.com/maps/api/staticmap?"
format="png32"
maptype="satellite"
scale="1"
size="50x120" # Horizonal then vertical (Google watermark is 35px)
zoom="18"

# Define and populate variable to construct 
# URL for Google Static Maps API
# Specify the file containing output filename,latitude,longitude, 
# Field separator in source file must be whitespace

sourcefile="PUT PATH TO SOURCE FILE HERE"

# Open while loop to iterate across lines in source file
# Define fields to be found in source file

while read -r outputname lat lon; do

# Construct cURL command using variables

curl -o "$outputname".png "${baseurl}center=${lat},${lon}&size=${size}&zoom=${zoom}&maptype=${maptype}&scale=${scale}&format=${format}&key=${apikey}"

# Close while loop
# Specify where the while loop should look for lines
# to iterate over

done < "$sourcefile"


# Make copy of downloaded, watermarked files prior to modification using imagemagick
# or other processing 
mkdir unmodified
cp *.png unmodified/

# Use imagemagick to chop 35 pixels from the top and bottom
# of each image in the working directory, removing the Google
# watermark

mogrify -format png -gravity south -chop 0x35 *.png
mogrify -format png -gravity north -chop 0x35 *.png
