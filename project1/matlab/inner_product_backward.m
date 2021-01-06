function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.
% param_grad.b = zeros(size(param.b));
% param_grad.w = zeros(size(param.w));

% k = size(input.data, 2); % batch size
% for i = 1 : k
%     param_grad(:,k) = 
% end
% b_size = size(param.b)
% out_size = size(output.diff)

% size(output.diff) 500 x 100
% size(input.data) % 800 x 100
% size(param.w)  800 x 500
% in_size = size(input.data)
% out_size = size(output.diff)
% w_size = size(param.w)
param_grad.b = (output.diff * ones(100,1)).';
param_grad.w =  input.data * output.diff.';
input_od = param.w * output.diff;
% intput_od = output.diff .* param.w;
% end

end
