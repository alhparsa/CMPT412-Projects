% Your solution to Q2.1.5 goes here!
close all
clear all
%% Read the image and convert to grayscale, if necessary
I1 = imread('../data/cv_cover.jpg');
if size(I1,3)==3
    I1 = rgb2gray(I1);
end

%% Compute the features and descriptors
count = [];
f1 = detectFASTFeatures(I1);
[f1,vp1] = computeBrief(I1,f1.Location);
for i = 0:36
    %% Rotate image
    I1_ = imrotate(I1,(i)*10);
    %% Compute features and descriptors
    f2 = detectFASTFeatures(I1_);
    [f2,vp2] = computeBrief(I1_,f2.Location);
    indexPairs = matchFeatures(f1,f2,'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    matchedPoint2 = vp2(indexPairs(:,2),:);
    if i == 30 || i == 20 || i == 10
        matchedPoints1 = vp1(indexPairs(:,1),:);
        figure()
        showMatchedFeatures(I1,I1_,matchedPoints1,matchedPoint2,'montage');
    end
    count = [count, size(indexPairs(:,1), 1)];
end
figure()
bar(count)

%% Compute the features and descriptors
count = [];
f1 = detectSURFFeatures(I1);
[f1,vp1] = extractFeatures(I1,f1.Location, 'Method', 'SURF');
for i = 0:36
    %% Rotate image
    I1_ = imrotate(I1,(i)*10);
    %% Compute features and descriptors
    f2 = detectSURFFeatures(I1_);
    [f2,vp2] = extractFeatures(I1_,f2.Location, 'Method', 'SURF');
    indexPairs = matchFeatures(f1,f2,'MatchThreshold', 10.0);
    matchedPoint2 = vp2(indexPairs(:,2),:);
    if i == 30 || i == 20 || i == 10
        matchedPoints1 = vp1(indexPairs(:,1),:);
        figure()
        showMatchedFeatures(I1,I1_,matchedPoints1,matchedPoint2,'montage');
    end
    count = [count, size(indexPairs(:,1), 1)];
end
figure()
bar(count)