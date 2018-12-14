function score = calculateOpticalScore(flow, last_pos, last_rect, pos, rect)
%   Ximing Xiang 2018
plt = pos - rect / 2;
plb = plt + [rect(1), 0];
prt = plt + [0, rect(2)];
prb = plt + rect;
yv = [plt(1), plb(1), prb(1), prt(1)];
xv = [plt(2), plb(2), prb(2), prt(2)];
all = 0;
in = 0;
slice = getSlice(size(flow.Vx),last_pos, last_rect);
oflow.Vx = flow.Vx(slice.y, slice.x);
oflow.Vy = flow.Vy(slice.y, slice.x);

score = 1;