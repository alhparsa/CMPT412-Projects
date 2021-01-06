function [ bestH2to1, inliers] = computeH_norm_ransac( locs1, locs2)
%computeH_norm_RANSAC A method to compute the best fitting homography given a
%list of matching points.
max_count = 0;
best_H = [];
least_dist = 1e10;
for i = 1: 100
   if size(locs1,1) < 4
       randpoints = randperm(size(locs1,1), size(locs1,1));
   else
       randpoints = randperm(size(locs1,1),4);
   end
   x1 = locs1([randpoints],:);
   x2 = locs2([randpoints],:);
   h = computeH_norm(x2,x1);
   tform = projective2d(h.');
   out = transformPointsForward(tform, locs2);
   dis = abs(locs1-out);
   count = 0;
   tmp_points = [];
   for j = 1: size(locs1, 1)
       if norm(dis(j,:),2) <= 2.5
           count = count+1;
           tmp_points = [tmp_points, j];
       end
   end 
   if count == max_count
       if sum(dis,'all') < least_dist
            least_dist = sum(dis,'all');
            max_count = count;
            x1 = locs1(tmp_points,:);
            x2 = locs2(tmp_points,:);
            best_H = computeH_norm(x1,x2);
            inliers = locs1(tmp_points,:);
       end
   elseif count > max_count
       least_dist = sum(dis,'all');
        max_count = count;
        x1 = locs1(tmp_points,:);
        x2 = locs2(tmp_points,:);
        best_H = computeH_norm(x1,x2);
        inliers = locs1(tmp_points,:);
   end
end
if size(best_H,1) ==0
    bestH2to1 = computeH_norm(x1,x2);
else
    bestH2to1= best_H.';
end
max_count

end