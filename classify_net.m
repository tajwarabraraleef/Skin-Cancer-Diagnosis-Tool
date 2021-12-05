%Function for classifying a new image 
function out = classify_net(image)  
%image is first resized to match the input dimension of AlexNet
image = imresize(image,[227 227]);

%Pretrained model is loaded
netTransfer = load('Classification_net.mat');
netTransfer = netTransfer.netTransfer;

%Predicting the labels of the test set
out = classify(netTransfer,image);
end

