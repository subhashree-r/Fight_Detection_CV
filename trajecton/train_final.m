function [] = train_final(  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

load features_act
load features
load clust
% clust=clust_f;
% clust=normc(clust_f);
% load gs
num_test=800;
num_train=400;
k=300;
train_data_trials=[];
h=[];

% size(clust_f)
for u=1:num_train
    act=double(features_act{u}');
    n1 = size(clust,1);
    n2 = size(act,1);
    ci = sum(clust.^2, 2);
    xi = sum((act').^2, 1);
    %J=sum (sum(cluster_centre.^2+data_pt.^2-2*cluster_centre*data_pt))
    J = repmat(ci,1, n2) + repmat(xi, n1, 1) - 2*clust*act';
    %finding closest cluster for every feature
    [m,ind]=min(J,[],1);
    size(ind);
    
    train_data_trials(u,:)=histc(ind,1:k);
%     train_data_trials(u,:)=train_data_trials(u,:)/sum(train_data_trials(u,:));
end
% size(train_data_new);
save train_data_trials
end

