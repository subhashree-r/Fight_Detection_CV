function [accuracy, confusion] = CNN_FeatureExtraction

% Setup MatConvNet
run('/Users/bedouralbahar/Documents/MATLAB/matconvnet-1.0-beta23/matlab/vl_compilenn.m');
run('/Users/bedouralbahar/Documents/MATLAB/matconvnet-1.0-beta23/matlab/vl_setupnn.m');

% Load CNN pretrained model
net = load('imagenet-vgg-f.mat');
cnnModel.net = vl_simplenn_tidy(net);

% Load images from folder
% Use imageSet to load images stored in DataSet folder
imset = imageSet('DataSetTrain','recursive');

% Preallocate arrays with fixed size for prediction
imageSize = cnnModel.net.meta.normalization.imageSize;

% Load and resize images for prediction
current = 1;
for ii = 1:numel(imset)
  for jj = 1:imset(ii).Count
      I = read(imset(ii),jj);
      if ismatrix(I)
            I = cat(3,I,I,I);
      end
      
      trainingImages(:,:,:,current) = imresize(single(I),imageSize(1:2));
      current = current + 1;
  end
end

% Get the image labels
trainingLabels = getImageLabels(imset);
summary(trainingLabels) % Display class label distribution

% Extract features using pretrained CNN
% Depending on how much memory you have, you may use a larger batch size
cnnModel.info.opts.batchSize = 1500;

% Make prediction on a CPU
[~, cnnFeatures, timeCPU] = cnnPredict(cnnModel,trainingImages,'UseGPU',false);

% Train a classifier using extracted features
% Using linear support vector machine (SVM) classifier.
svmmdl = fitcsvm(cnnFeatures,trainingLabels);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for testing..
% Load images from folder
% Use imageSet to load images stored in DataSet folder
imset2 = imageSet('DataSetTest','recursive');

% Preallocate arrays with fixed size for prediction
imageSize = cnnModel.net.meta.normalization.imageSize;

% Load and resize images for prediction
current = 1;
for ii = 1:numel(imset2)
  for jj = 1:imset2(ii).Count
      I = read(imset2(ii),jj);
      if ismatrix(I)
            I = cat(3,I,I,I);
      end      
      testingImages(:,:,:,current) = imresize(single(I),imageSize(1:2));
      current = current + 1;
  end
end

% Get the image labels
testingLabels = getImageLabels(imset2);
summary(testingLabels) % Display class label distribution

% Extract features using pretrained CNN
% Depending on how much memory you have, you may use a larger batch size
cnnModel.info.opts.batchSize = 1000;
% Make prediction on a CPU
[~, cnnFeatures2, timeCPU2] = cnnPredict(cnnModel,testingImages,'UseGPU',false);


%classify the test set
label = predict(svmmdl,cnnFeatures2);

%compute the accuracy
equal = label == testingLabels;
accuracy = 100 * mean(equal);

%confusion matrix
confusion = zeros(2,2);
for i=1:2000
    if (i<=1000)
        %fight images
        if (testingLabels(i)==label(i))
            %this correctly classified as fight
            confusion(1, 1) = confusion(1, 1) + 1;
        else
            %this incorrectly classified as nonfight
            confusion(1, 2) = confusion(1, 2) + 1;
        end
    else
        %nonFight images
        if (testingLabels(i)==label(i))
            %this correctly classified as nonfight
            confusion(2, 2) = confusion(2, 2) + 1;
        else
            %this incorrectly classified as fight
            confusion(2, 1) = confusion(2, 1) + 1;
        end
    end
    %confusion(testingLabels(i), label(i)) = confusion(testingLabels(i), label(i)) + 1;
end


end