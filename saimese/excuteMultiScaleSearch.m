function [targetPosition, targetSize, similarity, response] = excuteMultiScaleSearch(cpu_im, targetPosition, targetSize, z_features, p, s_x, avgChans)
im = cpu_im;
window = make_window(p);
% if grayscale repeat one channel to match filters size
if(size(im, 3)==1)
    im = repmat(im, [1 1 3]);
end
scales = (p.scaleStep .^ ((ceil(p.numScale/2)-p.numScale) : floor(p.numScale/2)));
scaledInstance = s_x .* scales;
scaledTarget = [targetSize(1) .* scales; targetSize(2) .* scales];
% extract scaled crops for search region x at previous target position
x_crops = make_scale_pyramid(im, targetPosition, scaledInstance, p.instanceSize, avgChans, p);
% evaluate the offline-trained network for exemplar x features
[newTargetPosition, newScale, response] = tracker_eval(p.net_x, round(s_x), p.scoreId, z_features, x_crops, targetPosition, window, p);
similarity = max(response(:));
targetPosition = gather(newTargetPosition);
% scale damping and saturation
%s_x = max(min_s_x, min(max_s_x, (1-p.scaleLR)*s_x + p.scaleLR*scaledInstance(newScale)));
targetSize = (1-p.scaleLR)*targetSize + p.scaleLR*[scaledTarget(1,newScale) scaledTarget(2,newScale)];