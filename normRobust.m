function expert = normRobust(expert, expertNum)
maxv = max([expert(:).RobScore]);
minv = min([expert(:).RobScore]);
for i = 1 : expertNum
    expert(i).normRobScore = (expert(i).RobScore - minv)/(maxv - minv);
end
end