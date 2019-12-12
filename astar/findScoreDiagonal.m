function result = findScoreDiagonal(fromp,nextp,top)
%FINDSCORE Summary of this function goes here
%   Detailed explanation goes here
x1 = nextp(1);
y1 = nextp(2);
x2 = top(1);
y2 = top(2);
g = abs(abs(x2-x1) - abs(y2-y1)) + sqrt(2) * min(abs(x2 - x1),abs(y2 - y1));
h = min(distance(fromp,nextp), 1.414);
result = g + h;
end

