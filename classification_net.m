%Deep learning
%Tajwar, Julia
%Fine tuning alexnet on the skin cancer dataset

images = imageDatastore('E:\Girona\E-Health\Training\',...
                        'IncludeSubfolders',true,...
                        'LabelSource','foldernames');
                    
%Resize the images according to the input of the alexnet
images.ReadFcn = @(loc)imresize(imread(loc),[227 227]);

%dividing the dataset randomlyinto 80% for training, 20% for validation 
[trainingImages,validationImages] = splitEachLabel(images,0.8,'randomized');


numTrainImages = numel(trainingImages.Labels);
numClasses = numel(categories(trainingImages.Labels))

net = alexnet;
net.Layers;
layersTransfer = net.Layers(1:end-3); %taking all layers except the last final three layers

% %Uncomment if you want to add data augmentation of random rotations
% imageAugmenter = imageDataAugmenter('RandRotation',[-10 10]);
% datasource = augmentedImageSource(imageSize,trainingImages,'DataAugmentation',imageAugmenter)

%Defining new fine tuning layers consisting of two new fully connected
%layers of 1000 neurons and the last one of 3 neurons
layers = [
    layersTransfer
    fullyConnectedLayer(1000,'WeightLearnRateFactor',40,'BiasLearnRateFactor',40)
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',30,'BiasLearnRateFactor',30)
    softmaxLayer
    classificationLayer];

%Defining the training parameters of the network
miniBatchSize = 32;
numIterationsPerEpoch = floor(numel(images.Labels)/miniBatchSize);
options = trainingOptions('sgdm',...
    'MiniBatchSize',miniBatchSize,...
    'MaxEpochs',40,...
    'InitialLearnRate',1e-5,...
    'VerboseFrequency',numIterationsPerEpoch,...
    'Plots','training-progress',...
    'ValidationData',validationImages,...
    'ValidationFrequency',numIterationsPerEpoch,...
    'LearnRateDropFactor',0.01,...
    'Momentum',0.75,...
    'LearnRateDropPeriod',7,...
    'L2Regularization',0.004);


%Fine tuning the last layers of the network
netTransfer = trainNetwork(trainingImages,layers,options);

%Predicting the labels of the test set
predictedLabels = classify(netTransfer,validationImages);

%Checking accuracy of the results
valLabels = validationImages.Labels;
accuracy = mean(predictedLabels == valLabels)

%uncomment to save
%save('Classification_net','netTransfer')

%%for generating confusion matrix 
[C,order] = confusionmat(predictedLabels,valLabels)
plotConfMat(C)
