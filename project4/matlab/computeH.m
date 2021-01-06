function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
x = x1(:,1);
y = x1(:,2);
X = x2(:,1);
Y = x2(:,2);
H = [];
for i = 1: size(x,1)
   H(2*i-1,:) = -[x(i), y(i),1,0,0,0,-x(i)*X(i), -X(i)*y(i), -X(i)];
   H(2*i,:) = -[0,0,0,1, x(i), y(i) ,-x(i)*Y(i), -Y(i)*y(i), -Y(i)];
end
if size(x1,1) <= 4
    [U,S,V] = svd(H);
else
    [U,S,V] = svd(H,'econ');
end
V = reshape(V(:,end),3,3);
[V(1,2),V(2,2), V(3,2)] = deal(V(2,2),V(3,2), V(1,2));
H2to1= V;
end