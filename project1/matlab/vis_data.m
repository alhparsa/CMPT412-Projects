layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
figure();
title('Original number');
imshow(img.')

% [cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
counter = 1;
data = reshape(output{1,2}.data,output{1,2}.height, output{1,2}.width,output{1,2}.channel);
figure();
title('Output of Conv Layer');
for i = 1: 4
    for j = 1: 5
        subplot(4,5, counter);
        h(i*4+j) = imshow(data(:,:,counter).');
        counter = counter +1;
    end
end
% saveas(gcf,'covlayer.jpg')
counter = 1;
data(data>0) = 0;
data(data<0) = 1;
figure();
title('Activated pixels from Relu layer');
for i = 1: 4
    for j = 1: 5
        subplot(4,5, counter);
        h(i*4+j) = imshow(data(:,:,counter).');
        counter = counter +1;
    end
end
% saveas(gcf,'relulayer.jpg')


