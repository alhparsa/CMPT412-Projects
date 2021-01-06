function [pts] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
pts1 = round([pts1, 1].');
l = F * pts1;
l = l / -l(2);
ranged_pixs1 = im1(pts1(2)-3:pts1(2)+3, pts1(1)-3:pts1(1)+3,:);
least_dist = 1e10;
for x = pts1(1)-10:pts1(1)+10
   pts2 = round([x, l(1)*x+l(3),1]);
   if x == 1
       pts = [pts2(1), pts2(2)];
   end
   try
      ranged_pixs2 = im2(pts2(2)-3:pts2(2)+3, pts2(1)-3:pts2(1)+3,:);
      dist = sqrt(sum((ranged_pixs1 -ranged_pixs2).^2,'all'));
      if dist < least_dist
          least_dist = dist;
          pts = [pts2(1), pts2(2)];
      end
   catch
   end
end
