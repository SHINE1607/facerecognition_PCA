clc
clear all
S = [];                           %matrix to store the images as column vectors               
M = zeros(77760, 1)  ;            %array to store the mean of each image
%matrix to store the representative image
finalImg =  zeros(77760, 15);
correctCounttest = 0;
correctCounttrain = 0;
for i = 1:15
    
    if(i < 10)
        afilename = sprintf("./assignment2_data/yalefaces/s0%dcl.png", i);
        bfilename = sprintf("./assignment2_data/yalefaces/s0%dglass.png", i);
        cfilename = sprintf("./assignment2_data/yalefaces/s0%dhappy.png", i);
        dfilename = sprintf("./assignment2_data/yalefaces/s0%dll.png", i);
        efilename = sprintf("./assignment2_data/yalefaces/s0%dng.png", i);
        ffilename = sprintf("./assignment2_data/yalefaces/s0%dnorm.png", i);
        S = vertcat(S, reshape(imread(afilename),1,[]));
        S = vertcat(S, reshape(imread(bfilename),1,[]));
        S = vertcat(S, reshape(imread(cfilename),1,[]));
        S = vertcat(S, reshape(imread(dfilename),1,[]));
        S = vertcat(S, reshape(imread(efilename),1,[]));
        S = vertcat(S, reshape(imread(ffilename),1,[]));
    else
        afilename = sprintf("./assignment2_data/yalefaces/s%dcl.png", i);
        bfilename = sprintf("./assignment2_data/yalefaces/s%dglass.png", i);
        cfilename = sprintf("./assignment2_data/yalefaces/s%dhappy.png", i);
        dfilename = sprintf("./assignment2_data/yalefaces/s%dll.png", i);
        efilename = sprintf("./assignment2_data/yalefaces/s%dng.png", i);
        ffilename = sprintf("./assignment2_data/yalefaces/s%dnorm.png", i);
        S = vertcat(S, reshape(imread(afilename),1,[]));
        S = vertcat(S, reshape(imread(bfilename),1,[]));
        S = vertcat(S, reshape(imread(cfilename),1,[]));
        S = vertcat(S, reshape(imread(dfilename),1,[]));
        S = vertcat(S, reshape(imread(efilename),1,[]));
        S = vertcat(S, reshape(imread(ffilename),1,[]));
        
    end
end 

S = S';

%Here the Number of variable in the data 77760
%this will create a covariance matrix of size 77760*77760, which exceeds
%the memory limit, therefore we are taking 6 obserations as variable for
%each person, so we will get covariance matrix of size 6*6 for each subject

%loop to reperesent the represenative image
for i = 1:15
    %extracting the current subject
    Curr = S(:,(6*(i-1)+1):6*i);
    %array to store the mean of each pixel
    M = mean(Curr, 2);
    Curr = 255*im2double(Curr);
    %mean shifting
    M2 = repmat(M ,1 ,6);
    Curr = Curr - M2;                 
    CovCurr = cov(Curr);
    [PC, D] = eig(CovCurr);                        %compuing the eignevalues
    %finding the projection on the eigne vector corr to largest eigen value
    finalImg(:, i) = (Curr*PC(:, 6) + M);                                           	
end 


%for loop for finding the minumum eucledian distance between the
%represenattive the image and train data
filearrtrain = ["cl", "glass", "norm", "ng", "happy", "ll"];
k = 0;
for i = 1:15
    for j = 1:6
        if(i < 10)
            filename = sprintf("./assignment2_data/yalefaces/s0%d%s.png", i, filearrtrain(j));
        else
            filename = sprintf("./assignment2_data/yalefaces/s%d%s.png", i, filearrtrain(j));
        end
        currTrain = 255*im2double(reshape(imread(filename),1,[]));
        k = k+1;
        dist = pdist2(currTrain, finalImg');
        [minDistance, indexOfMinDistance] = min(dist);
        if(indexOfMinDistance == i)
            correctCounttrain = correctCounttrain + 1;
        end
        
    end 
end 
    
%for loop for finding the minumum eucledian distance between the
%represenattive the image and test data
filearr = ["wink", "surprised", "sleepy", "sad", "rightlight"];
for i = 1:15
    for j = 1:5
        if(i < 10)
            filename = sprintf("./assignment2_data/yalefaces/subject0%d.%s", i, filearr(j));
        else
            filename = sprintf("./assignment2_data/yalefaces/subject%d.%s", i, filearr(j));
        end
        currTest = (255*im2double(reshape(importdata(filename).cdata,1,[])))';
        dist = pdist2(currTest', finalImg');
        [minDistance, indexOfMinDistance] = min(dist);
        if(indexOfMinDistance == i)
            correctCounttest = correctCounttest + 1;
        end
    end 
end 
        










