function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography


%% Create mask of same size as template
mask = zeros(size(template));

%% Warp mask by appropriate homography
mask = warpH(zeros(size(template)), H2to1, size(img), 100);

%% Warp template by appropriate homography
template = warpH(template, H2to1, size(img), 100);

%% Use mask to combine the warped template and the image
img(mask == 0) = template(mask == 0);
composite_img = img;
end