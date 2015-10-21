%This function first detects blast crater shells using cascade object detection
%Then active contours without edges approach is used for segmentation
%It reads in an image filename and the detector object
%It returns cnt: number of craters detected
%           dI: an image showing annotation of detected craters
%           I: A binary image showing segmented craters as white and
%           backgroud in black
%           im: The original image

%ARtillery Crater Analysis and Detection Engine (ARCADE)
%Developed by Ali M Bukar for Rudiment.info
%Centre for Visual Computing
%University of Bradford, UK



function [cnt, dI, I, im] = detect_n_segment_craters(filename, detector3, itr)

    
    %load trained detector object it should be found in working directory
      
   %create detector object
   
    
    
    %read image url

    im = imread(filename,'jpg');

    I = im;

    if(isa (I, 'double'))
        I = im2uint8(I);
    end
    
    %%convert to gray
    if(size(I,3) == 3)

        I = rgb2gray(I);

    end
    bbox = step(detector3, I);
    I3 = I;
    I = insertObjectAnnotation(I,'rectangle',bbox,'c');
    
    dI = I; %annotated images

    %count number of craters
    cnt = size(bbox,1);

    %define number of iterations for active contour
    if ~exist('itr','var')|| isempty(itr)
    
        iter = 500;
    else
        iter = itr;
    end
    
  
    [m,n] = size(I3);

    cc = zeros(m,n);

    k = size(bbox,1);

     
    %Iteratively segment each annotated image
    for i = 1:k

        x = bbox(i,:);
        a = x(2); b= x(2)+x(4); c = x(1); d = x(1)+x(3);
        cc(a:b, c:d) = I3(a:b, c:d);

        Im = cc(a:b, c:d);

        mask = ones(x(4)+1, x(3)+1);%define a mask

        ck = activecontour(Im,mask,iter,'Chan-Vese');
        ck = get_largestblob(ck);
        cc(a:b, c:d) = ck;
    end
    
    %convert cc to logical/binary

    I = im2bw(cc); %this is the segmented image

    


