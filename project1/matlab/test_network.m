%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

prediction = zeros(1,size(xtest,2));
%% Testing the network
% Modify the code to get the confusion matrix

 for i=1:100:size(xtest, 2)
     [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
     [p, out_label] = max(P, [], 1);
     prediction(:, i:i+99) = out_label;
 end
C = confusionmat(ytest, prediction);
confusionchart(C, [0:9])