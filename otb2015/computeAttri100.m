clear all;
clc;

  seq = struct('name',{'basketball';'biker';'bird1';'bird2';'blurBody';'blurCar1';'blurCar2';'blurCar3';'blurCar4';
                        'blurFace';'blurOwl';'board';'bolt';'bolt2';'box';'boy';'car1';'car2';'car4';'car24';
                        'carDark';'carScale';'clifBar';'coke';'couple';'coupon'; 'crossing';'crowds';'dancer';
                        'dancer2';'david';'david2';'david3'; 'deer';'diving';'dog';'dog1';'doll';'dragonBaby';
                        'dudek';'faceocc1';'faceocc2';'fish';'fleetface';'football';'football1';'freeman1'; 'freeman3';
                        'freeman4';'girl';'girl2';'gym';'human2';'human3';'human4';'human5';'human6';'human7';'human8';
                        'human9';'ironman';'jogging-1';'jogging-2';'jump'; 'jumping';'kiteSurf';'lemming';'liquor';'man';
                        'matrix';'mhyang';'motorRolling';'mountainBike';'panda';'redTeam';'rubik';'shaking';'singer1';
                        'singer2';'skater';'skater2';'skating1';'skating2-1';'skating2-2';'skiing';'soccer';'subway';
                        'surfer';'suv';'sylvester';'tiger1';'tiger2';'toy';'trans';'trellis';'twinnings';'vase';
                        'walking';'walking2';'woman';});
 
typename = {'IV','OPR','SV','OCC','DEF','MB','FM','IPR','OV','BC','LR'};

str = '.\challenge';
str2 ='.\ours';
str3 ='.\ground_truth';

train = dir(str);
train2 = dir(str2);
train3 = dir(str3);

num = zeros(1,length(typename));
pixel_thres = 20;

for i = 1:length(typename)
    typename(i)  
    acc=[];
    ss =[];
    for j = 1 :length(seq)
%         j
       seqname =[seq(j).name '.mat'];
       str4 = fullfile(str,seqname);
       load(str4);
       if type_num( i ) == 1
            num(i)=num(i)+1;
            true_path = fullfile(str2,seqname );
            pred_path = fullfile(str3,seqname);
            load(true_path);
            load(pred_path);
%             result=results{1}.res;
            true_center = [truth_box(:,1)+0.5*truth_box(:,3)  truth_box(:,2)+0.5*truth_box(:,4)];
            pred_center = [result(:,1)+0.5*result(:,3)   result(:,2)+0.5*result(:,4)];
            dist = sqrt(sum(( pred_center - true_center ).^2,2));
            for k = 0:0.5:50
                dist_label = ( dist< k );
                acc =[ acc   sum(dist_label)/size(truth_box,1)];
            end
            
            leftA = result(:,1);                % 全部帧的追踪结果的左上点的x坐标
            bottomA = result(:,2);              % 全部帧的追踪结果的左上点的y坐标
            rightA = leftA + result(:,3) - 1;   % 追踪结果的右下点的x坐标
            topA = bottomA + result(:,4) - 1;   % 追踪结果的右下点的y坐标
     
            leftB = truth_box(:,1);                     % 真实场景的左上点的x坐标
            bottomB = truth_box(:,2);                   % 真实场景的左上点的y坐标
            rightB = leftB + truth_box(:,3) - 1;        % 真实场景的右下点的x坐标
            topB = bottomB + truth_box(:,4) - 1;        % 真实场景的右下点的y坐标
       
            tmp = (max(0, min(rightA, rightB) - max(leftA, leftB)+1 )) .* (max(0, min(topA, topB) - max(bottomA, bottomB)+1 ));
            areaA = result(:,3) .* result(:,4); 
            areaB = truth_box(:,3) .* truth_box(:,4); 
     
            tmp2 = tmp./(areaA+areaB-tmp);   
            for k = 0:0.001:1
                ss = [ss  sum(tmp2>k)/size( truth_box,1) ];
            end
            
       end            
    end
    distance_thres = 0 : 0.5 :50;
    sc = reshape(acc',101,num(i))';
    precsion_rate = mean( sc);
    precsion =precsion_rate(2*pixel_thres+1);
    
    ss2 = reshape(ss',1001,num(i))';
    success_rate = mean(ss2);
    overlap_thres = 0:0.001:1;

    ii = 0: 0.001:1;
    auc = trapz( ii,  success_rate )
 
    str6 =fullfile('.\',['ours_' typename{i} '.mat']);
   save(str6,'distance_thres','precsion_rate','precsion','overlap_thres','success_rate','auc');
    
end
