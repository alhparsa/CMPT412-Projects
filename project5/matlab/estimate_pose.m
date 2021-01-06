function P = estimate_pose(x, X)
A = [];
% X = [X];
for i = 1 : size(x,2)
    x_p = x(1,i);
    y_p = x(2,i);
    A = [A;
        X(:,i).',1,0,0,0,0,-x_p*[X(:,i).',1];
        0,0,0,0,X(:,i).',1,-y_p*[X(:,i).',1]];
       
end
[~,~,v]=svd(A);
P = v(:, size(v,2));
P = reshape(P, 4, 3)';
end