%This is the main MATLAB file used to call other functions for the purpose
%of crater detection, segmentation, and computation of features: centroids, areas, and
%perimeters of detected craters.
%Crater shells are detected using a computer vision cascade object detector.
%Trained features are stored in detector object that is created using the craterDetector.xml file 
%Detected images are segmented using the Chan-Vese active contours without edges approach

%ARtillery Crater Analysis and Detection Engine (ARCADE)
%Developed by Ali M Bukar for Rudiment.info
%Centre for Visual Computing
%University of Bradford, UK

clc

clear all


    %Read xml file and create detector object
    
    detector3 = vision.CascadeObjectDetector('craterDetector.xml');
    
    %read the textfile containing image url, lat1 lon1 and lat2 lon2
    filename = 'ReadCraters.txt';
    fileID = fopen(filename);
    c = textscan(fileID, '%s %f %f %f %f', 'Delimiter', '\t');
    fclose(fileID);
    
    datalength = length(c{1});
    
    filename2 = 'Settings.txt';
    fileID2 = fopen(filename2);
    c2 = textscan(fileID2, '%d');
    fclose(fileID2);
    
    itr = c2{1};
    
    %Iteratively perform detection, segmentation, and feature extraction on
    %each data (row) retrieved from ReadCraters.txt
    
    for ii = 1:datalength
        
        imname = c{1}{ii};
        lata = c{2}(ii);
        lona = c{3}(ii);
        latb = c{4}(ii);
        lonb = c{5}(ii);
        
        numst = num2str(ii);

            %call detect and segment function
            [number_craters, detectedIm, segmentedIm, img] = detect_n_segment_craters(imname, detector3, itr);
            
            %format output name
            [pathstr, name, ext] = fileparts(imname);
            outputname = strcat(name,'_',numst,'.txt');
            outputname2 = strcat(name,'_',numst,'.xlsx');
            if(number_craters == 0)
                
                    %myformat = '%f\t%f\t%f\t%f\r\n';
                    T = table(0,0,0,0);
                    write(T, outputname, 'Delimiter', '\t');
                    write(T, outputname2);
                    
            else

                    [pathstr, name, ext] = fileparts(imname);

                    detectedstr = strcat('detected','_', name, ext);
                    segmentedstr = strcat('segmented','_', name, ext);

                    %save image showing detected craters annotated
                    %also save the segmented image to working directory

                    imwrite(detectedIm, detectedstr);
                    imwrite(segmentedIm, segmentedstr);

                    %compute properties of segmented craters
                    [num_craters, centx, centy, area, perimeter] = compute_crater_properties(segmentedIm);

                    
                    %create mapping structure to be used to convert pixels
                    %coordinates to latitude and longitude

%                     lat1 = lata; lon1 = lonb;
%                     lat2 = lata; lon2 = lona;
%                     lat4 = latb; lon4 = lonb;

                    %if img is coloured convert to gray
                    if(size(img,3) == 3)

                        img = rgb2gray(img);

                    end

                    R = compute_map_struct(img, lata,lona, latb,lonb);


                    %convert centroid pixels to latitude and longitude
                         %preallocation
                         Clat = zeros(num_craters, 1);
                         Clon = zeros(num_craters, 1);

                    for iii = 1:num_craters

                        Centx = centx(iii);
                        Centy = centy(iii);
                        [Clat(iii), Clon(iii)] = compute_centroid_latlon(R, Centx, Centy);


                    end

                    %output a text file with
                    %centroidlat[tab]centroidlon[tab]area[tab]perimeter
                    %XX = [Clat, Clon, area, perimeter];
                    %dlmwrite(outputname,XX, 'delimiter','\t', 'newline', 'pc');%for windows
                    %dlmwrite(outputname,XX, 'delimiter','\t', 'newline', 'unix');%for unix
                    
                    %write to spread sheet
                    %xlswrite(outputname2, XX);
                    
                    T = table(Clat,Clon,area,perimeter);
                    write(T, outputname, 'Delimiter', '\t');
                    write(T, outputname2);
                    
                    %superimpose centroids on segmented image
                    imshow(segmentedIm);

                    hold on

                    plot(centx, centy, 'r*');

                    str2 = strcat('segmented','_', name,'_centroids', ext);
                    options.Format = 'jpeg';
                    hgexport(gcf, str2, options);

                    hold off
            end
    
    end
    
   