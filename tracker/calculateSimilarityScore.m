function similarityScore = calculateSimilarityScore(pos, last_pos, saimese_response, s_x)
disp = pos - last_pos;
response_size = size(saimese_response, 1);
response_center = ceil([response_size, response_size] / 2);
disp = disp * response_size / s_x;
response_pos = ceil(response_center + disp);
%cpu_response = gather(saimese_response);
similarityScore = saimese_response(response_pos(1), response_pos(2));