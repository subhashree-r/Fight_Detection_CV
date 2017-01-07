function [  ] = train(  )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% train_feat=[];
load train_feat_new
% train_feat_new=[];

for i=1:400
    i
delete('New_frames\*.jpg');
% for j=1:400
nm=sprintf('C:/cv_proj/HockeyFights_no/(%d).avi',i);
% nm=sprintf('C:/cv_proj/Peliculas/AVI/(%d).avi',i);
% nm=sprintf('C:/cv_proj/Peliculas/fights/(%d).avi',i);

I = VideoReader(nm); 
% implay(nm);
% pause(3);
nFrames = I.numberofFrames;
vidHeight =  I.Height;
vidWidth =  I.Width;
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
WantedFrames = 20;
for k = 1:WantedFrames
    mov(k).cdata = read( I, k);
   mov(k).cdata = imresize(mov(k).cdata,[256,256]);
    imwrite(mov(k).cdata,['New_frames\',num2str(k),'.jpg']);
end

for I = 1:WantedFrames
   im=imread(['New_frames\',num2str(I),'.jpg']);
    figure(1),subplot(5,10,I),imshow(im);
end

for i=1:WantedFrames
%   disp(['Processing frame no.',num2str(i)]);
  img=imread(['New_frames\',num2str(i),'.jpg']);
  f1=il_rgb2gray(double(img));
  [ysize,xsize]=size(f1);
  nptsmax=40;   
  kparam=0.04;  
  pointtype=1;  
  sxl2=4;       
  sxi2=2*sxl2;  
  % detect points
  [posinit,valinit]=STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
  train_feat(i,1:40)=valinit;
  %imshow(f1,[]), hold on
 % axis off;
 % showellipticfeatures(posinit,[1 1 0]);
 % title('Feature Points','fontsize',12,'fontname','Times New Roman','color','Black')
end
train_feat_new=[train_feat_new;train_feat];
% Use KNN To classify the videos
% load('TrainFeat.mat')
% X = meas;
% Y = New_Label;
% Z = Test_Feat;
% Now Classify

end
% save train_feat_new
% for j=1:400
%     j
% delete('New_frames\*.jpg');
% % for j=1:400
% nm=sprintf('C:/cv_proj/HockeyFights_no/(%d).avi',j);
% % nm=sprintf('C:/cv_proj/Peliculas/AVI/(%d).avi',i);
% % nm=sprintf('C:/cv_proj/Peliculas/fights/(%d).avi',i);
% 
% I = VideoReader(nm); 
% % implay(nm);
% % pause(3);
% nFrames = I.numberofFrames;
% vidHeight =  I.Height;
% vidWidth =  I.Width;
% mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
% WantedFrames = 20;
% for k = 1:WantedFrames
%     mov(k).cdata = read( I, k);
%    mov(k).cdata = imresize(mov(k).cdata,[256,256]);
%     imwrite(mov(k).cdata,['New_frames\',num2str(k),'.jpg']);
% end
% 
% for I = 1:WantedFrames
%    im=imread(['New_frames\',num2str(I),'.jpg']);
%     figure(1),subplot(5,10,I),imshow(im);
% end
% 
% for i=1:WantedFrames
% %   disp(['Processing frame no.',num2str(i)]);
%   img=imread(['New_frames\',num2str(i),'.jpg']);
%   f1=il_rgb2gray(double(img));
%   [ysize,xsize]=size(f1);
%   nptsmax=40;   
%   kparam=0.04;  
%   pointtype=1;  
%   sxl2=4;       
%   sxi2=2*sxl2;  
%   % detect points
%   [posinit,valinit]=STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
%   train_feat(i,1:40)=valinit;
%   %imshow(f1,[]), hold on
%  % axis off;
%  % showellipticfeatures(posinit,[1 1 0]);
%  % title('Feature Points','fontsize',12,'fontname','Times New Roman','color','Black')
% end
% train_feat_new=[train_feat_new;train_feat];
% % Use KNN To classify the videos
% % load('TrainFeat.mat')
% % X = meas;
% % Y = New_Label;
% % Z = Test_Feat;
% % Now Classify
% 
% end
save train_feat_new
end

