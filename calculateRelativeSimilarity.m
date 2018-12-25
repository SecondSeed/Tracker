function expert = calculateRelativeSimilarity(expert, expertNum, meanFirstSim, meanLastSim, mfr, msr, frame)
if meanFirstSim == 0
    upFirstSim = max([expert(:).fsim]);
    upLastSim = max([expert(:).similarityScore]);
else
upFirstSim = 1.1 * meanFirstSim;
upLastSim = 1.1 * meanLastSim;
end
for i = 1 : expertNum
    expert(i).hold(frame,:) = 1;
    expert(i).normsimilarityScore = (expert(i).similarityScore - msr) / (upLastSim - msr);
    expert(i).normfsim = (expert(i).fsim - mfr) / (upFirstSim - mfr);
end

for i = 1 : expertNum
    if expert(i).normsimilarityScore < 0 | expert(i).normfsim < 0
        expert(i).hold(frame,:) = 0;
    end
    if expert(i).normsimilarityScore > 1
        expert(i).normsimilarityScore = 1;
    end
    if expert(i).normsimilarityScore < 0
        expert(i).normsimilarityScore = 0;
    end
    if expert(i).normfsim > 1
        expert(i).normfsim = 1;
    end
    if expert(i).normfsim < 0
        expert(i).normfsim = 0;
    end
end