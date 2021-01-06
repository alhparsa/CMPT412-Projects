warning('off','all')
labels = {[1; 2; 3; 4; 5; 6; 7; 8; 9; 0;] [1; 2; 3; 4; 5; 6; 7; 8; 9; 0;] [6; 0; 6; 2; 6;] [7; 0; 3; 9; 1; 2; 6; 7; 6; 1; 6; 3;4;9;1;4;2;0;0;5;4;4;7;3;1;0;2;5;5;1;7;7;4;9;1;7;4;9;2;1;5;3;4;0;2;9;4;4;1;1;]};
load lenet.mat
layers = get_lenet();
for i = 1: 4
%     loading the images and image preparation
   img_src = sprintf('../images/image%d.jpg', i);
   I = rgb2gray(imread(img_src));
   if i == 4
    stre = 1;
    threshold = 40;
   elseif i == 3
       stre = 0;
       threshold = 100;
   else
       stre = 1;
       threshold = 150;
   end
%    img processing for the network
   se = strel('disk',stre);
    background = imopen(I,se);
    com = imcomplement(background);
    com(com < threshold) = 0;
    com(com > threshold) = 255;
    com = im2double(com);
%     display the images after processing them
%     imshow(com);
    v = bwlabel(com);
    s = regionprops(v, 'BoundingBox');
    s = struct2cell(s);
%     for visualization purporses
%     imshow(com);
%     hold on
%     for m = 1: length(s)
%         BB = s(m).BoundingBox;
%         rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
%     end
%     hold off

%     digit prediction
      input_img = zeros(28*28, size(s,2));
      prediction = zeros(1,size(s,2));
      layers{1,1}.batch_size = size(s,2);
      for m = 1 : size(s,2)
        b = s{1,m};
        img = com(b(2):b(2)+b(4)-1, b(1):b(1)+b(3)-1);
        diff_f = max(size(img)) / min(size(img));
        diff_val = max(size(img)) - min(size(img));
        if  diff_f >= 2.
            img = padarray(img, [5,floor(diff_val/2)+1], 0, 'both');
            img = imresize(img, [28,28], 'box');
        else
            img = padarray(img, [20,20], 0, 'both');
          img = imresize(img, [28,28], 'box');  
        end
        input_img(:, m) = reshape(img.', [],1);
      end
%       feeding the data to the network
      [output, P] = convnet_forward(params, layers, input_img);
      [p, out_label] = max(P, [], 1);
%       # of correct predicted labels
      correct_pred = sum(labels{1,i}.' == out_label-1);
      fprintf("Testing on image %d, got %d correct labels out of %d\n",i, correct_pred, size(labels{1,i},1));

end
