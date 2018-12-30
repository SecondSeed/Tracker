function expert = calculateRelativeSimilarity(expert, expertNum, meanFirstSim, mfr, frame)
if meanFirstSim == 0
    upFirstSim = max([expert(:).fsim]);
else
upFirstSim = 1.1 * meanFirstSim;
end
for i = 1 : expertNum
    expert(i).hold(frame,:) = 1;
    expert(i).normfsim = (expert(i).fsim - mfr) / (upFirstSim - mfr);
end

for i = 1 : expertNum
    if expert(i).normfsim < 0
        expert(i).hold(frame,:) = 0;
    end
    if expert(i).normfsim > 1
        expert(i).normfsim = 1;
    end
    if expert(i).normfsim < 0
        expert(i).normfsim = 0;
    end
end