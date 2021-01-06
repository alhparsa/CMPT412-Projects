function [e1,e2] = epipoles(E)

[U S V] = svd(E);

e1 = (V*[0 0 1]');

[U S V] = svd(E');

e2 = (V*[0 0 1]');

end