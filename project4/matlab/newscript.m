%% homography test
close all
clear

[x1, x2] = matchPics(imread('../data/cv_cover.jpg'), imread('../data/cv_desk.png'));
% H = computeH(x1, x2);
% H = computeH_norm(x1, x2).';
[H,inliers] = computeH_ransac(x1, x2);
tform = projective2d(H);
points = [randperm(350, 10).', randperm(450, 10).'];
out = transformPointsForward(tform,inliers);
% out = transformPointsForward(tform,points);
img = imread('../data/cv_cover.jpg');
img2 = imread('../data/cv_desk.png');
figure;
% showMatchedFeatures(img, img2, points, out, 'montage');
showMatchedFeatures(img, img2, inliers, out, 'montage');