function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m
c1 = -inv(K1*R1) * (K1*t1);
c2 = -inv(K2*R2) * (K2*t2);
r1 = abs(c1 - c2)/ norm(c1 - c2);
r2 = cross(R1(3, :), r1);
% normalize the vectors
r2 = r2 / norm(r2);
r3 = cross(r1, r2);
r3 = r3 / norm(r3);
R_h = [r1.'; r2; r3];
R1n = R_h;
r2 = cross(R2(3, :), r1);
r3 = cross(r1, r2);
R_h = [r1.'; r2; r3];
R2n = R_h;
K1n = K2;
K2n = K2;
t1n = -R1n * c1;
t2n = -R2n * c2;
M1 = (K1n * R1n)*inv(K1*R1);
M2 = (K2n * R2n)*inv(K2*R2);
% R2n = R_h;