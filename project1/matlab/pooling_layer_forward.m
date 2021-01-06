function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    output.data = zeros([h_out*w_out*c, batch_size]);
    tmp_data.data = zeros([h_out,w_out,c]);
    tmp_data.height = h_out;
    tmp_data.width = w_out;
    tmp_data.channel = c;
    

    b_counter = 1;
    for b = 1:batch_size
        ch_counter = 1;
        img_data = reshape(input.data(:, b), input.height, input.width, input.channel);
        img_data = padarray(img_data, [pad, pad], 0, 'both');
        s = size(img_data);
        for ch = 1:c
            h_counter = 1;
            for h = 1: stride: s(1)
                w_counter = 1;
               for w = 1: stride : s(2)
                    tmp_data.data(h_counter, w_counter, ch_counter) = max(img_data(h: h+k-1, w: w+k-1, ch),[], 'all');
                    w_counter = w_counter +1;
                end
                h_counter = h_counter +1;
            end
            ch_counter = ch_counter +1;
        end
        output.data(:, b_counter) = reshape(tmp_data.data, [], h_out*w_out*c);
        b_counter = b_counter + 1;
    end
end

