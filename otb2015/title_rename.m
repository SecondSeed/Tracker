clear;
clc;
train = dir('CCOT');
str = '.\CCOT';
seq = struct('name',{'Basketball';'Biker';'Bird1';'Bird2';'BlurBody';'BlurCar1';'BlurCar2';'BlurCar3';'BlurCar4';'BlurFace';'BlurOwl';
              'Board';'Bolt';'Bolt2';'Box';'Boy';'Car1';'Car2';'Car4';'Car24';'CarDark';'CarScale';'ClifBar';'Coke';'Couple';'Coupon';
              'Crossing';'Crowds';'Dancer';'Dancer2';'David';'David2';'David3'; 'Deer';'Diving';'Dog';'Dog1';'Doll';'DragonBaby';
              'Dudek';'FaceOcc1';'FaceOcc2';'Fish';'FleetFace';'Football';'Football1';'Freeman1'; 'Freeman3';'Freeman4';'Girl';
              'Girl2';'Gym';'Human2';'Human3';'Human4';'Human5';'Human6';'Human7';'Human8';'Human9';'Ironman';'Jogging-1';'Jogging-2';
              'Jump'; 'Jumping';'KiteSurf';'Lemming';'Liquor';'Man';'Matrix';'Mhyang';'MotorRolling';'MountainBike';'Panda';
              'RedTeam';'Rubik';'Shaking';'Singer1';'Singer2';'Skater';'Skater2';'Skating1';'Skating2-1';'Skating2-2';'Skiing';
              'Soccer';'Subway';'Surfer';'Suv';'Sylvester';'Tiger1';'Tiger2';'Toy';'Trans';'Trellis';
              'Twinnings';'Vase';'Walking';'Walking2';'Woman';});
  
%   seq = struct('name',{'basketball';'biker';'bird1';'bird2';'blurBody';'blurCar1';'blurCar2';'blurCar3';'blurCar4';
%                         'blurFace';'blurOwl';'board';'bolt';'bolt2';'box';'boy';'car1';'car2';'car4';'car24';
%                         'carDark';'carScale';'clifBar';'coke';'couple';'coupon'; 'crossing';'crowds';'dancer';
%                         'dancer2';'david';'david2';'david3'; 'deer';'diving';'dog';'dog1';'doll';'dragonBaby';
%                         'dudek';'faceocc1';'faceocc2';'fish';'fleetface';'football';'football1';'freeman1'; 'freeman3';
%                         'freeman4';'girl';'girl2';'gym';'human2';'human3';'human4';'human5';'human6';'human7';'human8';
%                         'human9';'ironman';'jogging-1';'jogging-2';'jump'; 'jumping';'kiteSurf';'lemming';'liquor';'man';
%                         'matrix';'mhyang';'motorRolling';'mountainBike';'panda';'redTeam';'rubik';'shaking';'singer1';
%                         'singer2';'skater';'skater2';'skating1';'skating2-1';'skating2-2';'skiing';'soccer';'subway';
%                         'surfer';'suv';'sylvester';'tiger1';'tiger2';'toy';'trans';'trellis';'twinnings';'vase';
%                         'walking';'walking2';'woman';});

for i = 3:length(train)
    i
    str2 = fullfile(str,train(i).name);
    load(str2)
    aa = results{1};
    result =aa.res;
%     index = findstr(train(i).name,'_');
    index2 = findstr(train(i).name,'.');
    str3 = train(i).name(1:index2-1);
    fla=zeros(1,length(seq));
    for j=1:length(seq)
         fla(j)=strcmp(seq(j).name,str3) ;
    end
    if sum(fla)==1
    str4 = [str '\' [lower(str3(1)) str3(2:end)] '.mat'];
    save(str4,'result');
    end
end