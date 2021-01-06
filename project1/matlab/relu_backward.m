function [input_od] = relu_backward(output, input, layer)


% input
% output
% layer  
% Replace the following line with your implementation.
relu = max(input.data, 0);
applied = relu == input.data; 
input_od = output.diff .* applied;
% output
% hi = fi(wi,hi-1)
% input_od = dl/dh(i-1) = (dl/dh(i))*(dh(i)/dh(i-1))
% size(output.diff)
end
