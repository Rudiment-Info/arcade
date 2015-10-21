%This function converts centroid (x, and y coordintaes) to latitude and longitude
%It reads in the structuring element R, as well as the x, and y coordinaates

%ARtillery Crater Analysis and Detection Engine (ARCADE)
%Developed by Ali M Bukar for Rudiment.info
%Centre for Visual Computing
%University of Bradford, UK

function [Clat, Clon] = compute_centroid_latlon(R, centx, centy)

	[Clat, Clon] = pix2latlon(R,centx, centy);