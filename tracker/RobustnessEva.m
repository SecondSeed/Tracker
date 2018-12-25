function Reliability = RobustnessEva(expert, num, frame, period, weight, expertNum)
% Calculate robustness score of each expert
   
   OverlapScore(period, expertNum) = 0;
   for i = 1 : expertNum 
      Overlap = calcRectInt( expert(num).rect_position(frame - period + 1:frame,:) , expert(i).rect_position(frame - period + 1:frame,:) );
      for j = frame - period + 1 : frame
          if expert(num).hold(j) == 0 | expert(i).hold(j) == 0
              Overlap(j - frame + period) = 0;
          end
      end
      OverlapScore(:,i) = exp(-(1 - Overlap).^2);    
   end
   % the average overlap
   AveOP = sum(OverlapScore, 2)/expertNum;           
   % the average overlap for each tracker in a period for variance computation
   expertAveOP = sum(OverlapScore, 1)/period;        
   VarOP = sqrt( sum((OverlapScore - repmat(expertAveOP, period ,1) ).^2, 2)/expertNum );  % the variance
   % temporal stability
   norm_factor = 1/sum(weight);
   WeightAveOP = norm_factor*(weight*AveOP);
   WeightVarOP = norm_factor*(weight*VarOP);
   PairScore = WeightAveOP./(WeightVarOP+0.008); 
   Reliability = PairScore;

end

