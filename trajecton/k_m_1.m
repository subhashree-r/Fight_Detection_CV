function [clust ] = k_m_1( data,k )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% load gs
% load gs.train_D
% train_D
% size(data)
% k=300;
% 
t=randi(size(data,1),[1,k]);
id=eye(k);
%initialization
clust=data(t,:);%300*128
% size(clust)
for iter=1:40
%     disp(iter);
    new=[];
    for i=1:size(data,1)
        [D,I] = pdist2(clust,data(i,:),'euclidean','Smallest',1);
        new=horzcat(new,I);
    % (I)
    end
%     size(new)
    for j=1:k

        ind=find(new==k);
        c=mean(data(ind,:));
        clust(k,:)=c;
%         size(c)
    end
end
% size(clust)
end

