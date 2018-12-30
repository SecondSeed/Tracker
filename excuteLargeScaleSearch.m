function [pos, targetSize, Similarity] = excuteLargeScaleSearch(im, lastpos, lastSz, firstFeature, saimese, s_x)
ltpos = lastpos - lastSz / 2;
rbpos = lastpos + lastSz / 2;
lbpos = [lastpos(1) + lastSz(1), lastpos(2) - lastSz(2)];
rtpos = [lastpos(1) - lastSz(1), lastpos(2) + lastSz(2)];
[newpos, newSz, newSimilarity] = excuteMultiScaleSearch(im, ltpos, lastSz, firstFeature, saimese, s_x);
[maxInstancePos, maxInstanceSz, maxSimilarity] = [newpos, newSz, newSimilarity];