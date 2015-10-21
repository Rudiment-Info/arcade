%This function computes a mapping structure used for the conversion of
%pixel coordinates to latitude and longitudde

%ARtillery Crater Analysis and Detection Engine (ARCADE)
%Developed by Ali M Bukar for Rudiment.info
%Centre for Visual Computing
%University of Bradford, UK

function R = compute_map_struct(img, lat1,lon1, lat2,lon2)

	[m, n] = size(img);

	dlon = (lon2 - lon1)/(1-n);

	dlat =(lat1 - lat2)/(1-m);

	R = makerefmat(lon2,lat1, dlon,dlat);