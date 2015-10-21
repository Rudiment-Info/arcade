%This is a helper function used to get largest blob 

%ARtillery Crater Analysis and Detection Engine (ARCADE)
%Developed by Ali M Bukar for Rudiment.info
%Centre for Visual Computing
%University of Bradford, UK

function imbin = get_largestblob(imbin)
    [labeledIm numL] = bwlabel(imbin);
    blobM = regionprops(labeledIm, 'area');
    allAreas = [blobM.Area];
    %sort descend
    [sortedAreas, sortind] = sort(allAreas, 'descend');
    biggestB = ismember(labeledIm, sortind(1));
    imbin = biggestB>0;