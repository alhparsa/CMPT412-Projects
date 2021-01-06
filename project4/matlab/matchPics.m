function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!
%% Convert images to grayscale, if necessary 
if size(I1,3)==3
    I1 = rgb2gray(I1);
end
if size(I2,3)==3
    I2 = rgb2gray(I2);
end

%% Detect features in both images
f1 = detectFASTFeatures(I1);
f2 = detectFASTFeatures(I2);
%% Obtain descriptors for the computed feature locations
[f1,vp1] = computeBrief(I1,f1.Location);
[f2,vp2] = computeBrief(I2,f2.Location);
% [f1,vp1] = extractFeatures(I1,f1.Location);
% [f2,vp2] = extractFeatures(I2,f2.Location);
%% Match features using the descriptors
indexPairs = matchFeatures(f1, f2,'MatchThreshold', 10., 'MaxRatio', 0.68);
matchedPoints1 = vp1(indexPairs(:,1),:);
matchedPoints2 = vp2(indexPairs(:,2),:);
% showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
locs1 = matchedPoints1;
locs2 = matchedPoints2;

end

