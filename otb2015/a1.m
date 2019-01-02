clear;
clc;
train = dir('.\challenge');
str = '.\challenge';
str2 ='.\challenge2';
for i=3:length(train)
    path = fullfile(str,train(i).name);
    load(path);
    str3=[str2 '\' lower(train(i).name(1)) train(i).name(2:end)];
    save(str3,'type_num');
end
