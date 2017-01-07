function [  ] = svm_try(  )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% load train_data_new
% load Test_data_new
% load test_data
% load train_data
load hockey_feat
load train_gs
load hockey_feat_test
% load test_data_soft
% load train_data_soft
% load spatial_pyr_test_new
% load spatial_pyr_train_new
% load gs
out=[];
% tic;
t = templateSVM('KernelFunction','gaussian'); 
size(hockey_feat)
size(train_gs)
model=fitcecoc((hockey_feat),(train_gs),'Learners', t);
% t1=toc;
% for i=1:800
% tic;
labels=predict(model,hockey_feat_test);
% t2=toc;
% size(labels)
% % out=horzcat(out,labels);
% % end
% % out=msvm(train_data_new,train_gs,Test_data_new)
% % out
% % size(out)
% % confusion_matrix=confusionmat(test_gs',labels)
% % accuracy=(sum(labels'==test_gs)/800)*100
% % t1
% % t2
save labels
% size(labels)
% load test_gs
test_gs=ones(202,1);
test_gs(101:202)=2;
acc=sum(labels==test_gs)/202
confusion_matrix=confusionmat(test_gs,labels)

end


