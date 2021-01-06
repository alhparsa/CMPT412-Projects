% A test script using templeCoords.mat
%
% Write your code here
%


im1 = imread('../data/im1.png');
im2 = imread('../data/im1.png');
load('../data/someCorresp.mat');
F = eightpoint(pts1, pts2, M);
load('../data/templeCoords.mat');
pts2 = zeros(size(pts1));
for i = 1 : size(pts1, 1)
    pts2(i,:) = epipolarCorrespondence(im1, im2, F, pts1(i,:));
end

load('../data/intrinsics.mat');
E = essentialMatrix(F, K1, K2);
P1 = K1 * [eye(3),zeros(3,1)];
cP2 = camera2(E);
least_cost = 1e10;
for i = 1: 4
    if det(cP2(1:3,1:3,i)) ~= 1
        cP2(:,:,i) = K2 * cP2(:,:,i);    
        X = triangulate(P1, pts1, cP2(:,:,i), pts2);
        x1 = P1*X.';
        x2 = cP2(:,:,i)*X.';
        x1 = (x1./x1(3,:)).';
        x2 = (x2./x2(3,:)).';
        if sum(X(:,3)>0,'all') == size(X,1)
            dist1 = norm(pts1-x1(:,1:2)) / size(X,1)
            dist2 = norm(pts2-x2(:,1:2)) / size(X,1)
            if dist1+dist2 < least_cost
                least_cost = (dist1+dist2);
                pts3d = X;
                P2 = cP2(:,:,i);
            end
        end
    end
    
end
plot3(pts3d(:,1), pts3d(:,2), pts3d(:,3), 'r.');
axis equal
R1 = K1 \ P1(1:3,1:3);
t1 = K1 \ P1(:,4);
R2 = K2 \ P2(1:3,1:3);
t2 = K2 \ P2(:,4);
% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
