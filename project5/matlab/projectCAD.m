which -all hold
close all
clear
load('../data/PnP.mat');
P = estimate_pose(x,X);
[K,R,t]=estimate_params(P);
figure
imshow(image);
hold on
proj_points = P*[X; ones(1, size(X,2))];
proj_points = proj_points ./ proj_points(3,:);
plot(proj_points(1,:), proj_points(2,:), 'r+', 'LineWidth', 2);
hold off

figure
trimesh(cad.faces,cad.vertices(:,1), cad.vertices(:,2), cad.vertices(:,3),'EdgeColor', 'red');

figure
rotated_cad = [R,t;[0,0,0,1]] * [cad.vertices.';ones(1,size(cad.vertices,1))];
trimesh(cad.faces,rotated_cad(1,:), rotated_cad(2,:), rotated_cad(3,:),'EdgeColor', 'blue');

% If you are on mac and the last figure show up as two seperate figure
% uncomment
% close all

figure
cad_proj = P * [cad.vertices.'; ones(1,size(cad.vertices,1))];
cad_proj = cad_proj ./ cad_proj(3,:);
hold on
imshow(image)
patch('Faces',cad.faces(:,1:2),'Vertices', [cad_proj(1,:).', cad_proj(2,:).'])
hold off
