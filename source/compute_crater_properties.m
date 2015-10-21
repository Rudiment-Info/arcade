%This function  uses Matlab regionprops to compute crater-blob properties

%ARtillery Crater Analysis and Detection Engine (ARCADE)
%Developed by Ali M Bukar for Rudiment.info
%Centre for Visual Computing
%University of Bradford, UK

function [num, centx, centy, area, perimeter] = compute_crater_properties(segmentedIm)

    
	[labeledim, num] = bwlabel(segmentedIm,8);%label the blobs(s)

if (num == 0)%if there is no blob, return zeros
        
        centx = 0; centy =0; area =0; perimeter = 0;
        
else

        s = regionprops(labeledim, 'Centroid', 'Eccentricity','MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Area','Perimeter');

        centroids = cat(1,s.Centroid);%concatenated centroids

        centx = centroids(:,1);

        centy = centroids(:,2);

        for ii= 1:num
            area(ii) = s(ii).Area;
            perimeter(ii) = s(ii).Perimeter;
        end

        area= area';
        perimeter = perimeter';
end