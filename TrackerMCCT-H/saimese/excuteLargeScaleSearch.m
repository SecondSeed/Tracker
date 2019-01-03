function [pos, targetSize, Similarity] = excuteLargeScaleSearch(im, lastpos, lastSz, firstFeature, saimese, s_x, avgChans)
dis = 2 * lastSz;
ltpos = lastpos - dis / 2;
rbpos = lastpos + dis / 2;
lbpos = [lastpos(1) + dis(1), lastpos(2) - dis(2)];
rtpos = [lastpos(1) - dis(1), lastpos(2) + dis(2)];
res = zeros(4, 5);
im_area = size(im, 1) * size(im, 2);
if 2 * dis(1) * dis(2) > im_area
    saimese.numScale = 9;
    [pos, targetSize, Similarity, response] = excuteMultiScaleSearch(im, ltpos, lastSz, firstFeature, saimese, s_x, avgChans);
    saimese.numScale = 3;
else
[pos, sz, sim, response] = excuteMultiScaleSearch(im, ltpos, lastSz, firstFeature, saimese, s_x, avgChans);
res(1,:) = [pos(1), pos(2), sz(1), sz(2), sim];
[pos, sz, sim, response] = excuteMultiScaleSearch(im, rbpos, lastSz, firstFeature, saimese, s_x, avgChans);
res(2,:) = [pos(1), pos(2), sz(1), sz(2), sim];
[pos, sz, sim, response] = excuteMultiScaleSearch(im, lbpos, lastSz, firstFeature, saimese, s_x, avgChans);
res(3,:) = [pos(1), pos(2), sz(1), sz(2), sim];
[pos, sz, sim, response] = excuteMultiScaleSearch(im, rtpos, lastSz, firstFeature, saimese, s_x, avgChans);
res(4,:) = [pos(1), pos(2), sz(1), sz(2), sim];
res = sortrows(res, 5, 'descend');
pos(1) = res(1,1);
pos(2) = res(1,2);
targetSize(1) = res(1,3);
targetSize(2) = res(1,4);
Similarity = res(1,5);
end
