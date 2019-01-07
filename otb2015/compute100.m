clear;
clc;

%% 加载ground_truth的box
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
 
          

 %% 计算中心误差
 num_seq = length(seq);
 str = '.\ground_truth';      %ground_truth所在的位置
 str2 = '.\ours';              %预测结果所在位置
 seq_acc =[ ];
 seq_num =[ ];
 pixel_thres = 20;
 deal = 1;
 if deal == 1
 tigerpath = fullfile(str2, 'tiger1.mat');
 tiger = load(tigerpath);
 tiger = tiger.res;
 res = tiger(6:end,:);
 save('.\ours\tiger1.mat', 'res');
 end
 for i = 1 :length(seq)
     true_path = fullfile(str,[seq(i).name '.mat']);
     pred_path = fullfile(str2,[seq(i).name '.mat']);
     load(true_path);
     res = load(pred_path);
     result = res.res;
%      result=results{1}.res;
     true_center = [truth_box(:,1)+0.5*truth_box(:,3)  truth_box(:,2)+0.5*truth_box(:,4)];
     pred_center = [result(:,1)+0.5*result(:,3)   result(:,2)+0.5*result(:,4)];
     dist = sqrt(sum(( pred_center - true_center ).^2,2));
     for j = 0:0.5:50
         dist_label = ( dist< j );
         seq_acc =[ seq_acc   sum(dist_label)/size(truth_box,1)];
     end
 end
 sc = reshape( seq_acc',101,100)';
 precsion_rate = mean( sc);
 distance_thres = 0 : 0.5 :50;
 precsion =precsion_rate(2*pixel_thres+1)
 
  %% 计算重叠率 
 seq_overlap =[ ];
 ss = [ ];
 for i = 1 : length(seq)
%      i
     true_path = fullfile(str,[seq(i).name '.mat']);
     pred_path = fullfile(str2,[seq(i).name '.mat']);
     load(true_path);
     res = load(pred_path);
     result = res.res;
%        result=results{1}.res;
%      ss = sum(result.^2,2);
%      index = isnan(ss);
%      rr = result;
%      result(index,:) = 0;
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
     for j = 0:0.001:1
         ss = [ss  sum(tmp2>j)/size( truth_box,1) ];
     end
 end
 
 ss2 = reshape(ss',1001,100)';
 success_rate = mean(ss2);
 
 overlap_thres = 0:0.001:1;

 i = 0: 0.001:1;
 auc = trapz( i,  success_rate )
 
%    save('.\ours_overall.mat','distance_thres','precsion_rate','precsion','overlap_thres','success_rate','auc')
 