function [output] = conv_layer_forward(input, layer, params)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;

% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')

output.height = h_out;
output.width = w_out;
output.channel = layer.num;
output.batch_size = batch_size;

w = params.w;
bias = params.b;

%% Fill in the code
% Iterate over the each image in the batch, compute response,
% Fill in the output datastructure with data, and the shape. 

output.data = zeros([h_out*w_out*layer.num, batch_size]);
tmp = input;
for b = 1:batch_size
    tmp.data = input.data(:, b);
    img = im2col_conv(tmp, layer, h_out, w_out);
    img = reshape(img, c*k*k, h_out*w_out);
    res = img.' * w + bias;
    res = reshape(res, h_out, w_out, layer.num);
    output.data(:, b) = reshape(res, [], 1);
end


% Too slow ....
% for b = 1:batch_size
%     tmp_data = zeros(h_out, w_out, num, c);
%     img_data = reshape(input.data(:, b), input.height, input.width, input.channel);
%     img_data = padarray(img_data, [pad, pad],0, 'both');
%     s = size(img_data);
%     output_data = zeros(h_out, w_out, num);
%     for kn = 1:num
%         for ch= 1: c
%             tmp = 0;
%             h_counter = 1;
%             for h = 1: stride: h_out
%                 w_counter = 1;
%                 for w = 1: stride : w_out
%                     tmp_data(h_counter, w_counter, ch, kn) = sum(dot(img_data(h: h+k-1 , w: w+k-1, ch), weights(:,:,ch, kn)));
%                     w_counter = w_counter+1;
%                 end
%                 h_counter = h_counter+1;
%             end
%             output_data(:,:, kn) = sum(tmp_data(:,:,:,kn), 3) + params.b(kn);
%         end
%         output_data
%         break;
%         output.data(:,b) = reshape(output_data, h_out*w_out*layer.num,1);
%     end
%     break
% end
% output_image = col2im_conv();
end
