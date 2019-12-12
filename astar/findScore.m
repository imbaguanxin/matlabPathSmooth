function [result, h] = findScore(fromp,nextp,top,fatherH,method)
%FINDSCORE Summary of this function goes here
%   Detailed explanation goes here
switch(method)
    case "diagnoal"
        x1 = nextp(1);
        y1 = nextp(2);
        x2 = top(1);
        y2 = top(2);
        g = abs(abs(x2-x1) - abs(y2-y1)) + ...
            sqrt(2) * min(abs(x2 - x1), abs(y2 - y1));
        h = distance(fromp,nextp) + fatherH;
        result = g + h;
    case "cartesian"
        h = distance(fromp,nextp) + fatherH;
        result = distance(top,nextp) + h;
    otherwise
        fprintf("you didn't specify score method, use cartesian distance\n");
        h = distance(fromp,nextp) + fatherH;
        result = distance(top,nextp) + h;
end
end

