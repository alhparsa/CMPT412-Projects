function [x1, x2, T1, T2] = normalize(x1, x2)
x = x1(:,1);
y = x1(:,2);
X = x2(:,1);
Y = x2(:,2);
%% Compute centroids of the points
centroid1 = [mean(x), mean(y)];
centroid2 = [mean(X), mean(Y)];

%% Shift the origin of the points to the centroid
T1 = [1, 0, -centroid1(1);0,1,-centroid1(2);0,0,1];
T2 = [1, 0, -centroid2(1);0,1,-centroid2(2);0,0,1];
p1 = [x, y, ones(size(x1,1),1)];
p2 = [X, Y, ones(size(x1,1),1)];
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
S1 = [sqrt(2)/centroid1(1), 0,0;0,sqrt(2)/centroid1(2), 0;0,0,1];
S2 = [sqrt(2)/centroid2(1), 0,0;0,sqrt(2)/centroid2(2), 0;0,0,1];
%% similarity transform 1
T1 = S1 * T1;
%% similarity transform 2
T2 = S2 * T2; 
%% Compute Homography

x1 = (T1 * p1.').';
x2 = (T2 * p2.').';
end