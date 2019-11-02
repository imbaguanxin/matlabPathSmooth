function result = findScore(fromp,nextp,top)
%FINDSCORE Summary of this function goes here
%   Detailed explanation goes here
result = distance(fromp,nextp) + distance(nextp, top);
end

