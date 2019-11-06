function [a,b,c] = getLineFromPts(point1,point2,center)
%GETLINEFROMPTS find a line, point1 and point2 shows the slop; center shows
%which point it goes through
x0 = point1(1);
y0 = point1(2);
x1 = point2(1);
y1 = point2(2);
dx = x0 - x1;
dy = y0 - y1;
if (dx == 0)
    a = 1;
    b = 0;
    c = -center(1);
elseif (dy == 0)
    a = 0;
    b = 1;
    c = -center(2);
else
    k = dy / dx;
%     disp(k);
    a = k;
    b = -1;
    c = center(2) - k * center(1);
end

