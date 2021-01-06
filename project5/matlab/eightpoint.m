function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
pts = randperm(size(pts1,1),10);
p1 = pts1(1:8,:);
p2 = pts2(1:8,:);
[p1, p2, T1, T2] = normalize(p1, p2);
x1 = p1(:,1);
y1 = p1(:,2);
x2 = p2(:,1);
y2 = p2(:,2);
m = [x2 .* x1, x2 .* y1, x2, y2 .* x1, y2 .* y1, y2, x1, y1, ones(size(x1, 1),1)];
[~,~,V] = svd(m);
A = reshape(V(:,end),3,3);
[U,S,V] = svd(A);
S(3,3) = 0;
F = U*S*V.';
F = T2.' * F * T1;
F = refineF(F,pts1,pts2);
end

