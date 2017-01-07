    function [  ] = klt_track_new(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

features=[];
features_act={};
l=1;
feat_trial=[];
feat_trial_D={};

for j=1:400
%     i
tr_per_vid=[];
nm=sprintf('C:/cv_proj/HockeyFights/(%d).avi',j);
% nm=sprintf('C:/cv_proj/fight_test/(%d).avi',i);
% j
obj=VideoReader(nm);
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);


points={};
point_temp=[];
frames={};
tempa=[];
for i=1:11

    frames{i}=read(obj,i);
    im=rgb2gray((frames{i}));
    if i==1     
      point1 = (detectHarrisFeatures(im));
%       point_temp=point1.selectStrongest(5);
      point_temp=point1.Location;
      initialize(pointTracker,point_temp,im);
      points{1}=point_temp;
      oldPoints=points{1};
    else
        [points{i},isFound] = step(pointTracker,im);
        temp=reshape(points{i},1,numel(points{i}));
        visiblePoints = points{i}(isFound, :);
        oldInliers = oldPoints(isFound, :);
        if size(visiblePoints, 1) >= 2 % need at least 2 points

        % Estimate the geometric transformation between the old points
        % and the new points and eliminate outliers
            [xform, oldInliers, visiblePoints] = estimateGeometricTransform(oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);
%             size(xform)
%             tempa=horzcat(tempa,temp');
            oldPoints = visiblePoints;
            setPoints(pointTracker, oldPoints);
            size(xform);
            xform.T;
%             norsm(xform);
            
            temp=reshape(xform.T,1,9);
            tr_per_vid=horzcat(tr_per_vid,temp);
            
            
        end
%         points{i}=temp1;


    end
    
end
size(tr_per_vid);
if(size(tr_per_vid,2)==90)
    feat_trial=vertcat(feat_trial,tr_per_vid);
    feat_trial_D{l}=tr_per_vid;
    l=l+1;
else
    j

% save xform
end
% save feat_trial
% save feat_trial_D
end
for j=1:400
%     i
tr_per_vid=[];
nm=sprintf('C:/cv_proj/HockeyFights_no/(%d).avi',j);
% nm=sprintf('C:/cv_proj/fight_test/(%d).avi',i);
% j
obj=VideoReader(nm);
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);


points={};
point_temp=[];
frames={};
tempa=[];
for i=1:11

    frames{i}=read(obj,i);
    im=rgb2gray((frames{i}));
    if i==1     
      point1 = (detectHarrisFeatures(im));
%       point_temp=point1.selectStrongest(5);
      point_temp=point1.Location;
      initialize(pointTracker,point_temp,im);
      points{1}=point_temp;
      oldPoints=points{1};
    else
        [points{i},isFound] = step(pointTracker,im);
        temp=reshape(points{i},1,numel(points{i}));
        visiblePoints = points{i}(isFound, :);
        oldInliers = oldPoints(isFound, :);
        if size(visiblePoints, 1) >= 2 % need at least 2 points

        % Estimate the geometric transformation between the old points
        % and the new points and eliminate outliers
            [xform, oldInliers, visiblePoints] = estimateGeometricTransform(oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);
%             size(xform)
%             tempa=horzcat(tempa,temp');
            oldPoints = visiblePoints;
            setPoints(pointTracker, oldPoints);
            size(xform);
            xform.T;
%             norsm(xform);
            
            temp=reshape(xform.T,1,9);
            tr_per_vid=horzcat(tr_per_vid,temp);
            
            
        end
%         points{i}=temp1;


    end
    
end
size(tr_per_vid);
if(size(tr_per_vid,2)==90)
    feat_trial=vertcat(feat_trial,tr_per_vid);
    feat_trial_D{l}=tr_per_vid;
    l=l+1;
else
    j

% save xform
end
save feat_trial
save feat_trial_D
end


