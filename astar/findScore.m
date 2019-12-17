function [result, h] = findScore(fromp,nextp,top,fatherH,method)
%FINDSCORE Summary of this function goes here
%   Detailed explanation goes here
x0 = fromp(1);
y0 = fromp(2);
x1 = nextp(1);
y1 = nextp(2);
x2 = top(1);
y2 = top(2);
switch(method)
    case "diagnoal"
        g = abs(abs(x2-x1) - abs(y2-y1)) + ...
            sqrt(2) * min(abs(x2 - x1), abs(y2 - y1));
        h = distance(fromp,nextp) + fatherH;
        result = g + h;
    case "cartesian"
        h = distance(fromp,nextp) + fatherH;
        result = distance(top,nextp) + h;
    case "manhattan"
        h = fatherH + abs(x1 - x0) + abs(y1 - y0);
        g = abs(x1 - x2) + abs(y1 - y2) + h;
        result = g + h;
    otherwise
        fprintf("you didn't specify score method, use cartesian distance\n");
        h = distance(fromp,nextp) + fatherH;
        result = distance(top,nextp) + h;
end
end

