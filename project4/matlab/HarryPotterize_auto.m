% %Q2.2.4
clear all;
close all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
hp_img = imread('../data/hp_cover.jpg');

%% Extract features and match
[locs1, locs2] = matchPics(cv_cover, cv_desk);
%% Compute homography using RANSAC
[bestH2to1, ~] = computeH_ransac(locs1, locs2);
% [bestH2to1] = computeH(locs1, locs2);
%% Scale harry potter image to template size
% Why is this is important?
scaled_hp_img = imresize(hp_img, [size(cv_cover,1) size(cv_cover,2)]);

%% Display warped image.
% imshow(cv_desk);
% figure;
% imshow(warpH(scaled_hp_img, bestH2to1.', size(cv_desk)));
% 
%% Display composite image
% figure;
imshow(compositeH(bestH2to1.', scaled_hp_img, cv_desk));