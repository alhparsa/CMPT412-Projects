load lenet.mat
imgs = zeros(784,6);
for i = 0: 5
   img_src = sprintf('../images/samples/%d.png', i);
   img = rgb2gray(im2double(imread(img_src))).';
   sample_pic = reshape(img, [], 1);
   imgs(:,i+1) = sample_pic;
end
layers = get_lenet();
layers{1,1}.batch_size = size(imgs,2);
[output, P] = convnet_forward(params, layers, imgs);
[p, out_label] = max(P, [], 1);
sum(out_label-1 == [0:5])
