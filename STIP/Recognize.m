% Project Title: Human Action Recognition
% Author: Manu B.N
% Contact: manubn88@gmail.com
% Main module of action recognition

close all
clear all
clc
load train_feat_new
load train_gs_new
k=1;
labels=[];
test_data=[];
for i=147
delete('test_frames\*.jpg');
    i
nm=sprintf('C:/cv_proj/fight_test/(%d).avi',i);
% [filename pathname] = uigetfile({'*.avi'},'Select A Video File'); 
I = VideoReader(nm); 
% I = VideoReader([pathname,filename]);
% implay([pathname,filename]);
% pause(3);
nFrames = I.numberofFrames;
vidHeight =  I.Height;
vidWidth =  I.Width;
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
       WantedFrames = 4;
for k = 1:WantedFrames
    mov(k).cdata = read( I, k);
   mov(k).cdata = imresize(mov(k).cdata,[256,256]);
    imwrite(mov(k).cdata,['test_frames\',num2str(k),'.jpg']);
end

for I = 1:WantedFrames
   im=imread(['test_frames\',num2str(I),'.jpg']);
   figure(1),subplot(2,2,I),imshow(im);
end
clc
for i=1:WantedFrames
%     disp(['Processing frame no.',num2str(i)]);
  img=imread(['test_frames\',num2str(i),'.jpg']);
  f1=il_rgb2gray(double(img));
  [ysize,xsize]=size(f1);
  nptsmax=40;   
  kparam=0.04;  
  pointtype=1;  
  sxl2=4;       
  sxi2=2*sxl2;  
  % detect points
  [posinit,valinit]=STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
  Test_Feat(i,1:40)=valinit;
  %imshow(f1,[]), hold on
 % axis off;
 % showellipticfeatures(posinit,[1 1 0]);
 % title('Feature Points','fontsize',12,'fontname','Times New Roman','color','Black')
end
test_data=[test_data;Test_Feat];
save test_data
% Use KNN To classify the videos
% load('TrainFeat.mat')
X = train_feat_new;
Y = train_gs_new;
Z = Test_Feat;
% Now Classify

%ens = fitensemble(X,Y,'Subspace',300,'KNN');
%class = predict(ens,Z(1,:))
% t = templateSVM('Standardize', 1);
% % % model=fitcecoc((train_data),(train_gs'),'Learners', t);
% md1 = fitcecoc(X,Y,'Learners', t);
% Type = mode(predict(md1,Z))
% Type=mode(Type);
md1 = ClassificationKNN.fit(X,Y);
Type = mode(predict(md1,Z))
if (Type == 1)
    disp('Fight');
    helpdlg(' Fight ');
elseif (Type == 2)
    disp('Non-Fight');
    helpdlg('Non-Fight');

end
% size(Type)
% for i=1:2
%     keys = find(Y~=i);
%     keys1 = find(test_gs~=i);
%     new_gs1 = test_gs;
%     new_gs = Y;
%     new_gs(keys)=0;
%     new_gs1(keys1)=0;
%     %optimset('svmtrain');
%     options = optimset('Display', 'off', 'MaxIter',100000);
%     %optnew = optimset(options);
% %     tic;
%     svstruct = svmtrain(X, new_gs','kktviolationlevel', 0.6,'options',options,'tolkkt',0.01);
% %     tm_tr(i) = toc;
% %     tic;
%     group = svmclassify(svstruct,Z)
% %     tm_ts(i) = toc;
% %     acc(i) =sum(group'==new_gs1)/202;
% %     C{i} = confusionmat(new_gs1,group');
%     
%   
%     
% end
labels=horzcat(labels,Type);
end   
save labels

